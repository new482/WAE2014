class AddExamtypeToExams < ActiveRecord::Migration
  def change
    add_column :exams, :examtype, :string
  end
end
