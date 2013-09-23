class Property < ActiveRecord::Base
  attr_reader :property
  has_many :hold_deals
  after_find :set_property
  def initialize(attributes = {})
    super
    # puts attributes[:address].nil?

    if attributes[:address].nil?
      raise ArgumentError, "The address options is required" 
    end

    if attributes[:zipcode].nil?
      raise ArgumentError, "The zipcode options is required" 
    end
    # p @property

    set_property()
    # raise RuntimeError, "There is no property found for this address!" unless @property.zpid

    @address = attributes["address"] if attributes.present? && !attributes["city"].present?
    begin
      self.zillowId = @property.zpid if @property  
    rescue NoMethodError => e
      self.zillowId = "No Address Found on Zillow"      
    end
  end

  def get_property(attributes = self)
        # can save Zillow Data!
        Rubillow::PropertyDetails.deep_search_results address: attributes[:address], citystatezip: attributes[:zipcode]
  end

  def set_property()
    @property ||= get_property(self)
  end
end
