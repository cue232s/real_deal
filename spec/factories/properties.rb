FactoryGirl.define do
    factory :property do
      ignore do
        address "5381 Pershing Ave, Apt 203"
        zipcode "63112"
      end
      initialize_with {Property.new(address: address, zipcode: zipcode)}
    end
end