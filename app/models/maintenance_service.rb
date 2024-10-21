class MaintenanceService < ApplicationRecord
  belongs_to :car
  
  # Definir el enum para el campo status.
  enum status: { pending: 0, in_progress: 1, completed: 2 }
  
  # Validación para que la descripción esté presente.
  validates :description, presence: true
  
  # Validación para que la fecha esté presente y sea una fecha pasada o presente.
  validates :date, presence: true, timeliness: { on_or_before: -> { Date.current }, type: :date }
end
