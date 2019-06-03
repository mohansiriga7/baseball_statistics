# baseball_statistics

## Installation

1. Run below command to fetch data from XML and create new players information in database.
  ```ruby
  rake create_new_players_in_db:execute RECORD_TYPE="player"
  ```

2. For pagination, we need below gem:
  ```ruby
  gem 'kaminari'
  ```

3. For Sorting, we need below gem:
  ```ruby
  gem 'ransack', '1.8.8'
  ```

4. Calculating OPS(On-base plus slugging)
  The basic equation is <br />
  OPS=OBP+SLG <br />
  OBP= (H+BB+HB)/(AB+BB+SF+HBP))<br />
  and<br />
  SLG=(TB)/(AB)<br />

    where:
    H = hits, 
    BB = bases on balls,
    HBP = times hit by pitch,
    AB = at bats,
    SF = sacrifice flies,
    TB = total bases.
    
  Since we don't have BB and TB information in XML file, it's unable to calculate OBP. So, We are not showing OBP column in frontend.
  
 5. Calculating AVG(average)<br />
   The basic equation is hits divided by at bats (H/AB)<br />
   Since AB is always greater than H for each and every player in our XML file, the result of average for every player is always zero. That's why average column has only zero values.<br />
   
 6. Check the project on heroku [https://baseball-statistics.herokuapp.com/]<br />
   
##Thank You.


## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2018 [srgmohan7@gmail.com], released under the New BSD License
