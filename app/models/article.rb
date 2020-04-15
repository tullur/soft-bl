# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true, length: { in: 3..10 }
  validates :body, presence: true, length: { in: 5..100 }

  scope :search, ->(title) { where('title LIKE ?', "%#{title}%") }
end
