class AddPathToExams < ActiveRecord::Migration
  def change
    add_column :exams, :path, :string
  end
end
