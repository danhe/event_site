# frozen_string_literal: true

# InvitationsController
# All invitation methods here
class Api::V1::InvitationsController < Api::V1::BaseController
  before_action :load_user

  def create
    if @user
      MagicLinkMailer.magic_link_email(@user).deliver!
      msg = 'Email has been sent'
    else
      msg = 'ALreay invited'
    end

    api_success(message: msg)
  end

  private

  def load_user
    @user = User.find_by_email(params[:email]) || User.create(email: params[:email])
  end
end
