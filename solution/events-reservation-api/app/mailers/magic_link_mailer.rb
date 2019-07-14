class MagicLinkMailer < ApplicationMailer
  default from: 'Admin<invitation@event.com>'

  def magic_link_email(user)
    @user = user
    mail(to: @user.email, subject: 'Invitation')
  end
end
