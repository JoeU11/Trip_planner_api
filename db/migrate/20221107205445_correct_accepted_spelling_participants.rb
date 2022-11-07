class CorrectAcceptedSpellingParticipants < ActiveRecord::Migration[7.0]
  def change
    remove_column :participants, :acceted
    add_column :participants, :accepted, :boolean, default: :false
  end
end
