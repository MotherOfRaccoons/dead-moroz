class CongratulationMailer < ApplicationMailer
  HONORIFICS = {
    'male'       => 'Mr.',
    'female'     => 'Ms.',
    'non_binary' => 'Mx.'
  }.freeze

  def congratulation_email(user)
    @name = user.first_name
    @honorific = HONORIFICS[user.gender]
    mail to: user.email, subject: 'Letter of gratitude'
  end
end
