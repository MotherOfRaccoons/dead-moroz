class RegistrationsController < Devise::RegistrationsController
  def create
    verify_invite { return }
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
    unless token.blank? || invite.try(:pending?)
      redirect_to new_user_registration_path, alert: 'Invalid token'
      yield
    end
  end

  def invite
    @invite ||= Invitation.find_by(token: params[:invite_token])
  end
end
