class CreateHoldDeals < ActiveRecord::Migration
  def change
    create_table :hold_deals do |t|
      t.integer :property_id 

      #Investment (purchase/rehab)
      #p1
      #t.total_investment 
        #s1
        t.decimal :asking_price, :precision => 8, :scale => 2
        t.decimal :asking_price_per_sq_ft , :precision => 8, :scale => 2
        t.float :asking_price_discount 
        # @rehab_cost
          t.decimal :rehab_cost_per_sq_ft, :precision => 8, :scale => 2
          #t.property_sq_ft


      #Property Value / Post Rehab
      t.decimal :est_arv, :precision => 8, :scale => 2
        t.decimal :comp_avg_per_sq_ft, :precision => 8, :scale => 2
        #t.property.property.finished_square_feet

      # #Exit
      # #t.cash_out
      #   t.arv_per_sq_ft :decimal, :precision => 8, :scale => 2
      #   t.gross_total :decimal, :precision => 8, :scale => 2
      #   t.marketing_expense :decimal, :precision => 8, :scale => 2
      #   t.re_commision :decimal, :precision => 8, :scale => 2
      # t.cost_of_capital :decimal, :precision => 8, :scale => 2

      # t.exit_percentage_of_arv :decimal, :precision => 8, :scale => 2
      # t.exit_percentage_of_arv_per_sq_ft :decimal, :precision => 8, :scale => 2
      # t.exit_sale_price :decimal, :precision => 8, :scale => 2

      # t.comps_avg_per_sq_ft :decimal, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
