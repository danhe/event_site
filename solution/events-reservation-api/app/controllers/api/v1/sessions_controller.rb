class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {
        message: 'Logined'
      }, status: :ok
    else
      unauthenticated!
    end
  end
end
