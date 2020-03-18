class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def basic_auth
    username=request.headers["HTTP_X_USER_EMAIL"]
    token=request.headers["HTTP_X_API_TOKEN"]

    user = User.find_by_email(username)
    
    if user
      if user.api_token == token
        sign_in user
      else
        render json: {}, status: 401
      end 
    else
      render json: {}, status: 401
    end
  end
end
