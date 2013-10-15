class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :demo, index: true
      t.string :from
      t.text :raw
      t.integer :score

      t.timestamps
    end
  end
end
