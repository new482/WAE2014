class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :schoolname
      t.string :description

      t.timestamps
    end
  end
end
