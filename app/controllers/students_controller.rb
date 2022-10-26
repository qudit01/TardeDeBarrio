# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student, only: %i[show destroy edit update]
  decorates_assigned :student, :students

  def index
    @filter = StudentFilter.new(Student.all, filter_params)
    @pagy, @students = pagy(@filter.call, overflow: :last_page)
  end

  def show; end

  def new
    authorize Student
    @student = Student.new
  end

  def create
    authorize Student
    @student = current_user.students.build(students_params_add)
    unless @student.save
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @student
  end

  def update
    authorize @student
    unless @student.update(students_params_add)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @student
    if @student.destroy
      redirect_to students_path
    else
      render :new
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def students_params_add
    params.require(:student).permit(:name, :last_name, :address, :birthday, :scholarity, :goes_to_school)
  end

  def filter_params
    params.fetch(:student_filter, {}).permit(
      :query
    )
  end
end
