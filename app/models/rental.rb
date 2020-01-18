class Rental < ApplicationRecord
  validate :start_date_cannot_be_in_the_past, :end_date_cannot_be_before_start_date, :available_cars_in_category

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

  def available_cars_in_category
    usedCars = 0
    @car_categories = CarCategory.all
    @rentals = Rental.where(start_date: Date.current)
    @car_categories.each do |car_category|
      @rentals.each do |rental|
        if rental.car_category.name == car_category.name
          usedCars = usedCars + 1
          if usedCars >= car_category.cars.count
            errors.add(:car_category, "Categoria #{car_category.name} não tem mais carros disponíveis,
                      favor escolher outra")
          end
        end
      end
    end
  end

end
