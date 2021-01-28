# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    case
    when user.kid?
      can :show,   User, id: user.id
      can :manage, Gift, added_by: user
      can :manage, Image, gift: { added_by: user }
    when user.elf?
      can :manage, User, role: 'kid'
      can :read,   Gift
      can %i[update create destroy], Gift, added_by: user
      can :manage, Image, gift: { added_by: user }
      can %i[show create destroy], Assessment, author: user
      can :manage, Review, reviewer: user
    when user.santa?
      can :index,  User, role: %w[kid elf]
      can :read,   User, role: 'kid'
      can :read,   Gift
      can :read,   Assessment
      can %i[read destroy], Review
    when user.admin?
      can :manage, :all
    end
  end
end
