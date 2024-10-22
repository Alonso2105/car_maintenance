json.array!(@cars) do |car|
  json.partial! 'car', car: car
end