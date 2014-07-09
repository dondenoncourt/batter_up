# == Schema Information
#
# Table name: players
#
#  player_id  :string(255)      primary key
#  birth_year :integer
#  first      :string(255)
#  last       :string(255)
#

class Player < ActiveRecord::Base
  self.primary_key = :player_id
  has_many :battings

  def name
    "#{first} #{last}"
  end

  def batting_average(year)
    at_bats = battings.where(year: year).sum(:at_bats)
    hits = battings.where(year: year).sum(:hits)
    return nil if at_bats == 0
    hits / at_bats.to_f
  end

  # must manage a player in multiple teams in one year
  def self.most_improved_player(year)
    candidates = Batting.where("year in (#{year-1},#{year}) and at_bats >= 200").map(&:player_id)
    player_percentage_map = {}
    candidates.each do |player_id|
      player = Player.find(player_id)
      ave_year_1 = player.batting_average(year-1)
      ave_year_2 = player.batting_average(year)
      player_percentage_map[player_id] = ((ave_year_1 / ave_year_2.to_f)*100).round/100.0 if !ave_year_1.nil? && !ave_year_2.nil?
    end
    player_percentage_map.delete_if {|k,v| v == 0.0}
    top_honors = player_percentage_map.sort_by{|k,v| v}.last
    Player.find(top_honors[0])
  end

  # highest batting average	AND	the most home runs AND the most RBI in their league
  def self.player_of_the_year(year, league)
    runs_batted_in_league_winner = Batting.where(year: year, league: league).where("at_bats >= 400").order(:runs_batted_in).last.player
    home_runs_league_winner = Batting.where(year: year, league: league).where("at_bats >= 400").order(:home_runs).last.player
    batting_averages = {}
    Batting.where(year: year, league: league).where("at_bats >= 400").each {|b| batting_averages[b.player_id] = b.batting_average}
    batting_average_league_winner = Player.find(batting_averages.sort_by{|k, v| v}.last[0])

    if runs_batted_in_league_winner == home_runs_league_winner &&
       home_runs_league_winner == batting_average_league_winner
      batting_average_league_winner
    else
      nil
    end
  end
end
