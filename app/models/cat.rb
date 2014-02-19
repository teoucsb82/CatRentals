class Cat < ActiveRecord::Base
  validates :age, :presence => true, numericality: { only_integer: true }
  validates :birth_date, :presence => true
  validates :color, :presence => true
  validates :name, :presence => true
  validates :sex, :presence => true, length: { is: 1 }

  has_many  :cat_rental_requests, :dependent => :destroy, :order => 'start_date'

end


