
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

### 6.5 game
game_eff <- function(n) {
  won <- rep(0, n)
  ### initialize an empty list
  for(i in 1:n){
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
    
    if (total_game_runs >= 6) {
      ### if the Padres scored 5 or more runs, they win the game
      won[i] = 1
    } else if (total_game_runs == 5) {
      ### if the Padres score exactly 4 runs, they "win" 13% of the time
      ### as calculated by the binomial below
      won[i] = rbinom(1, 1, 0.13)
    } else {
      ### if they score less than 4 runs, they lose the game
      won[i] = 0
    }
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

### 7.5 season 2.0

season_eff <- function(n = 162){
  sum(game_eff(n = n))
}

timings <- bench::mark(
  season = season,
  season_eff = season_eff,
  check = FALSE
)
timings
plot(timings)

timings2 <- bench::mark(
  game = game,
  game_eff = game_eff,
  check = FALSE
)
timings2
plot(timings2)
