class Api::V1::SamplesController < ApplicationController
    def index
        samples = Sample.all
        render json: samples
    end

    def create
        sample = Sample.new(sample_params)
        if sample.save
            render json: sample, status: :created
        else
            render json: sample.errors, status: :unprocessable_entity
        end
    end

    def update
        sample = Sample.find(params[:id])
        if sample.update
            render json: sample
        else
            render json: sample.errors, status: :unprocessable_entity
        end
    end

    def update_status
        sample = Sample.find(params[:id])
        if sample.update(status: params[:status])
            render json: sample
        else
            render json: sample.errors, status: :unprocessable_entity
        end
        
    end

    private
    def sample_params
        params.require(:sample).permit(
            :style_id,
            :sample_type,
            :date_sent, 
            :status,
            :buyer_comments
            )
    end


end
