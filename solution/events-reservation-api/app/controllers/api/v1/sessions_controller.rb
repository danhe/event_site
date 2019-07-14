# frozen_string_literal: true

# SessionsController
class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.find_by_email(params[:email])
    if user && user&.authenticate(params[:password])
      session[:user_id] = user.id
      api_success(message: 'login DONE')
    else
      unauthenticated!
    end
  end
end
