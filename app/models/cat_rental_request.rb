class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :status, :presence => true, inclusion: { in: %w(PENDING APPROVED DENIED), message: "%{value} is not a valid status" }
  # validate  :overlapping_requests

  belongs_to  :cat

  def overlapping_requests
    # Get cat rental requests
    requests = cat.cat_rental_requests

    requests.each do |request|
      next if request.status != "APPROVED"
      booked_start_date = request.start_date
      booked_end_date = request.end_date

      proposed_start_date = params[:start_date]
      proposed_end_date = params[:end_date]

      if (proposed_start_date > booked_start_date && proposed_start_date < booked_end_date) || (proposed_end_date > booked_start_date && proposed_end_date < booked_end_date)
        errors[:invalid_date] << "Not a valid date yo"
      end
    end
  end

end
