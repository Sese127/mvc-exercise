# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:has_discount).of_type(:boolean).with_options(default: false) }
      it { is_expected.to have_db_column(:discount_percentage).of_type(:integer).with_options(default: 0) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
    end
  end

  describe 'Price' do
    context 'when the item has a discount' do
      let(:item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 20) }

      it { expect(item.price).to eq(80.00) }
    end
  end

  describe 'Price' do
    context 'when the item has not a discount' do
      let(:item) { build(:item_without_discount, original_price: 100.00, discount_percentage: nil) }

      it { expect(item.price).to eq(100.00) }
    end
  end

  describe 'Average price' do 
    context 'gives an average price of many items' do 
      FactoryBot.create(:item_without_discount, original_price: 40.00)
      FactoryBot.create(:item_with_discount, original_price: 40.00, discount_percentage:10)
      FactoryBot.create(:item_without_discount, original_price: 14.00)

     it {expect(Item.average_price).to eq(27.00)}
     end 
  end
    
end
