class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :course, index: true
      t.references :user, index: true
      t.date :createddate
      t.boolean :status
      t.string :year
      t.string :posttype
      t.integer :question_id
      t.boolean :accepted
      t.integer :acceptedby

      t.timestamps
    end
  end
end
