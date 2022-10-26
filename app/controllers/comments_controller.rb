# frozen_string_literal: true

class CommentsController < ApplicationController
  decorates_assigned :comment, :comments

  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
  end
  
  def create
    @student = Student.find(params[:student_id])
    @comment = @student.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to(student_path(@student), notice: t('.success'))
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :highlight, :img_src, :student_id, :user_id, files: [])
  end
end
