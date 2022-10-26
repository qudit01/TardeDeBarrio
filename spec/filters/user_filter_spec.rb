# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserFilter, type: :filter do
  describe 'should get a user from initialize' do
  end

  describe 'should get all users' do
  end

  context 'Query matching - ' do
    before { create(:user, name: 'Nombre', last_name: 'Apellido') }
    it 'should get a user by name' do
      query = 'Nombre'
      expect(UserFilter.new(User.all, query: query).call.count).to eq(1)
    end
    it 'should get a user by last name' do
      query = 'Apellido'
      expect(UserFilter.new(User.all, query: query).call.count).to eq(1)
    end
  end

  describe 'should return nil if query is blank' do
    it 'should get nil if query is blank' do
      query = ''
      expect(UserFilter.new(User.all, query: query).call.count).to eq(0)
    end
  end
end
