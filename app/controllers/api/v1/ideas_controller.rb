# Containing a class
module Api
  module V1
    # Description/Explanation of IdeasController class
    class IdeasController < ApplicationController
      def create
        category = Category.find_by(name: params[:category_name])
        if category.present?
          begin
            category.ideas.create!(body: idea_params[:body])
            render json: { status: 201 }, status: :created
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error e.message
            render json: { status: 422 }, status: :unprocessable_entity
          end
        else
          begin
            new_category = Category.create!(name: idea_params[:category_name])
            new_category.ideas.create!(body: idea_params[:body])
            render json: { status: 201 }, status: :created
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error e.message
            render json: { status: 422 }, status: :unprocessable_entity
          end
        end
      end

      def index
        if params[:category_name].present?
          category = Category.find_by(name: params[:category_name])
          if category.present?
            @ideas = category.ideas
            render formats: :json
          else
            render json: { status: 404 }, status: :not_found
          end
        else
          @ideas = Idea.all
          render formats: :json
        end
      end

      private

      def idea_params
        params.permit(:body, :category_name)
      end
    end
  end
end
