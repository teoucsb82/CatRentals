# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string(255)      default("PENDING"), not null
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :status, :presence => true, inclusion: { in: %w(PENDING APPROVED DENIED), message: "%{value} is not a valid status" }
  validate  :overlapping_requests

  belongs_to  :cat

  def approve!
    transaction do
      self.status = "APPROVED"
      self.save!

      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def overlapping_pending_requests
    requests = cat.cat_rental_requests
    [].tap do |conflicting_requests|
      requests.each do |request|
        next if request.status != "PENDING" || request == self
        booked_start_date = request.start_date
        booked_end_date = request.end_date

        proposed_start_date = start_date
        proposed_end_date = end_date

        if (proposed_start_date < booked_end_date && proposed_end_date > booked_start_date) ||
         (proposed_start_date > proposed_end_date)
          conflicting_requests << request
        end
      end
    end
  end

  def overlapping_requests
    return if self.status == "DENIED"

    requests = cat.cat_rental_requests
    requests.each do |request|
      next if request.status != "APPROVED" 
      booked_start_date = request.start_date
      booked_end_date = request.end_date

      proposed_start_date = start_date
      proposed_end_date = end_date

      if (proposed_start_date < booked_end_date && proposed_end_date > booked_start_date) ||
         (proposed_start_date > proposed_end_date)
        raise "that time has already been booked"
      end
    end
  end

end
