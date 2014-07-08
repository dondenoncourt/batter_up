task :list_sample_statistics => :environment do
  puts Player.count
  puts "A few sample statistics:"

  puts "Most improved batting average from 2009 to 2010"
  candidates = Batting.where("year in (2009,2010) and at_bats >= 200").map(&:player_id)
  improved = {} # key: player_id, value: improved percentage
  candidates.each do |player_id|
    player = Player.find(player_id)
    two_nine = player.years_batting_average(2009)
    two_ten = player.years_batting_average(2010)
    improved[player_id] = ((two_nine / two_ten.to_f)*100).round/100.0 if !two_nine.nil? && !two_ten.nil?
  end
  improved.delete_if {|k,v| v == 0.0}
  top_honors = improved.sort_by{|k,v| v}.last
  most_improved = Player.find(top_honors[0])
  two_nine_batting = Batting.where(player_id: most_improved.player_id, year: 2009).first
  two_ten_batting = Batting.where(player_id: most_improved.player_id, year: 2010).first
  puts "The most improved player was  #{most_improved.name} with an 2009 to 2010 improvement of #{(top_honors[1]*100).to_i}%"
  most_improved.battings.where("year in (2009, 2010)").each do |batting|
    puts "Year: #{batting.year} team: #{batting.team_id}, at bats: #{batting.at_bats}, hits: #{batting.hits}"
  end

  puts "*** Slugging percentage for all players on the Oakland As in 2007 ***"
  Batting.where(team_id: 'OAK', year: 2007).each do |b|
    puts "#{b.player.name}: #{b.slugging_percent}"
  end

  # highest batting average	AND	the most home runs AND the most RBI in their league

  [2011, 2012].each do |year|
    ['AL', 'NL'].each do |league|
      puts "\n*** #{league} triple crown winner for #{year} ***\n"

      runs_batted_in_league_winner = Batting.where(year: year, league: league).where("at_bats >= 400").order(:runs_batted_in).last.player
      home_runs_league_winner = Batting.where(year: year, league: league).where("at_bats >= 400").order(:home_runs).last.player
      batting_averages = {}
      Batting.where(year: year, league: league).where("at_bats >= 400").each {|b| batting_averages[b.player_id] = b.batting_average}
      batting_average_league_winner = Player.find(batting_averages.sort_by{|k, v| v}.last[0])

      puts "runs_batted_in_league_winner: "+ runs_batted_in_league_winner.name
      puts "home_runs_league_winner: "+ home_runs_league_winner.name
      puts "batting_average_league_winner: "+ batting_average_league_winner.name

      if runs_batted_in_league_winner == home_runs_league_winner &&
         home_runs_league_winner == batting_average_league_winner
        puts "<<<<<< WINNER of the TRIPLE CROWN >>>>>>>"
        puts "<<<<<< #{batting_average_league_winner.name} >>>>>>>"
      else
        puts ">>>>>> no winner <<<<<<<"
      end
    end
  end


end
