# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_student, only: %i[create delete give_like]
  before_action :set_answer, only: %i[show give_like update delete]
  decorates_assigned :answer, :answers

  def new
    @answer = Answer.new
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @answer = @comment.answers.build(answer_params.merge(user: current_user, student: @student))
    if @answer.save
      redirect_to(student_path(@student), notice: t('.success'))
    else
      render @student, status: :unprocessable_entity
    end
  end

  def show; end

  def index
    @answer = Answer.all
  end

  def delete
    if @answer.destroy
      redirect_to(student_path(@student), notice: t('.success'))
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to(student_path(@student), notice: t('.success'))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def give_like
    sum = @answer.likes += 1
    @answer.update(likes: sum)
    render json: { answer: @answer }
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :likes)
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
