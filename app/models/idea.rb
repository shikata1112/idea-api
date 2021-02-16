class Idea < ApplicationRecord
  belongs_to :category

  delegate :name, to: :category, prefix: true

  validates :body, presence: true
end
