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

the_uniform <- runif(81*2)
the_OBPs <- rep(PadresBatting$OBP, 18)
# the_uniform < the_OBPs
# View(cbind(the_uniform,the_OBPs, the_uniform<the_OBPs))
the_probs <- data.frame(First = rep(PadresBatting$First, 18),
                        Second = rep(PadresBatting$Second, 18),
                        Third = rep(PadresBatting$Third, 18),
                        Home = rep(PadresBatting$Home, 18))
  rep(c(PadresBatting$First, PadresBatting$Second, PadresBatting$Third,PadresBatting$Home), 18)
View(the_probs)
sample(1:4, 162, replace = TRUE, prob = the_probs)

the_bases <- map_int(1:162, ~sample(1:4, 1, replace = TRUE, prob = the_probs[.x,]))

the_necessary_info <- data.frame(on_base = the_uniform < the_OBPs,
                                 base_reached = the_bases)
the_necessary_info$on_base*the_necessary_info$base_reached

# outs = 0
# while(outs < 28){
#   
# }
