# spec/models/maintenance_service_spec.rb
require 'rails_helper'

RSpec.describe MaintenanceService, type: :model do
  # Prueba de relaciones
  describe 'associations' do
    it { should belong_to(:car) }
  end

  # Pruebas de validaciones
  describe 'validations' do
    it 'es válido con todos los atributos presentes' do
      car = Car.create!(plate_number: 'ABC123', model: 'Toyota', year: 2020)
      service = MaintenanceService.new(description: 'Cambio de aceite', date: Date.today, car: car, status: :pending)
      expect(service).to be_valid
    end

    it 'no es válido sin descripción' do
      car = Car.create!(plate_number: 'ABC123', model: 'Toyota', year: 2020)
      service = MaintenanceService.new(description: nil, date: Date.today, car: car, status: :pending)
      expect(service).to_not be_valid
      expect(service.errors[:description]).to include("can't be blank")
    end

    it 'no es válido sin fecha' do
      car = Car.create!(plate_number: 'ABC123', model: 'Toyota', year: 2020)
      service = MaintenanceService.new(description: 'Cambio de aceite', date: nil, car: car, status: :pending)
      expect(service).to_not be_valid
      expect(service.errors[:date]).to include("can't be blank")
    end

    it 'no es válido si la fecha está en el futuro' do
      car = Car.create!(plate_number: 'ABC123', model: 'Toyota', year: 2020)
      future_date = Date.today + 1.day
      service = MaintenanceService.new(description: 'Cambio de aceite', date: future_date, car: car, status: :pending)
      expect(service).to_not be_valid
      expect(service.errors[:date]).to include("la fecha debe ser una fecha pasada o presente")
    end
  end

  # Pruebas del enum
  describe 'status enum' do
    it 'define los estados correctamente' do
      expect(MaintenanceService.statuses).to eq({ "pending" => 0, "in_progress" => 1, "completed" => 2 })
    end

    it 'permite cambiar el estado a completed' do
      car = Car.create!(plate_number: 'ABC123', model: 'Toyota', year: 2020)
      service = MaintenanceService.create!(description: 'Cambio de aceite', date: Date.today, car: car, status: :pending)
      service.completed!
      expect(service.status).to eq('completed')
    end
  end
end
