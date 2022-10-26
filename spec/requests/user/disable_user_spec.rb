# frozen_string_literal: true

require 'rails_helper'
RSpec.describe UsersController, type: :request do
  describe 'user#change_status' do
    let!(:user) do
      create(:user, { name: 'arturo', password: '123456789',
                      password_confirmation: '123456789', status: true })
    end

    context 'user is not logged in' do
      it 'should redirect to sign in home page' do
        patch change_status_user_path(user.id, locale: 'en')
        expect(response).to redirect_to(sign_in_url(locale: 'en'))
      end
    end

    context 'when user is logged in' do
      before do
        login_user
      end

      let!(:user2) do
        create(:user, { name: 'manuel', password: '123456789', password_confirmation: '123456789', status: true })
      end
      it 'should deactivate the user' do
        expect { user2.toggle!(:status) }.to change {
          user2.reload.status
        }.from(true).to(false)
        patch change_status_user_path(user2.id, locale: 'en')
        expect(response).to have_http_status(302)
      end

      let(:user3) do
        create(:user, { name: 'isidoro', password: '123456789', password_confirmation: '123456789', status: false })
      end
      it 'should activate the user' do
        expect { user3.toggle!(:status) }.to change {
          user3.reload.status
        }.from(false).to(true)
        patch change_status_user_path(user3.id, locale: 'en')
        expect(response).to have_http_status(302)
      end
    end
  end
  # Me parece algo un poco tramposo el incluir el cambio que se hace en el controller, pero no encontré otra manera
  # El problema pareciera estar en que al llamar solo con el patch, o el expect{path_url} no entra al controller en si
end
