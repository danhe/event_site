class Api::V1::UsersController < Api::V1::BaseController

  before_action :user_by_token

  def update
    return empty_password! if params[:register][:password].empty?

    if @user.update_attributes(register_params)
      @user&.authenticate(register_params[:password])

      api_success(json_data: {message: 'Password has been set successfullt.'})
    else
      invalid_resource!(@user.errors)
    end
  end

  private

  def user_by_token
    @user = User.find_by_token(params[:token])
  end

  def register_params
    params.require(:register).permit(:password, :password_confirmation)
  end

  def empty_password!
    @user.errors.add(:password, "can't be empty")
    invalid_resource!(@user.errors)
  end
end
