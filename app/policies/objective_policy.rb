# frozen_string_literal: true

class ObjectivePolicy < ApplicationPolicy
  def update?
    user.admin? || record.user == user
  end

  def edit?
    update?
  end

  def create?
    user.admin? || user.colab?
  end

  def new?
    create?
  end

  def index
    user.admin? || user.colab?
  end
end
