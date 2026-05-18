class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    users = User.all.select(:id, :name, :email, :role, :created_at)
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: "User deleted" }
  end
end