class CreateHoldDeals < ActiveRecord::Migration
  def change
    create_table :hold_deals do |t|

      t.timestamps
    end
  end
end
