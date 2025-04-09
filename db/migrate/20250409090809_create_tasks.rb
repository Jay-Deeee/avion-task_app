class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.datetime :due_date
      t.string :status, default: 'pending'
      t.string :priority, default: 'medium'

      t.timestamps
    end
  end
end
