module DeviseHelper
  PLACEHOLDER_AVATAR = 'https://dead-moroz.s3.eu-west-3.amazonaws.com/placeholder.jpg'.freeze

  def confirmed_email(resource)
    resource.pending_reconfirmation? ? resource.unconfirmed_email : resource.email
  end

  def avatar_url
    user_signed_in? ? current_user.avatar.url : PLACEHOLDER_AVATAR
  end
end

