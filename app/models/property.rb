class Property < ActiveRecord::Base
  attr_reader :property
  has_many :hold_deals
  after_find :set_property_and_variables
  def initialize(attributes = {})
    super
    # puts attributes[:address].nil?

    if attributes[:address].nil?
      raise ArgumentError, "The address options is required"
    end

    if attributes[:zipcode].nil?
      raise ArgumentError, "The zipcode options is required"
    end

    # raise RuntimeError, "There is no property found for this address!" unless @property.zpid
    self.address = attributes["address"] if attributes.present? && attributes["address"].present?
    self.zipcode = attributes["zipcode"] if attributes.present? && attributes["zipcode"].present?
    set_property_and_variables()

    begin
      self.zillowId = @property.zpid if @property
    rescue NoMethodError => e
      self.zillowId = "No Address Found on Zillow"
    end
  end



  def get_property(attributes = self)
    # can't save Zillow Data!
    Rubillow::PropertyDetails.deep_search_results address: attributes[:address], citystatezip: attributes[:zipcode]
  end

  def set_property_and_variables()
    @property ||= get_property(self)
    # if @property is set with useful information
    begin
      if @property
        self.address = @property.address[:street] if @property.address[:street]
        self.zipcode = @property.address[:zipcode] if @property.address[:zipcode]
        self.state = @property.address[:state] if @property.address[:state]
      end
    rescue NoMethodError => e
      
    end
  end


end
