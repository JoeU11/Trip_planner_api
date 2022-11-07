class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants do |t|
      t.string :trip_id
      t.string :user_id
      t.integer :authority

      t.timestamps
    end
  end
end
