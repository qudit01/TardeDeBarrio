# frozen_string_literal: true

class UserFilter
  include ActiveModel::Model

  attr_reader :users
  attr_accessor :query

  def initialize(scope, params)
    super(params)

    @users = scope
  end

  def call
    by_query!

    users
  end

  def by_query!
    return if query.blank?

    @users = users.where('name LIKE ? or last_name LIKE ? ', "%#{query}%", "%#{query}%")
  end
end
