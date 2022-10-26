# frozen_string_literal: true

class LikesController < ApplicationController
  def toggle_liking
    params[:answer_id].present? ? insert_like(Answer.find(params[:answer_id]), true) : insert_like(Comment.find(params[:comment_id]), false)
  end

  private

  def insert_like(likeable, answer)
    @like = current_user.likes.find_by(likeable: likeable)
    if @like.nil?
      if !answer?  
        @like = current_user.likes.build(likeable: likeable, given: true, student: likeable.student)
      else  
        @like = current_user.likes.build(likeable: likeable, comment: comment_id, given: true, student: likeable.student)
      end
      @like.save
    else
      @like.toggle!(:given)
    end
    render json: { likes: Like.where(likeable: likeable).where(given: true).count }
  end
end
