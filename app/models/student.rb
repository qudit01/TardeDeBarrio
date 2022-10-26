# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :user
  has_many :objectives, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :answers, through: :comments
  has_many :likes, through: :comments
  enum scholarity: { initial: 0, elementary: 1, high_school: 2 }
  validates :name, :last_name, presence: true
  validates_format_of :name, :last_name, with: NAMES_FORMAT
  validates :address, presence: true
  validates :birthday, presence: true
  validates :scholarity, presence: true, inclusion: { in: scholarities.keys }
end
