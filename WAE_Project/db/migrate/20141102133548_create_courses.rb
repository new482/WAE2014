class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :coursename
      t.references :department, index: true

      t.timestamps
    end
  end
end
