# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def update?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def create?
    @user.admin? || @user.colab?
  end

  def new?
    @user.admin? || @user.colab?
  end

  def index?
    true
  end

  def show?
    true
  end

  def change_status?
    @user.admin?
  end

  def release_colab
    @user.admin?
  end

  def create_calendar
    @user.admin?
  end

  def new_student
    @user.admin? || @user.colab?
  end

  def add_student_note
    @user.admin? || @user.colab?
  end

  def edit_student
    @user.admin? || @user.colab?
  end

  def student_balance
    @user.admin? || @user.colab?
  end

  def student_assistance
    @user.admin? || @user.colab?
  end
end
