class CongratulationMailer < ApplicationMailer
  def congratulation_email(user)
    @name = user.first_name
    @honorific = 
      case user.gender
        when 'male' then 'Mr.'
        when 'female' then 'Ms.'
        when 'non_binary' then 'Mx.'
      end
    mail to: user.email, subject: 'Letter of gratitude'
  end
end
