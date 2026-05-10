class ApplicationController < ActionController::API
  include JwtHelper
  # Disable parameter wrapping
  wrap_parameters false

  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    decoded = decode_token(token)
    if decoded
      @current_user = User.find(decoded["user_id"])
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end