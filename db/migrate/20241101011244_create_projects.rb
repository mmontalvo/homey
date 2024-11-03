class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
