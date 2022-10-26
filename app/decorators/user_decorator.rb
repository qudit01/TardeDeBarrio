# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def full_name
    "#{name} #{last_name}"
  end
end
