require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
   test "fixtures loaded" do
     assert_equal 7, Player.count
     assert_equal 'Seven', Player.last.last
   end
   test "batting average" do
     assert_equal 0.4, Player.first.batting_average(2012)
   end
   test "most improved player" do
     assert_equal 'Player Five', Player.most_improved_player(2012).name
   end
   test "player of the year" do
     assert_equal 'Player One', Player.player_of_the_year(2008, 'AL').name
     assert_equal 'Player Five', Player.player_of_the_year(2011, 'AL').name
   end
end
