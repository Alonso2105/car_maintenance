# spec/models/car_spec.rb
require 'rails_helper'

RSpec.describe Car, type: :model do

  # Prueba de relaciones
  describe 'associations' do
    it { should have_many(:maintenance_services).dependent(:destroy) }
  end

  # Pruebas de validaciones
  describe 'validations' do
    it 'es válido con todos los atributos presentes' do
      car = Car.new(plate_number: 'ABC123', model: 'Toyota', year: 2020)
      expect(car).to be_valid
    end

    it 'no es válido sin número de placa' do
      car = Car.new(plate_number: nil, model: 'Toyota', year: 2020)
      expect(car).to_not be_valid
      expect(car.errors[:plate_number]).to include("EL numero de placa es obligatorio")
    end

    it 'no es válido con un número de placa duplicado' do
      Car.create!(plate_number: 'ABC123', model: 'Toyota', year: 2020)
      car = Car.new(plate_number: 'ABC123', model: 'Honda', year: 2019)
      expect(car).to_not be_valid
      expect(car.errors[:plate_number]).to include("El numero de placa debe ser unico")
    end

    it 'no es válido sin modelo' do
      car = Car.new(plate_number: 'ABC123', model: nil, year: 2020)
      expect(car).to_not be_valid
      expect(car.errors[:model]).to include("can't be blank")
    end

    it 'no es válido sin año' do
      car = Car.new(plate_number: 'ABC123', model: 'Toyota', year: nil)
      expect(car).to_not be_valid
      expect(car.errors[:year]).to include("can't be blank")
    end

    it 'no es válido si el año es menor a 1900' do
      car = Car.new(plate_number: 'ABC123', model: 'Toyota', year: 1899)
      expect(car).to_not be_valid
      expect(car.errors[:year]).to include("El año debe estar entre 1900 y el año actual")
    end

    it 'no es válido si el año es mayor al año actual' do
      car = Car.new(plate_number: 'ABC123', model: 'Toyota', year: Date.today.year + 1)
      expect(car).to_not be_valid
      expect(car.errors[:year]).to include("El año debe estar entre 1900 y el año actual")
    end

    it 'es válido con un año dentro del rango permitido' do
      car = Car.new(plate_number: 'ABC123', model: 'Toyota', year: 2020)
      expect(car).to be_valid
    end
  end
end
