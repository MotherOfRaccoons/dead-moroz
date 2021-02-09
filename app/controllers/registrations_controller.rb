class RegistrationsController < Devise::RegistrationsController
  before_action :verify_invite

  def create
    super do |resource|
      if invite.present?
        resource.update(role: 'elf')
        invite.accept!
      end
    end
  end

  private

  def verify_invite
    token = params[:invite_token]
    redirect_to(new_user_registration_path(token: token), alert: 'Invalid token') unless token.blank? || invite.try(:pending?)
  end

  def invite
    @invite ||= Invitation.find_by(token: params[:invite_token])
  end
end
