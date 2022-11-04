require 'rails_helper'

RSpec.describe ProductPolicy, type: :policy do
  let(:user) { User.new }

  subject { ProductPolicy }

  permissions :create? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:product))
    end
  end

  permissions :update? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:product))
    end
  end

  permissions :destroy? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:product))
    end
  end
end
