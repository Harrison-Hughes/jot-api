class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :project_code
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
