class Category < ApplicationRecord
  has_many :ideas, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: true }

  def self.fetch_ideas(category_name)
    return Idea.all if category_name.nil?
    category = find_by(name: category_name)
    return category.ideas if category.present?
    []
  end
end
