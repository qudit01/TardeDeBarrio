# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end
    it 'has a persitent factory' do
      expect(FactoryBot.create(:user)).to be_persisted
    end
  end

  describe 'validations' do
    subject { create(:user) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_length_of(:password).is_at_least(3) }
  end

  describe 'password not allowed values' do
    it "password can't be blank" do
      expect(FactoryBot.build(:user, password: '')).not_to be_valid
    end
    it "password can't be nil" do
      expect(FactoryBot.build(:user, password: nil)).not_to be_valid
    end
  end

  describe 'not allowed' do
    it { is_expected.not_to allow_value('vincent@hotmail').for(:email) }
    it { is_expected.not_to allow_value('123').for(:name) }
  end

  describe 'allowed values' do
    it { is_expected.to allow_value('vincent@hotmail.com').for(:email) }
    it { is_expected.to allow_value('vincent').for(:name) }
  end

  describe 'not allowed' do
    it { is_expected.not_to allow_value('vincent@hotmail').for(:email) }
    it { is_expected.not_to allow_value('123').for(:name) }
    it { is_expected.not_to allow_value('123').for(:last_name) }
    it { is_expected.not_to allow_value('').for(:password) }
    it { is_expected.not_to allow_value('').for(:password_confirmation) }
  end

  describe 'allowed values' do
    it { is_expected.to allow_value('vincent@hotmail.com').for(:email) }
    it { is_expected.to allow_value('vincent').for(:name) }
  end

  describe 'uniqueness validations' do
    subject { create(:user) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
