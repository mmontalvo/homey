class CreateAudits < ActiveRecord::Migration[7.2]
  def change
    create_table :audits do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :associated_id
      t.string :associated_type
      t.jsonb :audited_changes
      t.string :action
      t.references :user, null: false, foreign_key: true
      t.string :comment
      t.timestamps
    end
  end
end
