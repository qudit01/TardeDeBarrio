# frozen_string_literal: true

class ObjectivesController < ApplicationController
  before_action :set_objective, only: %i[show edit update change_done]

  def show; end

  def index
    @objectives = Objectives.all
  end

  def new
    authorize Objective
    @objective = Objective.new
  end

  def create
    authorize Objective
    @student = Student.find(params[:student_id])
    @objective = @student.obvjectives.build(objective_params.merge(user: current_user))
    if @objective.save
      render @student, layout: false
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @objective
  end

  def update
    authorize @objective
  end

  def delete; end

  def toggle_done
    @objective.toggle!(:done)
    render @student, layout: false
  end

  private

  def objective_params
    params.require(:objective).permit(:content, :done, :student)
  end

  def set_objective
    @objective = Objective.find(params[:id])
  end
end
