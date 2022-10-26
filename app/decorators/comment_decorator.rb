# frozen_string_literal: true

class CommentDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def name
    user.name
  end

  def date_of_publication
    created_at.today? ? I18n.t('comments.today') : passed_date
  end

  def passed_date
    I18n.l(created_at, format: :shorter)
  end

  def time
    I18n.l(created_at, format: :short)
  end

  def answers_list
    answers.includes(:user).order(created_at: :desc).decorate
  end
end
