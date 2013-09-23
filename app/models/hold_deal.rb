class HoldDeal < ActiveRecord::Base
  belongs_to :property, dependent: :destroy
  after_find :set_assumptions
  def initialize(options={})
    super
    self.property_id = self.property.id if self.property
    raise ArgumentError, "This Deal Must be have a :property_id" unless options[:property_id] || self.property_id
    self.asking_price = self.property.property.price
    set_assumptions

  end

  def total_investment 
    @total_investment = self.asking_price - (self.asking_price * self.asking_price_discount)
    @total_investment += self.rehab_cost
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
    self.est_arv = self.property.property.finished_square_feet.to_i * self.comp_avg_per_sq_ft
  end

  #most serrious method.. profits live and die by the 
  #accuracy of this method
  def get_comps_avg
    # p self.property.zillowId
    comps ||= Rubillow::PropertyDetails.deep_comps( {zpid: self.property.zillowId, count: 3}  )
    p comps.principal.zpid
    comp_sum = 0
    comps.comparables.each do |c|
      comp_sum += c.last.price.to_f/c.last.finished_square_feet.to_i 
    end unless !comps.success?
    #take the sum of 
    self.comp_avg_per_sq_ft = comp_sum/comps.comparables.size.to_i
  end

  def set_assumptions(assump={})
    self.asking_price_discount = assump[:asking_price_discount] || 0.0
    self.rehab_cost_per_sq_ft ||= assump[:rehab_cost_per_sq_ft] || BigDecimal.new("30.00")
  end
end
