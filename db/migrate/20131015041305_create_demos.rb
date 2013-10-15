class CreateDemos < ActiveRecord::Migration
  def change
    create_table :demos do |t|
      t.references :team, index: true
      t.references :poll, index: true

      t.timestamps
    end
  end
end
