class Api::V1::StylesController < ApplicationController
  def index
    styles = Style.all
    render json: styles
  end

  def create
    style = Style.new(style_params)
    if style.save
      render json: style, status: :created
    else
      render json: style.errors, status: :unprocessable_entity
    end
  end

  private

  def style_params
    params.require(:style).permit(:style_number, :description, :buyer_id)
  end
end