class Category < ApplicationRecord
  has_many :ideas, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: true }

<<<<<<< HEAD
  def self.fetch_ideas(category_name)
    return Idea.eager_load(:category) if category_name.blank?

    category = find_by(name: category_name)
    return category.ideas if category.present?

=======
  def self.hoge(category_name)
    return Idea.eager_load(:category) if category_name.blank?
    category = find_by(name: category_name)
    return category.ideas if category.present?
>>>>>>> a2b84206bf47c22a09caa7ee6d040bd6e997fddc
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

  private

  def self.create_name_and_ideas!(name, body)
    transaction do
<<<<<<< HEAD
      new_category = new(name: name)
      new_category.ideas.build(body: body)
      new_category.save!
    end
  end
=======
      new_category = Category.new(name: name)
      new_category.ideas.build(body: body)
      new_category.save!
    end
  end 
>>>>>>> a2b84206bf47c22a09caa7ee6d040bd6e997fddc
end
