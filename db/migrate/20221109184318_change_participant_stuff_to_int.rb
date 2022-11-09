class ChangeParticipantStuffToInt < ActiveRecord::Migration[7.0]
  def change
    remove_column :participants, :user_id
    add_column :participants, :user_id, :integer
    remove_column :participants, :trip_id
    add_column :participants, :trip_id, :integer
  end
end
