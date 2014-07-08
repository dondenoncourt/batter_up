# == Schema Information
#
# Table name: battings
#
#  id             :integer          not null, primary key
#  player_id      :string(255)
#  year           :integer
#  league         :string(255)
#  team_id        :string(255)
#  at_bats        :integer
#  hits           :integer
#  doubles        :integer
#  triples        :integer
#  home_runs      :integer
#  runs_batted_in :integer
#

class Batting < ActiveRecord::Base
  belongs_to :player

  #Batting.where(player_id: 'volqued01').each {|b| puts "year #{b.year} slugging: #{b.slugging_percent}"}
  def slugging_percent
    return 0 if at_bats == 0
    begin
      percent =
      ((hits - doubles - triples - home_runs)	+
       (2	*	doubles)	+
       (3	*	triples)	+
       (4	*	home_runs)
      )	/	at_bats.to_f
      (percent*1000).round/1000.0
    rescue
      0
    end
  end
  def batting_average
    return 0 if at_bats == 0
    hits / at_bats.to_f
  end

end

