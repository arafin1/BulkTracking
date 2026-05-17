class ApplicationController < ActionController::API
  
  def authenticate_user!
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header
    decoded = JwtHelper.decode_token(token)

    if decoded
      @current_user = User.find_by(id: decoded["user_id"])
    else
      render json: { error: "Unauthorized access" }, status: :unauthorized
    end
  end

  # 💡 ADD THIS METHOD: Exposes the variable safely to your entire backend app
  def current_user
    @current_user
  end
end