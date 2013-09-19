class HoldDeal < ActiveRecord::Base
  belongs_to :property, dependent: :destroy
  def initialize(options={})
    super
    self.asking_price = self.property.property.price
  end
  def total_investment 
    @total_investment = self.asking_price - (self.asking_price * self.asking_price_discount)
    @total_investment += self.rehab_cost
  end

  def calculate_arv
    get_comps_avg
    self.est_arv = self.property.property.finished_square_feet * self.comp_avg_per_sq_ft
  end

  def get_comps_avg
    comps = Rubillow::PropertyDetails.deep_comps self.property.zillowId  
    comp_sum = 0
    comps.each do |c|
      comp += c.price/c.finished_square_feet 
    end unless !comps.success?
    return comp_sum/comps.size
  end
end
