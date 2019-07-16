class MagicLinkMailer < ApplicationMailer
  default from: 'Admin<invitation@event.com>'

  def magic_link_email(user)
    @user = user
    @application_url = application_frontend_url
    mail(to: @user.email, subject: 'Invitation')
  end

  private

  def application_frontend_url
    return 'https://events-reservation-frontend.danhe.now.sh' if Rails.env.production?

    'http://localhost:8080'
  end
end
