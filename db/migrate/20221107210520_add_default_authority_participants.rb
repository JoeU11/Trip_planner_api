class AddDefaultAuthorityParticipants < ActiveRecord::Migration[7.0]
  def change
    change_column :participants, :authority, :integer, default: 0
  end
end
