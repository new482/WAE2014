class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :departmentname
      t.references :school, index: true

      t.timestamps
    end
  end
end
