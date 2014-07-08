task :populate_players_from_csv => :environment do
  PLAY_COL = [
        :player_id,
        :birth_year,
        :first,
        :last
        ]
  PLAY_MAP = Hash[PLAY_COL.map.with_index.to_a]

  $/ = "\r" # make carriage return the line separator
  File.readlines('db/csv/Master-small.csv').each_with_index do |line, i|
    next if i == 0
    play_line = line.gsub(/\r/, '').split(',')
    player = Player.new
    PLAY_COL.each do |play_col|
      player[play_col] = play_line[PLAY_MAP[play_col]]
    end

    begin
      player.save!
    rescue => e
      "Error: #{e} on Master-small.csv index #{i}"
    end
  end
end
