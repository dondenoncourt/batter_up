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

  def years_batting_average(year)
    at_bats = battings.where(year: year).sum(:at_bats)
    hits = battings.where(year: year).sum(:hits)
    return nil if at_bats == 0
    hits / at_bats.to_f
  end
end
