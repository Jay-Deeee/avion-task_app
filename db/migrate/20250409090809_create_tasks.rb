class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.date :date
      t.datetime :due_date
      t.string :status, default: 'pending'
      t.string :priority, default: 'medium'
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
