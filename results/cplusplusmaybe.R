
### 1. get_hit
get_hit <- function(OBP) {
  rbinom(1,1, OBP)
}

### 2. runs
runs <- function(number_hits){
  if(number_hits < 4){
    runs = 0
  }
  else{
    runs = number_hits - 3
  }
}

### 2.5 import the data
PadresBatting <- readr::read_csv(here::here("data", "PadresBatting.csv"))


### 3. base_reached
### If a player doesn't get an out, which base do they reach?
base_reached <- function(player){
  values <- c(1, 2, 3, 4)
  probs <- c(PadresBatting$First[player], PadresBatting$Second[player],
             PadresBatting$Third[player], PadresBatting$Home[player])
  cumulative_probs <- cumsum(probs)
  
  u <- runif(1)
  values[findInterval(u, cumulative_probs) + 1] 
}

### 4. half_inning
half_inning <- function(starting_player) {
  number_hits <- rep(0,9)
  outs = 0 
  n_players <- 9
  for(i in starting_player:n_players){
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
  if(player == 9){
    for(i in 1:n_players){
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

starting_player <- 1
n_players <- 9
number_hits <- rep(0,9)
outs = 0 
base_achieved_loop <- function(){
  for(i in starting_player:n_players){
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
  hits = sum(unlist(number_hits))
  hits_and_player <- data.frame(hits = hits, 
                                last_player = player,
                                runs = runs(hits))
  return(hits_and_player)
}

# cppFunction('int one() {
#   return 1;
# }')

# cppFunction('NumericVector pdistC(double x, NumericVector ys) {
#   int n = ys.size();
#   NumericVector out(n);
# 
#   for(int i = 0; i < n; ++i) {
#     out[i] = sqrt(pow(ys[i] - x, 2.0));
#   }
#   return out;
# }')

cppFunction('NumericVector base_achieved_C(NumericVector O) {
  int n = ys.size();
  NumericVector out(n);

  for(int i = 0; i < n; ++i) {
    out[i] = sqrt(pow(ys[i] - x, 2.0));
  }
  return out;
}')

