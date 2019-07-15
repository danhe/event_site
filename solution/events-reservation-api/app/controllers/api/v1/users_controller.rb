class Api::V1::UsersController < Api::V1::BaseController  
  before_action :user_by_token

  def update
    return invalid_token! if @user.nil?
    return empty_password! if params[:register][:password].empty?
    return not_same_password! if not_same_password_condition

    if @user.update_attributes(register_params)
      @user&.after_updated_psd(register_params[:password])

      render json: @user, serializer: Api::V1::UserSerializer, status: :ok
    else
      invalid_resource!(@user.errors)
    end
  end

  def show
    if @user
      api_success(json_data: { is_valid_token: true })
    else
      invalid_resource!(@user&.errors)
    end
  end

  private

  def user_by_token
    @user = User.find_by_token(params[:token])
  end

  def register_params
    params.require(:register).permit(:password, :password_confirmation)
  end

  def invalid_token!
    @user = User.new
    @user.errors.add(:token, 'The token is not valid')
    invalid_resource!(@user.errors)
  end

  def empty_password!
    @user.errors.add(:password, "can't be empty")
    invalid_resource!(@user.errors)
  end

  def not_same_password_condition
    params[:register][:password] != params[:register][:password_confirmation]
  end

  def not_same_password!
    @user.errors.add(:password_confirmation, 'The passwords are not the same')
    invalid_resource!(@user.errors)
  end
end
