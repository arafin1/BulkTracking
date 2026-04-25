class Api::V1::BuyersController < ApplicationController
    def index
        buyers = Buyer.all
        render json: buyers
    end

    def create
        buyer = Buyer.new(buyer_params)
        if buyer.save
            render json: buyer, status: :created
        else
            render json: buyer.errors, status: :unprocessable_entity
        end
    end

    private

    def buyer_params
        params.require(:buyer).permit(:name, :email, :country)
    end
end
