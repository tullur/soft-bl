# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_person_name

  has_many :notifications, foreign_key: :recipient_id
  has_many :services

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :avatar
end
