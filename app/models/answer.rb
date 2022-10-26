# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :comment
  belongs_to :student
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true
end
