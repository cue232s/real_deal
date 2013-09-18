class HoldDeal < ActiveRecord::Base
  belongs_to :property, dependent:

  def total_investment 
    @total_investment = self.asking_price - (self.asking_price * self.asking_price_discount)
    @total_investment += self.rehab_cost
  end

  def caluculate_arv
    
  end
end
