class MaintenanceService < ApplicationRecord
  belongs_to :car
  
  # Definir el enum para el campo status.
  enum status: { pending: 0, in_progress: 1, completed: 2 }
  
  # Validación para que la descripción esté presente.
  validates :description, presence: true
  
    # Validación para que la fecha este presente y sea válida.
    validates :date, presence: true
    validate :date_cannot_be_in_the_future

    private
  
    def date_cannot_be_in_the_future
      if date.present? && date > Date.today
        errors.add(:date, "la fecha debe ser una fecha pasada o presente")
      end
    end
end
