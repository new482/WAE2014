class AddCreditsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :credit, :string
  end
end
