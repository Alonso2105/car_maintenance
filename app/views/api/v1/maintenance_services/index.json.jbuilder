json.array! @maintenance_services do |maintenance_service|
  json.extract! maintenance_service, :id, :description, :status, :date
end
