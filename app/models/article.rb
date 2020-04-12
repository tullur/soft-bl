class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  scope :search, ->(title) { where('title LIKE ?', "%#{title}%") }
end
