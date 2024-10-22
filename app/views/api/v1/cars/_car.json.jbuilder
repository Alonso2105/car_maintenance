# app/views/api/v1/cars/_car.json.jbuilder
json.extract! car, :id, :plate_number, :model, :year
json.maintenance_services car.maintenance_services do |maintenance_service|
  json.partial! 'api/v1/maintenance_services/maintenance_service', maintenance_service: maintenance_service
end
