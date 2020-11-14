
# Our other file is getting very crowded, so I'm going to create
# the more complicated function starting in this new file
 

# Try with just one player
values <- c(  1,    2,    3,    4)
probs <- c(0.20, 0.15, 0.25, 0.40)
cumulative_probs <- cumsum(probs)

values <- c(  1,    2,    3,    4)
probs <- c(PadresBatting$First[1], PadresBatting$Second[1],
           PadresBatting$Third[1], PadresBatting$Home[1])
cumulative_probs <- cumsum(probs)

u <- runif(1)
values[findInterval(u, cumulative_probs) + 1] 


# Turn above code into a function
base_reached <- function(player){
  ### this code I largely borrowed from homework 4 02_random-numbers
  ### since the probability a player makes it to first, second, third 
  ### or home is mutually exclusing
  values <- c(1, 2, 3, 4)
  probs <- c(PadresBatting$First[player], PadresBatting$Second[player],
             PadresBatting$Third[player], PadresBatting$Home[player])
  cumulative_probs <- cumsum(probs)
  
  u <- runif(1)
  ### generates one randome number between 0 and 1
  values[findInterval(u, cumulative_probs) + 1] 
  ### figures out where that u falls within the cumulative
  ### probability and returns 1, 2, 3, or 4 based on what u is
}

# example
base_reached(1)

###############################################################################################################

# Updating the half_inning() function:

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
      if(hit == 1){
        hit <- base_reached(i)
        ### if the player does get a hit, base_reached(player) will determine
        ### which base they make it to
      }
      number_hits[i] <- number_hits[i] + hit
      ### here, we record if a player achieves a hit
      ### by adding the previous number of hits (starts at 0)
      ### to whether they get a hit or not
      ### we add the previous number of hits just in case
      ### a player hits more than once per inning
      if(hit == 0){
        outs = outs + 1
        ### records how many outs for the team
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
        if(hit == 1){
          hit <- base_reached(i)
        }
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
}

## examples
half_inning(1)
half_inning(3)
half_inning(9)
