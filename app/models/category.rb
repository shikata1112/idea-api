class Category < ApplicationRecord
  has_many :ideas, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: true }

  def self.existing_ideas(category_name)
    if category_name.present?
      category = Category.find_by(name: category_name)
      category.ideas if category.present?
    else
      Idea.all
    end
  end
end
