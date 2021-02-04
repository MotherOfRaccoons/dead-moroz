# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    case user.role
    when 'kid'
      can :show,   User, id: user.id
      can :crud,   Gift, added_by: user
      can :manage, Image, gift: { added_by: user }
    when 'elf'
      can :manage, User, role: 'kid'
      can :read,   Gift
      can %i[create update destroy], Gift, added_by: user
      can :manage, Image, gift: { added_by: user }
      can %i[show create destroy], Assessment, author: user
      can :manage, Review, reviewer: user
    when 'santa'
      can :index,  User, role: %w[kid elf]
      can :read,   User, role: 'kid'
      can %i[read toggle_selected], Gift
      can %i[create update destroy], Gift, added_by: user
      can :manage, Image, gift: { added_by: user }
      can :manage, Assessment, author: user
      can :create, Review, reviewer: user
      can %i[read destroy], Review
      can :manage, Invitation
    when 'admin'
      can :manage, :all
    end
  end
end
