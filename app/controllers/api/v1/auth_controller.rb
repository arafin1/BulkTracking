class Api::V1::AuthController < ApplicationController
  include JwtHelper

  def register
    user = User.new(user_params)
    if user.save
      token = encode_token({ user_id: user.id })
      render json: { 
        message: "Registration successful",
        token: token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role
        }
      }, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def login
    email = params[:email] || params.dig(:auth, :email)
    password = params[:password] || params.dig(:auth, :password)
    user = User.find_by(email: email)
    if user&.authenticate(password)
      token = encode_token({ user_id: user.id })
      render json: { 
        message: "Login successful",
        token: token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role
        }
      }
    else
      render json: { error: "Invalid email or password" }, 
             status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :password, 
      :password_confirmation,
      :role
    )
  end
end