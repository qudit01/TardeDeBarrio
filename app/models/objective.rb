# frozen_string_literal: true

class Objective < ApplicationRecord
  belongs_to :user
  belongs_to :student

  validates :content, presence: true
  validates :done, presence: true
end
