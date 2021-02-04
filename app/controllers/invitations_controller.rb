class InvitationsController < ApplicationController
  load_and_authorize_resource

  def index
    @invitations = @invitations.order(:status)
    @invitation = Invitation.new
  end

  def create
    if @invitation.save
      redirect_to invitations_path, notice: 'Invite was successfully sent'
    else
      redirect_to invitations_path, alert: @invitation.errors.full_messages_for(:email)[0]
    end
  end

  def destroy
    @invitation.destroy
    redirect_to invitations_path, notice: 'Invite was successfully destroyed'
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email)
  end
end
