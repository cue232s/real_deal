class HoldDeal < ActiveRecord::Base
  belongs_to :property, dependent: :destroy
  after_find :set_assumptions
  def initialize(options={})
    super
    self.property_id = self.property.id if self.property
    raise ArgumentError, ":property_id required" unless options[:property_id] || self.property_id
    self.asking_price = self.property.property.price
    set_assumptions

  end

  def total_investment
    @total_investment = self.asking_price.to_f - (self.asking_price.to_f * self.asking_price_discount.to_f)
    @total_investment += self.rehab_cost.to_f
    @total_investment.to_f
  end

  def property_address
    self.property.address
  end

  def rehab_cost
    self.rehab_cost_per_sq_ft * property_sq_ft.to_i
  end

  def property_sq_ft
    self.property.property.finished_square_feet
  end

  def calculate_arv
    get_comps_avg
    p self.property_sq_ft.to_f
    p self.comp_avg_per_sq_ft.to_f
    self.est_arv = self.property_sq_ft.to_f * self.comp_avg_per_sq_ft.to_f
  end

  #most serrious method.. profits live and die by the
  #accuracy of this method
  def get_comps_avg
    # p self.property.zillowId
    comps ||= Rubillow::PropertyDetails.deep_comps( {zpid: self.property.zillowId, count: 3}  )
    # p comps.principal.zpid
    # p comps.comparables.size
    comp_list = []
    comps.comparables.each do |c|
      comp_list << (c.last.price.to_f/c.last.finished_square_feet.to_f)
      # p c.last.price
      # p "-" + c.last.finished_square_feet
    end unless !comps.success?
    #take the sum of
    self.comp_avg_per_sq_ft = comp_list.inject{ |sum, el| sum + el }.to_f / comp_list.size
    # p self.comp_avg_per_sq_ft.to_f
  end

  def set_assumptions(assump={})
    self.asking_price_discount = assump[:asking_price_discount] || 0.30
    self.rehab_cost_per_sq_ft ||= assump[:rehab_cost_per_sq_ft] ||BigDecimal.new("30.00")
  end
end
