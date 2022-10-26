# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :require_login
  include Pagy::Backend
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def not_authenticated
    redirect_to sign_in_path, alert: t('.not_authenticated')
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def user_not_authorized
    flash[:alert] = t('pundit.not_authorized')
    redirect_to(request.referrer || users_path)
  end
end
