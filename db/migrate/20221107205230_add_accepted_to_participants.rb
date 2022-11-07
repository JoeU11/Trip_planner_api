class AddAcceptedToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :acceted, :boolean, default: :false
  end
end
