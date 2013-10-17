class AddActiveToDemo < ActiveRecord::Migration
  def change
    add_column :demos, :active, :boolean
  end
end
