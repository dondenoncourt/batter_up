task :populate_battings_from_csv => :environment do
  BAT_COL = [
        :player_id,
        :year,
        :league,
        :team_id,
        :at_bats,
        :hits,
        :doubles,
        :triples,
        :home_runs,
        :runs_batted_in
        ]
  BAT_MAP = Hash[BAT_COL.map.with_index.to_a]

  $/ = "\r" # make carriage return the line separator

  File.readlines('db/csv/Batting-07-12.csv').each_with_index do |line, i|
    next if i == 0
    bat_line = line.gsub(/\r/, '').split(',')
    batting = Batting.new 
    BAT_COL.each do |bat_col|
      batting[bat_col] = bat_line[BAT_MAP[bat_col]]
    end
    batting.save!
  end
end
