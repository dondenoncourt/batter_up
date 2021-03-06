class CreateBattingsTable < ActiveRecord::Migration
  def change
    create_table :battings do |t|
        t.string :player_id
        t.integer :year
        t.string  :league
        t.string  :team_id
        t.integer :grounders 
        t.integer :at_bats 
        t.integer :runs
        t.integer :hits
        t.integer :doubles
        t.integer :triples
        t.integer :home_runs
        t.integer :runs_batted_in
        t.integer :stolen_bases
        t.integer :cs
    end
  end
end
