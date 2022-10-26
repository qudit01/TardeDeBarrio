# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :student
  has_many :answers, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :content, presence: true
  has_many_attached :files, dependent: :destroy
end
