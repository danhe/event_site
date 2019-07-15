# frozen_string_literal: true

# SessionsController
class Api::V1::SessionsController < Api::V1::BaseController
  before_action :load_user

  def create
    if @user && @user&.authenticate(params[:password])
      self.current_user = @user

      render json: @user, serializer: Api::V1::UserSerializer, status: :ok
    else
      @user = User.new(email: params[:email])
      @user.errors.add(:email, 'Your login maybe not right')
      @user.errors.add(:password, 'Your login and password are not match')
      unauthenticated!(@user.errors)
    end
  end

  def destroy
    api_success(json_data: {message: 'Logout successfully'})
  end

  private

  def load_user
    @user = User.find_by_email(params[:email])
  end
end
