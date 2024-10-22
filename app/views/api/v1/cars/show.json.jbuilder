json.extract! @car, :id, :plate_number, :model, :year
json.maintenance_services @car.maintenance_services, partial: 'api/v1/maintenance_services/maintenance_service', as: :maintenance_service
