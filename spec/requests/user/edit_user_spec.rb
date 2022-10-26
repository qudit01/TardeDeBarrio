# frozen_string_literal: true

require 'rails_helper'
RSpec.describe UsersController, type: :request do
  describe 'GET edit' do
    context 'when user is not logged in' do
      let!(:user) { create(:user, password: '123', password_confirmation: '123') }
      it 'deniess access to users#edit' do
        get edit_user_path(user)
        expect(response).to redirect_to sign_in_url(locale: 'en')
      end
    end

    context 'when user is logged in' do
      let!(:user) { create(:user, password: '123', password_confirmation: '123') }
      it 'should render edit' do
        login_user
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH update' do
    let!(:user) do
      create(:user, name: 'emilio', last_name: 'ballardini', email: 'ejm@hotmail.com', password: 'password',
                    password_confirmation: 'password')
    end
    context 'user is not logged in' do
      it 'deniess access to users#update' do
        patch user_path(user, user: { name: 'matias' }, locale: 'en')
        expect(response).to redirect_to '/sign_in?locale=en'
      end
    end

    context 'user is logged in and attributes are valid' do
      it 'should update users' do
        login_user
        patch user_path(user, user: { name: 'matias' }, locale: 'en')
        expect(User.find(user.id)).to have_attributes(name: 'matias')
      end
    end

    context 'user is logged in and attributes are not valid' do
      it 'should not update users name' do
        login_user
        patch user_path(user, user: { name: '123' }, locale: 'en')
        expect(User.find(user.id)).to have_attributes(name: 'emilio')
        expect(User.find_by_name('123')).not_to eq(user)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end

      it 'should not update users last name' do
        login_user
        patch user_path(user, user: { last_name: '123' }, locale: 'en')
        expect(User.find(user.id)).to have_attributes(last_name: 'ballardini')
        expect(User.find_by_last_name('123')).not_to eq(user)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end

    context 'user is logged in and wants to modify email' do
      it 'should not update email' do
        login_user
        patch user_path(user, user: { email: 'matias@hotmail.com' }, locale: 'en')
        expect(User.find(user.id)).to have_attributes(email: 'ejm@hotmail.com')
      end
    end
  end
end
