class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :project_code
      t.boolean :open

      t.timestamps
    end
  end
end
