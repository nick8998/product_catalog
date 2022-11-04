require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }

    it 'order_by_date' do
      expect(described_class.order(updated_at: :asc).to_sql).to eq described_class.order_by_date.to_sql
    end

    it 'order_by_date' do
      expect(described_class.order(hand: :asc).to_sql).to eq described_class.order_by_hand.to_sql
    end
  end
end
