# frozen_string_literal: true

class AnswerDecorator < Draper::Decorator
  delegate_all

  def name
    user.name
  end

  def time
    I18n.l(created_at, format: :shorter)
  end
end
