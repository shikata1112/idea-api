module Api
  module V1
    class IdeasController < ApplicationController
      def create
        Category.create_ideas!(idea_params[:category_name], idea_params[:body])
        head :created
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error e.message
        head :unprocessable_entity
      end

      def index
        @ideas = Category.fetch_ideas(params[:category_name])
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
