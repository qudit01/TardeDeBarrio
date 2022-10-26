# frozen_string_literal: true

Rails.application.routes.draw do
  resources 'users' do
    member do
      patch :change_status
    end
  end

  resources 'likes'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'sign_ins#show'
  user_sessions_url = '/sign_ins'
  # get 'login' => 'sign_in#new', :as => :login
  # post 'login' => "sign_in#create"
  # post 'logout' => 'sign_in#destroy', :as => :logout

  resource 'sign_in'

  resources 'students' do
    resources 'comments' do
      post :like, to: 'likes#toggle_liking'
      resources 'answers' do
        post :like, to: 'likes#toggle_liking'
      end
      resources 'objectives'
    end
  end
end
