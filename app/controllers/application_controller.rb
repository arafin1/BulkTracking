class ApplicationController < ActionController::API # or ActionController::Base
  
  def authenticate_user!
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header

    # ❌ OLD CRASHING LINE: decoded = decode_token(token)
    # ✅ FIXED LINE: Call it directly through the JwtHelper namespace module
    decoded = JwtHelper.decode_token(token)

    if decoded
      @current_user = User.find_by(id: decoded["user_id"])
    else
      render json: { error: "Unauthorized access" }, status: :unauthorized
    end
  end
end
