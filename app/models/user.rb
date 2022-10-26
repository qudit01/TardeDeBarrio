# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :students
  has_many :objectives, through: :students
  has_many :comments, through: :students
  has_many :answers, through: :students
  has_many :likes, dependent: :destroy
  enum rol: { admin: 0, colab: 1 }
  validates :name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: EMAIL_FORMAT
  validates_format_of :name, :last_name, with: NAMES_FORMAT
  validates :password, length: { minimum: 3 }, allow_nil: false, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, allow_nil: false, if: lambda {
                                                                            new_record? || changes[:crypted_password]
                                                                          }
end
