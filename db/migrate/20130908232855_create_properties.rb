class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :address
      t.string :address2
      t.string :zipcode
      t.string :state
      t.string :zillowId
      t.float :value

      t.timestamps
    end
  end
end
