# frozen_string_literal: true

class SignInsController < ApplicationController
  skip_before_action :require_login, only: %i[show create]
  layout 'login'

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user.present? && @user.status?
      redirect_to(users_path, notice: t('.success'))
    else
      flash.now[:alert] = t('.failure')
      render action: 'show', status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to(sign_in_path, notice: t('.success'))
  end

  private

  def login_params
    params.require(:login).permit(:email, :password)
  end
end
