class Property < ActiveRecord::Base
  attr_reader :property
  has_many :hold_deals
  after_find :get_property
  def initialize(attributes = {address: "5381 Pershing Ave, apt 203", zipcode: "63112"})
    super
    puts attributes[:address].nil?

    if attributes[:address].nil?
      raise ArgumentError, "The address options is required" 
    end

    if attributes[:zipcode].nil?
      raise ArgumentError, "The zipcode options is required" 
    end
    p @property

    get_property(attributes)

    @address = attributes["address"] if attributes.present? && !attributes["city"].present?
    self.zillowId = @property.zpid if @property
  end

  def get_property(attributes = self)
        # can save Zillow Data!
        @property = Rubillow::PropertyDetails.deep_search_results address: attributes[:address], citystatezip: attributes[:zipcode]
  end
end
