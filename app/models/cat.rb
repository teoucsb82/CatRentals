# == Schema Information
#
# Table name: cats
#
#  id         :integer          not null, primary key
#  age        :integer          not null
#  birth_date :date             not null
#  color      :string(255)      not null
#  name       :string(255)      not null
#  sex        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Cat < ActiveRecord::Base
  validates :age, :presence => true, numericality: { only_integer: true }
  validates :birth_date, :presence => true
  validates :color, :presence => true
  validates :name, :presence => true
  validates :sex, :presence => true, length: { is: 1 }

  belongs_to  :user
  has_many  :cat_rental_requests, :dependent => :destroy, :order => 'start_date'

end


