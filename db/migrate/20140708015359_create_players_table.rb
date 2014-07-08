class CreatePlayersTable < ActiveRecord::Migration
  def change
    create_table :players, {id: false, primary_key: :player_id} do |t|
        t.string  :player_id
        t.integer :birth_year
        t.string  :first
        t.string  :last
    end
    add_index(:players, :player_id, unique: true)
  end
end
