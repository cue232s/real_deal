class CreateHoldDeals < ActiveRecord::Migration
  def change
    create_table :hold_deals do |t|
      t.property_id :integer

      #Investment (purchase/rehab)
      #p1
      #t.total_investment 
        #s1
        t.asking_price : :decimal, :precision => 8, :scale => 2
        t.aslking_price_per_sq_ft :decimal, :precision => 8, :scale => 2
        t.asking_price_discount :float
        # @rehab_cost
        t.rehab_cost_per_sq_ft :decimal, :precision => 8, :scale => 2


      #Property Value / Post Rehab
      t.est_arv :decimal, :precision => 8, :scale => 2
        t.comp_avg_per_sq_ft :decimal, :precision => 8, :scale => 2
        #t.property.sqft

      #Exit
      #t.cash_out
        t.arv_per_sq_ft :decimal, :precision => 8, :scale => 2
        t.gross_total :decimal, :precision => 8, :scale => 2
        t.marketing_expense :decimal, :precision => 8, :scale => 2
        t.re_commision :decimal, :precision => 8, :scale => 2
      t.cost_of_capital :decimal, :precision => 8, :scale => 2

      t.exit_percentage_of_arv :decimal, :precision => 8, :scale => 2
      t.exit_percentage_of_arv_per_sq_ft :decimal, :precision => 8, :scale => 2
      t.exit_sale_price :decimal, :precision => 8, :scale => 2

      t.comps_avg_per_sq_ft :decimal, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
