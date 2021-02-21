class Category < ApplicationRecord
  has_many :ideas, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: true }

  def self.hoge(category_name)
    return Idea.all if category_name.blank?
    category = find_by(name: category_name)
    return category.ideas if category.present?
    []
  end

  def self.create_ideas!(name, body)
    category = find_by(name: name)
    if category.present?
      category.ideas.create!(body: body)
    else
      create_name_and_ideas!(name, body)
    end
  end

  def self.create_name_and_ideas!(name, body)
    transaction do
      new_category = Category.new(name: name)
      new_category.ideas.build(body: body)
      new_category.save!
    end
  end 
end
