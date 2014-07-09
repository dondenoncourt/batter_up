task :list_sample_statistics => :environment do
  puts "A few sample statistics:"

  puts "Most improved batting average from 2009 to 2010"
  most_improved_player = Player.most_improved_player(2010)
  puts most_improved_player.name
  [2009..2010].each do |year|
    most_improved_player.battings.where(year: year).each do |batting|
      puts "Year: #{batting.year} team: #{batting.team_id}, at bats: #{batting.at_bats}, hits: #{batting.hits}"
    end
  end

  puts "*** Slugging percentage for all players on the Oakland As in 2007 ***"
  Batting.where(team_id: 'OAK', year: 2007).each do |b|
    puts "#{b.player.name}: #{b.slugging_percent}"
  end

  [2011, 2012].each do |year|
    ['AL', 'NL'].each do |league|
      puts "\n*** #{league} triple crown winner for #{year} ***\n"
      player_of_the_year = Player.player_of_the_year(year, league)
      if player_of_the_year
        puts "<<<<<< WINNER of the TRIPLE CROWN >>>>>>>"
        puts "<<<<<< #{player_of_the_year.name} >>>>>>>"
      else
        puts ">>>>>> no winner <<<<<<<"
      end
    end
  end


end
