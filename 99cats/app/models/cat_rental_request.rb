# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  STATUS = ["PENDING", "DENIED", "APPROVED"]

  validate :overlapping_requests
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true, inclusion: STATUS
  validates :user_id, presence: true

  belongs_to :cat
  belongs_to :user


  def approve!
    self.transaction do
      self.update!(status: "APPROVED")
      conflicting_rentals.each { |rental| rental.deny! }
    end
  end

  def deny!
    self.update!(status: "DENIED")
  end

  def pending?
    self.status == "PENDING"
  end

  private

  def conflicting_rentals
    CatRentalRequest
      .where(cat_id: self.cat_id)
      .select do |rental|
        next if self.id == rental.id
        self.start_date.between?(rental.start_date, rental.end_date) ||
          self.end_date.between?(rental.start_date, rental.end_date)
      end
  end

  def overlapping_requests
    if overlapping_approved_requests?
      self.errors[:date] << "Must not overlap."
    end
  end

  def overlapping_approved_requests?
    return false unless self.status == "APPROVED"
    conflicting_rentals.any? { |rental| rental.status == "APPROVED" }
  end
end
