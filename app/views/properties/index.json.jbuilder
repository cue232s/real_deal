json.array!(@properties) do |property|
  json.extract! property, :address, :address2, :zipcode, :state, :zillowId, :value
  json.url property_url(property, format: :json)
end