class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.date :date
      t.boolean :active
      t.string :phone_number

      t.timestamps
    end
  end
end
