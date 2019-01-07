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

class Item < ApplicationRecord
  def price
   if has_discount == true 
   discount = self.original_price * self.discount_percentage/100
   final_price = self.original_price - discount
   final_price
   else 
    self.original_price
   end    
  end 

  def self.average_price 
    total_item = 0
    total_price = 0
    self.all.each do |i|
      total_price += i.price
      total_item += 1
  end
 average = total_price/total_item
 average
  end 

end
 