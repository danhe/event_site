# frozen_string_literal: true

# SessionsController
class Api::V1::SessionsController < Api::V1::BaseController
  before_action :load_user

  def create
    if @user && @user&.authenticate(params[:password])
      session[:user_id] = @user.id

      render json: @user, serializer: Api::V1::UserSerializer, status: :ok
    else
      unauthenticated!
    end
  end

  private

  def load_user
    @user = User.find_by_email(params[:email])
  end
end
