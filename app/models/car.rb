class Car < ApplicationRecord
  has_many :maintenance_services, dependent: :destroy

  # Validación para que el número de placa sea único y esté presente.
  validates :plate_number, presence: {message: "EL numero de placa es obligatorio"},
                           uniqueness: {message: "El numero de placa debe ser unico"}
  
  # Validación para que el modelo esté presente.
  validates :model, presence: true
  
  # Validación para que el año esté presente y sea un número válido.
  validates :year, presence: true, numericality: { 
    greater_than_or_equal_to: 1900, 
    less_than_or_equal_to: Date.today.year
  }
end
