# Containing a class
module Api
  module V1
    # Description/Explanation of IdeasController class
    class IdeasController < ApplicationController
      def create
        category = Category.find_by(name: params[:category_name])
        if category.present?
          category.ideas.create!(body: idea_params[:body])
          render status: :created
        end
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error e.message
        render status: :unprocessable_entity
      end

      def index
        @ideas = Category.existing_ideas(params[:category_name])
        if @ideas.present?
          render formats: :json
        else
          head :not_found
        end
      end

      private

      def idea_params
        params.permit(:body, :category_name)
      end
    end
  end
end
