class CreatePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :points do |t|
      t.string :text
      t.string :author
      t.string :location
      t.string :timestamp
      t.references :pad, null: false, foreign_key: true

      t.timestamps
    end
  end
end
