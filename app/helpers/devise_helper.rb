module DeviseHelper
  def confirmed_email(resource)
    resource.pending_reconfirmation? ? resource.unconfirmed_email : resource.email
  end
end

