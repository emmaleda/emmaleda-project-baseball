
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


# second function, to record an inning
half_inning <- function(starting_player) {
  number_hits <- list() 
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
      ### we need to stop running the simulation once we've made 3 outs
      ### so the function stops once 3 outs have been reached
      number_hits[i] <- get_hit(PadresBatting$OBP[i])
      ### here, we record if a player achieves a hit
      if(number_hits[i] == 0){
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
        number_hits[i] <- get_hit(PadresBatting$OBP[i])
        if(number_hits[i] == 0){
          outs = outs + 1
        }
        player <- i
      }
    }  
  }
  hits_and_player <- data.frame(hits = sum(unlist(number_hits)), 
                                last_player = player)
  return(hits_and_player)
  ### the function returns a data frame of the number of hits
  ### and the player who was batting when the last
  ### out occured
}

## examples
half_inning(1)
half_inning(3)
half_inning(9)


# notes: 
# 1. n_players needs to be motified so that it restarts with 
#    player 1 once player 9 has hit
# 2. currently, we've recorded whether a player has not made an out,
#    which means we know they made it to a base, but
#    just because they made it to a base, doesn't mean they 
#    scored a run, so this needs to be modified as well
# 3. we'll stick to base to base to start with scoring runs, so any value
#    above 4 would represent (n - 4) runs scored before an inning ends

