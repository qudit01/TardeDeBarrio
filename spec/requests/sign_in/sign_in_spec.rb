# frozen_string_literal: true

require 'rails_helper'
RSpec.describe SignInsController, type: :request do
  context 'when user is not logged' do
    let!(:user) do
      create(:user, email: 'user@user.com', password: '123456789', password_confirmation: '123456789', status: true,
                    rol: 'admin')
    end
    it 'should redirect to users_path' do
      post(sign_in_url, params: { email: 'user@user.com', password: '123456789' })
      expect(response).to redirect_to users_path(locale: :en)
      get new_student_path(locale: :en)
      expect(response).to render_template(:new)
    end

    it 'should redirect to new_session_url with flash message' do
      post(sign_in_url, params: { email: 'sofi@hotmail', password: 'holaH123' })
      expect(flash[:alert]).to eq('Login failed!')
    end
  end

  context 'when user is logged in' do
    it 'should redirect to new_sessions_url' do
      post(sign_in_url, params: { email: 'sofi@hotmail.com', password: 'holaH123' })
      delete(sign_in_url)
      expect(response).to redirect_to sign_in_url(locale: 'en')
    end
  end
end
