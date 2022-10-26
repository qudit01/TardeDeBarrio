# frozen_string_literal: true

class StudentPolicy < ApplicationPolicy
    
  def update?
    user.admin? || record.user == user
  end
  
  def edit?
    update?
  end

  def destroy?
    user.admin? || record.user == user
  end
  
  def delete?
    destroy?
  end

  def create?
    user.admin? || user.colab? and user.status?
  end

  def new?
    create?
  end
end
