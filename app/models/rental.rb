class Rental < ApplicationRecord
  validate :start_date_cannot_be_in_the_past, :end_date_cannot_be_before_start_date

  belongs_to :client
  belongs_to :car_category
  belongs_to :user
  has_many :car_rentals
  
  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "Data inicial deve ser depois de hoje")
    end
  end

  
  def end_date_cannot_be_before_start_date
    if end_date < start_date
      errors.add(:end_date, "Data final deve ser depois da data inicial")
    end
  end

  #validates :start_date, date: { before: :end_date, message: 'Data inicial deve ser antes da data final' }
end
