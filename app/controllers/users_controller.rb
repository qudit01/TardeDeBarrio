# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update change_status]
  decorates_assigned :user, :users

  def index
    @filter = UserFilter.new(User.all, filter_params)
    @pagy, @users = pagy(@filter.call)
  end

  def new
    authorize User
    @user = User.new
  end

  def show
    @user
  end

  def create
    authorize User
    @user = User.new(user_params)
    unless @user.save
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    unless @user.update(user_params_edit)
      render :edit, status: :unprocessable_entity
    end
  end

  def change_status
    authorize User
    @user.toggle!(:status)
    render user, layout: false
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params_edit
    params.require(:user).permit(:name, :last_name)
  end

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation)
  end

  def filter_params
    params.fetch(:user_filter, {}).permit(
      :query
    )
  end
end
