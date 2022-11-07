class AddEmailToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :email, :string
  end
end
