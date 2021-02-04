class RegistrationsController < Devise::RegistrationsController
  def create
    invite = verify_invite

    super do |resource|
      if invite.present?
        resource.update(role: 'elf')
        invite.update(status: 'done')
      end
    end
  end

  private

  def verify_invite
    token = params['invite_token']
    invite = Invitation.find_by(token: token)
    if token.present? && (invite.nil? || !invite.pending?)
      redirect_to new_user_registration_path, alert: 'Invalid token'
      return
    end
    invite
  end
end
