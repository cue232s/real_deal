class Property < ActiveRecord::Base
  attr_reader :property, :zillowId
  has_many :holdDeals
  def initialize(attributes = {})
    super
    puts attributes[:address].nil?

    if attributes[:address].nil?
      raise ArgumentError, "The address options is required" 
    end

    if attributes[:zipcode].nil?
      raise ArgumentError, "The zipcode options is required" 
    end
    p @property

    @property = Rubillow::PropertyDetails.deep_search_results address: attributes[:address], citystatezip: attributes[:zipcode]
    @address = attributes["address"] if attributes.present? && !attributes["city"].present?
    @zillowId = @property.zpid if @property
  end
end
