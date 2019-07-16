# frozen_string_literal: true

# InvitationsController
# All invitation methods here
class Api::V1::InvitationsController < Api::V1::BaseController
  before_action :authenticate_user!
  before_action :check_admin_access!
  before_action :load_user

  def create
    if @user.valid?
      MagicLinkMailer.magic_link_email(@user).deliver!
      json_data = {
        message: 'Email has been sent successfully',
        email_sent: true
      }
    else
      json_data = {
        message: 'Email has been alreay invited',
        email_warning: true
      }
    end

    api_success(json_data: json_data)
  end

  private

  def load_user
    @user = User.create(email: params[:email])
  end
end
