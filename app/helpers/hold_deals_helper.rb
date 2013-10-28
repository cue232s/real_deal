module HoldDealsHelper
    def set_price_color(property)
        if property.updated_property_details.code ==0
            if property.updated_property_details == 0
                return "alert-success"
            elsif property.updated_property_details.code 
                return ""                  
            end 
        end
    end
end
