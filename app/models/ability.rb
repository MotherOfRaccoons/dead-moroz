# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    case user.role
    when 'kid'
      can :show, User, id: user.id
      can :show, Gift, recipient: user
      can %i[index update create destroy], Gift, added_by: user
      can :manage, Image, gift: { added_by: user }
    when 'elf'
      can :read, User
      can :read, Gift, recipient: { role: 'kid' }
      can %i[create update destroy], Gift, added_by: user, recipient: { role: 'kid' }
      can :manage, Image, gift: { added_by: user }
      can :show, Assessment, target: { role: 'kid' }
      can %i[show create destroy], Assessment, author: user, target: { role: 'kid' }
      can :show, Review, reviewee: { role: 'kid' }
      can %i[create destroy], Review, reviewer: user, reviewee: { role: 'kid' }
    when 'santa'
      can :read, User
      can %i[read toggle_selected], Gift, recipient: { role: 'kid' }
      can %i[create update destroy], Gift, added_by: user, recipient: { role: 'kid' }
      can :manage, Image, gift: { added_by: user }
      can :read,   Assessment, target: { role: 'kid' }
      can %i[create destroy], Assessment, author: user, target: { role: 'kid' }
      can %i[show destroy], Review, reviewee: { role: 'kid' }
      can :create, Review, reviewer: user, reviewee: { role: 'kid' }
      can :manage, Invitation
    when 'admin'
      can :manage, :all
    end
  end
end
