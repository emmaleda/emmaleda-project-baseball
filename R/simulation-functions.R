

### 1. get_hit
get_hit <- function(OBP) {
  rbinom(1,1, OBP)
}

### 2. runs
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

### 2.5 import the data
PadresBatting <- readr::read_csv(here::here("data", "PadresBatting.csv"))


### 3. base_reached
### If a player doesn't get an out, which base do they reach?
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

### 4. half_inning
half_inning <- function(starting_player) {
  number_hits <- rep(0,9)
  ### a list to store how many hits each player scores
  outs = 0 
  ### number of outs the team scores, starts at 0 outs for each inning
  n_players <- 9
  ### number of players in the lineup, will always be 9
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


### 5. next_player
next_player <- function(last_player){
  next_player <- 0
  ### initialize a variable called "next_player" and set it to 0
  if(last_player < 9){
    next_player = last_player + 1
    ### as long as the player entered isn't 9, the next player will
    ### be the last_player + 1
  } else {next_player = 1}
  ### if the last player is player 9, then the next player up is 
  ### player 1, not player 10 (who doesn't exist)
  return(next_player)
}

### 6. game
game <- function() {
  first_inning   <- half_inning(starting_player = 1)
  ### the first player will always be player 1 (in the Padres case, Tatis Jr.)
  second_inning  <- half_inning(starting_player = next_player(first_inning$last_player))
  ### the initial player for the second inning will be the player who comes after
  ### the player who hit last in the first inning, which is what the function
  ### "next_player" computes
  third_inning   <- half_inning(starting_player = next_player(second_inning$last_player))
  ### and so on
  fourth_inning  <- half_inning(starting_player = next_player(third_inning$last_player))
  fifth_inning   <- half_inning(starting_player = next_player(fourth_inning$last_player))
  sixth_inning   <- half_inning(starting_player = next_player(fifth_inning$last_player))
  seventh_inning <- half_inning(starting_player = next_player(sixth_inning$last_player))
  eighth_inning  <- half_inning(starting_player = next_player(seventh_inning$last_player))
  nineth_inning  <- half_inning(starting_player = next_player(eighth_inning$last_player))
  
  total_game_runs <-
    first_inning$runs + second_inning$runs + third_inning$runs + fourth_inning$runs + fifth_inning$runs +
    sixth_inning$runs + seventh_inning$runs + eighth_inning$runs + nineth_inning$runs
  ### "total_game_runs" adds up all of the runs that the Padres scored each inning
  won <- 0
  ### initialize an empty list
  if (total_game_runs >= 6) {
    ### if the Padres scored 5 or more runs, they win the game
    won = 1
  } else if (total_game_runs == 5) {
    ### if the Padres score exactly 4 runs, they "win" 13% of the time
    ### as calculated by the binomial below
    won = rbinom(1, 1, 0.13)
  } else {
    ### if they score less than 4 runs, they lose the game
    won = 0
  }
  ### ultimately, game() returns a 1 if the Padres won and a
  ### 0 if they lost
  return(unlist(won))
}

### 7. season
season <- function(){
  finalgamescore <- rep(0, 162)
  for(i in 1:162){
    ### save the result of game() in a vector names "finalgamescore"
    finalgamescore[i] <- game()
  }
  ### we sum up all of the values in the vector to get the total
  ### games won in a season
  return(sum(finalgamescore))
}
