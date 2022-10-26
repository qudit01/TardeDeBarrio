# frozen_string_literal: true

class StudentDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def full_name
    "#{name} #{last_name}"
  end

  def age
    ((Time.zone.now - birthday.to_time) / 1.year.seconds).floor
  end

  def full_age
    I18n.l(birthday, format: :birthday)
  end

  def school
    scholarity.humanize
  end

  def goes
    goes_to_school?
  end

  def objective_list
    objectives.map(&:content)
  end

  def comments_list
    comments.includes(:user).order(created_at: :desc).with_attached_files.decorate
  end
end
