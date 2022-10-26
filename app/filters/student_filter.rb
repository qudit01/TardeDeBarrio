# frozen_string_literal: true

class StudentFilter
  include ActiveModel::Model

  attr_reader :students
  attr_accessor :query

  def initialize(scope, params)
    super(params)

    @students = scope
  end

  def call
    by_query!

    students
  end

  def by_query!
    return if query.blank?

    @students = students.where('name LIKE ? or last_name LIKE ? ', "%#{query}%", "%#{query}%")
  end
end
