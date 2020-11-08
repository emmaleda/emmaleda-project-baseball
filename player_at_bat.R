
library(readr)
PadresBatting <- read_csv("PadresBatting.csv")

# first function, for a single at bat
get_hit <- function(OBP) {
  rbinom(1,1, OBP)
}

# example - Tatis Jr.!
get_hit(PadresBatting$OBP[1])

# number of players:
n_players <- length(PadresBatting$OBP)

#third function to record runs per inning 
runs <- function(number_hits){
  if(number_hits < 4){
    runs = 0
  }
  #### if less than four hits occur in an inning then no runs score
  else{
    runs = number_hits - 3
    ### if more than three hits occur in an inning then the number of runs
    ### scored is that number of hits minus the three runners who occupy
    ### the three bases (first, second, third)
  }
}
#test of the runs function
a <- runs(2)
b <- runs(5)
c <- runs(0)
d <- runs(11)
# second function, to record an inning
half_inning <- function(starting_player) {
  number_hits <- rep(0,9)
  ### a list to store how many hits each player scores
  outs = 0 
  ### number of outs the team scores, starts at 0 outs for each inning
  for(i in starting_player:n_players){
    ### the for loop begins at the starting player, at the beginning of the
    ### game, we'll start with the first player (Tatis Jr.!)
    ### but as the game continues, we'll end at different players
    ### so we'll start where we ended, which is why 'starting_player'
    ### is an option to fill in
    if(outs < 3){
      hit <- get_hit(PadresBatting$OBP[i])
      ### we need to stop running the simulation once we've made 3 outs
      ### so the function stops once 3 outs have been reached
      number_hits[i] <- number_hits[i] + hit
      ### here, we record if a player achieves a hit
      ### by adding the previous number of hits (starts at 0)
      ### to whether they get a hit or not
      ### we add the previous number of hits just in case
      ### a player hits more than once per inning
      if(hit == 0){
        ### records how many outs for the team
        outs = outs + 1
      }
      player <- i
      ### records the number of the last player who hits
      ### for the next inning, we'll want to start at the next player
      ### so player + 1
    }
  }
  if(player == 9){
    ### the previous loop with end once we reach player 9, but that's not
    ### how baseball works since we'd restart with player 1 if player 9 hit
    ### and they hadn't reached 3 outs yet; so, if the player is 9 the 
    ### exact same loop as above runs except that it starts at 1
    for(i in 1:n_players){
      ### starts at the first player (Tatis Jr.!)
      if(outs < 3){
        hit <- get_hit(PadresBatting$OBP[i])
        number_hits[i] <- number_hits[i] + hit
        if(hit == 0){
          outs = outs + 1
        }
        player <- i
      }
    }  
  }
  hits = sum(unlist(number_hits))
  hits_and_player <- data.frame(hits = hits, 
                                last_player = player,
                                runs = runs(hits))
  return(hits_and_player)
  ### the function returns a data frame of the number of hits
  ### and the player who was batting when the last
  ### out occured
}

game <- function(half_inning){
  if(sum(runs) < 5){
    game = 0
  }
  else{
    game = 1
  }
}


## examples
half_inning(1)
half_inning(3)
half_inning(9)

game(half_inning)

# notes: 
# 1. n_players needs to be motified so that it restarts with 
#    player 1 once player 9 has hit
#     -> complete
#        and we now have a solution for what to do if a player
#        bats twice in one inning
# 2. currently, we've recorded whether a player has not made an out,
#    which means we know they made it to a base, but
#    just because they made it to a base, doesn't mean they 
#    scored a run, so this needs to be modified as well
#     -> complete
# 3. we'll stick to base to base to start with scoring runs, so any value
#    above 3 would represent (n - 3) runs scored before an inning ends
# 4. because runs right now are counted as whole numbers based on hits per
#    inning being above 3, the expected runs per game that the Padres
#    pitchers gave up will be rounded up to 5, so scoring 5 or more runs
#    results in a win
# 5. this should eventually be modified using a randomized test so that
#    13% of the time when the Padres score exactly 4 runs they get a win,
#    since the Padres gave up 4.87 runs per game in 2019
 

