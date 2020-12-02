###
### Improve Efficiency
###

##
## (1) change the runs() function to vector
##
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
  return(runs)
}

number_hits <- 1

runs2 <- function(number_hits){(number_hits - 3) * (number_hits >= 4)}

runs(5)
runs2(5)

timings <- bench::mark(
  runs = runs(10),
  runs2 = runs2(10)
)
timings
plot(timings)

## it seems our original function is faster

##
## (2) use runif() rather than rbinom()
##

# Steps:
# 1. Generate 81x2 random runif 
# 2. compare each to OPB of each player in order
#    * so we have a vector of TRUE/FALSE
# 3. iterate though until we get 3 FALSE
# 4. stop and see if they scored any runs
# 5. continue where the iteration halted until we see another 3 FALSE
# 6. repeat steps 5 & 4 until we have 27 outs


most_bb_and_h <- 72
the_uniform <- runif(most_bb_and_h)
the_OBPs <- rep(PadresBatting$OBP, most_bb_and_h/9)
# the_uniform < the_OBPs
 View(cbind(the_uniform,the_OBPs, the_uniform<the_OBPs))
the_probs <- data.frame(First = rep(PadresBatting$First, most_bb_and_h/9),
                        Second = rep(PadresBatting$Second, most_bb_and_h/9),
                        Third = rep(PadresBatting$Third, most_bb_and_h/9),
                        Home = rep(PadresBatting$Home, most_bb_and_h/9))

#View(the_probs)
#sample(1:4, 63, replace = TRUE, prob = the_probs)

the_bases <- map_int(1:most_bb_and_h, ~sample(1:4, 1, replace = TRUE, prob = the_probs[.x,]))

the_necessary_info <- data.frame(on_base = the_uniform < the_OBPs,
                                 base_reached = the_bases)
out_or_base <- the_necessary_info$on_base*the_necessary_info$base_reached # it's outer space

# out_or_base==0
outs27 <- which(cumsum(out_or_base==0) == 27)[1]

batting_until_game <- out_or_base[1:outs27]

# which(cumsum(batting_until_game==0) == 3)[1]
# sum(batting_until_game[1:7]) - 3
# which(cumsum(batting_until_game==0) == 6)[1]
# which(cumsum(batting_until_game==0) == 9)[1]
# which(cumsum(batting_until_game==0) == 12)[1]
# which(cumsum(batting_until_game==0) == 15)[1]
# which(cumsum(batting_until_game==0) == 18)[1]
# which(cumsum(batting_until_game==0) == 21)[1]
# which(cumsum(batting_until_game==0) == 24)[1]
# which(cumsum(batting_until_game==0) == 27)[1]

#which(cumsum(batting_until_game==0) == seq(3, 27, by = 3))[1]

innings <- map_int(seq(3, 27, by = 3), ~which(cumsum(batting_until_game==0) == .x)[1])
# sum(batting_until_game[1:innings[1]])-3

runs <- map2_dbl(.x = c(1, innings[-9]), .y = innings, ~sum(batting_until_game[.x:.y])-3)
sum(runs[runs>0])

game_won <- function(){
  most_bb_and_h <- 72
  the_uniform <- runif(most_bb_and_h)
  the_OBPs <- rep(PadresBatting$OBP, most_bb_and_h/9)
  the_probs <- data.frame(First = rep(PadresBatting$First, most_bb_and_h/9),
                          Second = rep(PadresBatting$Second, most_bb_and_h/9),
                          Third = rep(PadresBatting$Third, most_bb_and_h/9),
                          Home = rep(PadresBatting$Home, most_bb_and_h/9))
  
  the_bases <- map_int(1:most_bb_and_h, ~sample(1:4, 1, replace = TRUE, prob = the_probs[.x,]))
  out_or_base <- (the_uniform<the_OBPs)*the_bases
  
  outs27 <- which(cumsum(out_or_base==0) == 27)[1]
  batting_until_game <- out_or_base[1:outs27]
  
  innings <- map_int(seq(3, 27, by = 3), ~which(cumsum(batting_until_game==0) == .x)[1])
  runs <- map2_dbl(.x = c(1, innings[-9]), .y = innings, ~sum(batting_until_game[.x:.y])-3)
  runs_per_game <- sum(runs[runs>0])
  total_runs <- NA
  total_runs[runs_per_game < 5] <- 0
  total_runs[runs_per_game > 5] <- 1
  total_runs[runs_per_game == 5] <- rbinom(1,1,.13)
  return(total_runs)
}
game_won()

# hist(map_dbl(1:1000, ~game_won()))
# 
test <- map_dbl(1:1000, ~game_won())
# 
# sum(test>=5)
 summary(test)

season2 <- function(){
  sum(map_dbl(1:162, ~game_won()))
}
fn1 <- function(){map_dbl(1:250, ~season())}
fn2 <- function(){map_dbl(1:250, ~season2())}

timings <- bench::mark(
  fn1,
  fn2,
  check = FALSE,
  filter_gc = FALSE
  )
  
timings
plot(timings)

# Looking athe the timings and the plot, it does seem that the new way of calculating seasons is faster
# I'm going to commit and push to github, then reorganize with the new funcitons
