# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:student)).to be_valid
    end
    it 'has a persitent factory' do
      expect(FactoryBot.create(:student)).to be_persisted
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:scholarity) }
    it { should validate_presence_of(:goes_to_school) }
    it { should validate_presence_of(:birthday) }
    it { should validate_presence_of(:address) }
    describe 'enumeratives' do
      it { should define_enum_for(:scholarity).with_values(initial: 0, elementary: 1, high_school: 2) }
    end
    it { is_expected.to validate_inclusion_of(:goes_to_school).in_array([true, false]) }
  end

  describe 'not allowed' do
    it { is_expected.not_to allow_value('123').for(:name) }
    it { is_expected.not_to allow_value('123').for(:last_name) }
  end

  describe 'allowed values' do
    it { should allow_value('vincent').for(:name) }
    it { should allow_value('vincent').for(:last_name) }
  end
end
