# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentPolicy, type: :policy do
  describe StudentPolicy do
    let!(:user) { create(:user) }
    let!(:student) { create(:student, { user: user }) }
    subject { StudentPolicy }

    permissions :create?, :new? do
      it 'grants access to admin' do
        expect(subject).to permit(User.new(rol: 'admin'), Student.new)
      end

      it 'grants access if user and status true' do
        expect(subject).to permit(User.new(rol: 'admin', status: true), Student.new)
      end

      it 'denies access if user and status false' do
        expect(subject).not_to permit(User.new(rol: 'admin', status: false), Student.new)
      end

      it 'grants access to colab' do
        expect(subject).to permit(User.new(rol: 'colab'), Student.new)
      end

      it 'grants access if user is colab and status true' do
        expect(subject).to permit(User.new(rol: 'colab', status: true), Student.new)
      end

      it 'denies access if user is colab and status false' do
        expect(subject).not_to permit(User.new(rol: 'colab', status: false), Student.new)
      end
    end
  end
end
