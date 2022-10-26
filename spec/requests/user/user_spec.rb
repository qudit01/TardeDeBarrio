# frozen_string_literal: true

require 'rails_helper'
RSpec.describe UsersController, type: :request do
  describe 'GET new' do
    context 'when user is not logged in' do
      it 'deniess access to users#new' do
        get new_user_path
        expect(response).to redirect_to sign_in_url(locale: 'en')
      end
    end

    context 'when user is logged in and request is valid' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      before do 
        login_user(user)
        get new_user_path(locale: 'en')
      end
      it 'should render new' do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST create' do
    context 'user is not logged in' do
      it 'deniess access to users#create' do
        user_params = FactoryBot.attributes_for(:user)
        expect do
          post '/users', params: { user: user_params }
        end.to_not change(User, :count)
        expect(response).to redirect_to '/sign_in?locale=en'
      end
    end

    context 'user logged in, with valid attributes' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      before do 
        login_user(user)
      end
      it 'creates and login a new user' do
        expect do
          post '/users', params: { user: { name: 'Nacho', last_name: 'Garcia', email: 'nachogarcia@gmail.com', password: 'holaH123',
                                           password_confirmation: 'holaH123' } }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to(users_path(locale: 'en'))
      end
    end

    context 'user logged in, with invalid attributes' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      before do 
        login_user(user)
      end
      it "doesn't create a new user" do
        expect do
          post '/users', params: { user: { name: 'Sofi', last_name: 'Garcia', email: 'sofigarcia@gmail.com', password: 'holaH123',
                                           password_confirmation: 'holaH12' } }
        end.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end
end
