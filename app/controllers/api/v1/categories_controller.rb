class Api::V1::CategoriesController < ApplicationController

  def create
    Category.create!(category_params)
    render status: :created
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error e.message
    render status: :unprocessable_entity
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end