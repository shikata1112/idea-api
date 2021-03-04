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
<<<<<<< HEAD
        @ideas = Category.fetch_ideas(params[:category_name])
=======
        @ideas = Category.hoge(params[:category_name])
>>>>>>> a2b84206bf47c22a09caa7ee6d040bd6e997fddc
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
