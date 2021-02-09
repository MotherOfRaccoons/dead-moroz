class CongratulationMailer < ApplicationMailer
  def congratulation_email(email, first_name, gender)
    @name = first_name
    @honorific = 
      case gender
        when 'male' then 'Mr.'
        when 'female' then 'Ms.'
        when 'non_binary' then 'Mx.'
      end
    mail to: email, subject: 'Letter of gratitude'
  end
end
