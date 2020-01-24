class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user
  has_one :car_rental
  has_one :car, through: :car_rentals

  validate :start_date_cannot_be_in_the_past, :end_date_cannot_be_before_start_date, :must_have_available_cars

  enum status: { scheduled: 0, in_progress: 5 }

  before_create :generate_code
  
  private

  def must_have_available_cars
    return if cars_available?

    errors.add(:base, 'Não existem carros disponíveis desta categoria')
  end

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

  def cars_available?
     #Pegando todos os carros, a partir de todas models, vinculados à categoria dessa rental
     cars = Car.where(car_model: car_category.car_models)

     #Pegando todas as rentals associadas a essa categoria
     rentals = car_category.rentals.to_a
 
     #Passando por cada rental e verificando se, com base nas datas, ela pode ser descartada
     rentals.select! do |rental|
         rental.start_date.between?(start_date, end_date) || rental.end_date.between?(start_date, end_date)
     end
 
     #Comparando se o número de carros é maior que o número de rentals
     cars.length > rentals.length
  end

  def generate_code
    self.code = loop do
      token = generate_random_token
      break token unless Rental.exists?(code: token)
    end
  end

  def generate_random_token
    charset = Array('A'..'Z') + Array(0..9)
		Array.new(6) { charset.sample }.join
  end

end
