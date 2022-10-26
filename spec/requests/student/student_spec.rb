# frozen_string_literal: true

require 'rails_helper'
RSpec.describe StudentsController, type: :request do
  describe 'GET new' do
    context 'when user is not logged in' do
      before do
        get new_student_path(locale: :en)
      end
      it 'deniess access to students#new' do
        expect(response).to redirect_to sign_in_url(locale: 'en')
      end
    end

    context 'when user is logged in and status is invalid ' do
      let!(:user) { create(:user, name: 'Nombre', last_name: 'Apellido') }
      before do
        student_login_user(user)
        get new_student_path(locale: :en)
      end
      it { user.toggle!(:status) }
      it { user.reload }
      it { expect(response).to have_http_status(:success) }
      it { should render_template('students/new') }
    end

    context 'when user is logged in and status is valid' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      before do
        student_login_user(user)
        get new_student_path(locale: :en)
      end
      it { expect(response).to have_http_status(:success) }
      it { should render_template('students/new') }
    end
  end

  describe 'POST create' do
    context 'user is not logged in' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      it 'deniess access to users#create' do
        student_params = FactoryBot.attributes_for(:student)
        expect do
          post '/students', params: { student: student_params }
        end.to_not change(Student, :count)
        expect(response).to redirect_to '/sign_in?locale=en'
      end
    end

    context 'user logged in, student with valid attributes' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      before do
        student_login_user(user)
        get new_student_path(locale: :en)
      end
      it 'should create a new student' do
        student_params = FactoryBot.attributes_for(:student)
        expect { post '/students', params: { student: student_params } }.to change(Student, :count).by(1)
        expect(response).to redirect_to(students_path(locale: 'en'))
      end
    end

    context 'user logged in, with invalid attributes' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end

      before do
        student_login_user(user)
        get new_student_path(locale: :en)
      end

      it "doesn't create a new user" do
        expect { post '/students', params: { student: { name: 'Sofi2' } } }.not_to change(Student, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET show' do
    context 'user is not logged in' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      let!(:student) { create(:student, user: user) }
      it 'deniess access to users#show' do
        expect do
          get student_path(student, locale: :en)
        end.to_not change(Student, :count)
        expect(response).to redirect_to '/sign_in?locale=en'
      end
    end

    context 'user logged in, student with valid attributes' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      let!(:student) { create(:student, user: user) }
      before do
        student_login_user(user)
        get student_path(student, locale: :en)
      end
      it { expect(response).to have_http_status(:success) }
      it { should render_template('students/show') }
    end
  end

  describe 'GET edit' do
    context 'user is not logged in' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      let!(:student) { create(:student, user: user) }
      it 'deniess access to users#edit' do
        expect do
          get edit_student_path(student, locale: :en)
        end.to_not change(Student, :count)
        expect(response).to redirect_to '/sign_in?locale=en'
      end
    end

    context 'user logged in, student with valid attributes' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      let!(:student) { create(:student, user: user) }
      before do
        student_login_user(user)
        get edit_student_path(student, locale: :en)
      end
      it { expect(response).to have_http_status(:success) }
      it { should render_template('students/edit') }
    end
  end

  describe 'PATCH update' do
    context 'user is not logged in' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      let!(:student) { create(:student, user: user) }
      it 'deniess access to users#update' do
        expect do
          patch student_path(student, locale: :en)
        end.to_not change(Student, :count)
        expect(response).to redirect_to '/sign_in?locale=en'
      end
    end

    context 'user logged in, student with valid attributes' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      let!(:student) { create(:student, user: user) }
      before do
        student_login_user(user)
        get edit_student_path(student, locale: :en)
      end
      it 'should update a student' do
        student_params = FactoryBot.attributes_for(:student)
        patch '/students/1', params: { student: student_params }
        expect(response).to redirect_to(students_path(locale: 'en'))
      end
    end

    context 'user logged in, with invalid attributes' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      let!(:student) { create(:student, user: user, name: 'Estudiante') }
      before do
        student_login_user(user)
        get edit_student_path(student, locale: :en)
      end

      it "doesn't update a student" do
        patch student_path(student, student: { name: 'Sofi2' }, locale: :en)
        expect(Student.find(student.id)).to have_attributes(name: 'Estudiante')
        expect(Student.find_by_name('Sofi2')).not_to eq(student)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'user is not logged in' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      let!(:student) { create(:student, user: user) }
      it 'deniess access to users#destroy' do
        expect do
          delete student_path(student, locale: :en)
        end.to_not change(Student, :count)
        expect(response).to redirect_to '/sign_in?locale=en'
      end
    end

    context 'user logged in, student with valid attributes' do
      let!(:user) do
        create(:user, name: 'Nombre', last_name: 'Apellido', password: '123456789', password_confirmation: '123456789')
      end
      let!(:student) { create(:student, user: user) }
      before do
        student_login_user(user)
        get edit_student_path(student, locale: :en)
      end
      it 'should delete a student' do
        expect { delete student_path(student, locale: :en) }.to change(Student, :count).by(-1)
        expect(response).to redirect_to(students_path(locale: 'en'))
      end
    end
  end
end
