# Containing a class
module Api
  module V1
    # Description/Explanation of IdeasController class
    class IdeasController < ApplicationController
      def create
        category = Category.find_by(name: params[:category_name])
        if category.present?
          
          binding.pry
          category.ideas.create!(body: idea_params[:body])
          # idea = Idea.new(body: idea_params[:body])
          # idea.category_id = category.id
          # idea.save!
          render status: :created
        else

        end
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error e.message
        render status: :unprocessable_entity
      end

      def index
        category = Category.find_by(name: params[:category_name])
        if category.present?
          @ideas =
            if params[:category_name].present?
              category.ideas
            else
              Idea.all
            end
          render formats: :json, status: :created
        else
          render status: :not_found
        end
      end

      private

      def idea_params
        params.permit(:body, :category_name)
      end
    end
  end
end
