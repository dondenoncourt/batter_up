# == Schema Information
#
# Table name: players
#
#  player_id      :string(255)      primary key
#  birth_year     :integer
#  first          :string(255)
#  last           :string(255)
#  at_bats        :integer
#  hits           :integer
#  doubles        :integer
#  triples        :integer
#  home_runs      :integer
#  runs_batted_in :integer
#

class Player < ActiveRecord::Base
  self.primary_key = :player_id
  has_many :batting

  def name
    "#{first} #{last}"
  end
end
