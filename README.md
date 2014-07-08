## Welcome to Batter Up

This is a sample Rails application that demonstrates how to create and
populate an Sqlite database from CSV files. 

## Getting Started

1. Install Rails 4.1 at the command prompt if you haven't yet:

        gem install rails

2. At the command prompt, checkout batter_up from github:

        git clone git@github.com:dondenoncourt/batter_up.git

3. Change directory to `batter_up`

        cd batter_up

4. Update your gems

        bundle install

5. Run the database migrations to populate your Sqlite database

        rake db:migrate


6. Populate the Players database from the csv (in db/csv)

        rake populate_players_from_csv

7. Populate the Battings database from the csv (in db/csv)

        rake populate_battings_from_csv
