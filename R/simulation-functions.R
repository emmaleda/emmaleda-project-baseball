
#' Did They Win the Game?
#'
#' @param data dataframe with 9 rows; Must have columns named "OBP", "First", "Second", "Third" and "Home" in which the values are probabilites;
#'             the probabilities provided in "First", "Second", "Third" and "Home" should add to 1 for each player
#'
#' @return The value is a double, either zero or one, in which zero indicates they lost and one indicates they won
#' @export
#'
#' @examples game_won(data.frame(OBP = c(0.354, 0.289, 0.334, 0.310, 0.304, 0.321, 0.283, 0.321, 0.235),
#'                               First = c(0.7416, 0.6241, 0.7442, 0.7402, 0.7405, 0.7355, 0.7098, 0.7951, 0.8465),
#'                               Second = c(0.1005, 0.1348, 0.0977, 0.1422, 0.1450, 0.1419, 0.0933, 0.1220, 0.1080),
#'                               Third = c(0.0335, 0.0071, 0.0093, 0.0098, 0.0229, 0.0065, 0.0000, 0.0195, 0.0000),
#'                               Home = c(0.1244, 0.2340, 0.1488, 0.1078, 0.0916, 0.1161, 0.1969, 0.0634, 0.0455)))
game_won <- function(data){
  # from stackoverflow:
  # https://stackoverflow.com/questions/10276092/to-find-whether-a-column-exists-in-data-frame-or-not
  
  ## 
  ## First, check that the data provided by the function user fits the correct qualifications:
  ## it must have columns named OBP, First, Second, Third and Home, all of which must contain
  ## values between 0 and 1 (since all values are probabilities)
  ##
  if(!"OBP" %in% colnames(data)) stop("Must have a column named 'OBP' with the on-base percentage for each player in the batting line up")
  if(!all(data$OBP <= 1, data$OBP >= 0)) stop("Values of 'OBP' column must be between 0 and 1")
  
  if(!"First" %in% colnames(data)) stop("Must have a column named 'First' with the probabilites that each player in the batting line up makes it to first base")
  if(!all(data$First <= 1, data$First >= 0)) stop("Values of 'First' column must be between 0 and 1")
  
  if(!"Second" %in% colnames(data)) stop("Must have a column named 'Second' with the probabilites that each player in the batting line up makes it to second base")
  if(!all(data$Second <= 1, data$Second >= 0)) stop("Values of 'Second' column must be between 0 and 1")
  
  if(!"Third" %in% colnames(data)) stop("Must have a column named 'Third' with the probabilites that each player in the batting line up makes it to third base")
  if(!all(data$Third <= 1, data$Third >= 0)) stop("Values of 'Third' column must be between 0 and 1")
  
  if(!"Home" %in% colnames(data)) stop("Must have a column named 'Home' with the probabilites that each player in the batting line up makes it home")
  if(!all(data$Home <= 1, data$Home >= 0)) stop("Values of 'Home' column must be between 0 and 1")
  
  if(length(data$OBP)!=9) stop("Baseball lineups have 9 players; length should be equal to 9")
  
  
  ##
  ## combining the most hits ever achieved with the most walks ever achieved gives us 
  ## 72, the maximum number of hits a team will get in one game
  ##
  most_bb_and_h <- 72
  the_uniform <- runif(most_bb_and_h)
  
  ##
  ## Repeat OBP & probs so the length is equal to 72
  ##
  the_OBPs <- rep(data$OBP, most_bb_and_h/9)
  the_probs <- data.frame(First = rep(data$First, most_bb_and_h/9),
                          Second = rep(data$Second, most_bb_and_h/9),
                          Third = rep(data$Third, most_bb_and_h/9),
                          Home = rep(data$Home, most_bb_and_h/9))
  
  ##
  ## Generate the base each player in the iteration got to, even if they got an out instead of a hit
  ##
  the_bases <- map_int(1:most_bb_and_h, ~sample(1:4, 1, replace = TRUE, prob = the_probs[.x,]))
  ##
  
  ## 
  ## multiply the logical - if the player got a hit - by the base they got to so we end up with
  ## 0's if they were out and the base they made it to if not
  ##
  out_or_base <- (the_uniform<the_OBPs)*the_bases
  
  ##
  ## subset our data so that we truncate once we get to 27 outs, since we have 3 outs per inning
  ## and 9 innings - 27 outs will end the game
  ##
  outs27 <- which(cumsum(out_or_base==0) == 27)[1]
  batting_until_game <- out_or_base[1:outs27]
  
  ##
  ## separate the data into innings - every 3 0's is an inning
  ##
  innings <- map_int(seq(3, 27, by = 3), ~which(cumsum(batting_until_game==0) == .x)[1])
  
  ##
  ## sum up the hits per inning and subtract 3 to get runs scored per innings 
  ##
  runs <- map2_dbl(.x = c(1, innings[-9]), .y = innings, ~sum(batting_until_game[.x:.y])-3)
  
  ##
  ## the way we set this up, we get negative values for runs, so we subset runs by runs that 
  ## are greater than zero, then add them up to get total runs per game
  ##
  runs_per_game <- sum(runs[runs>0])
  
  ##
  ## finally, we calculate if they won based on the average number of runs they let be scored
  ## against them in 2019, so if they scored more runs than that, they won, if they scored less,
  ## they lost and if they scored exactly 5 runs, we randomly choose based on the average they let 
  ## though (since it was 4.87, 13% of the time they win)
  ##
  total_runs <- NA
  total_runs[runs_per_game < 5] <- 0
  total_runs[runs_per_game > 5] <- 1
  total_runs[runs_per_game == 5] <- rbinom(1,1,.13)
  ####
  #### sidenote: we've created this function as if it could be generic to any baseball team, provided 
  ####           the user supplies the correct information, however, the way total_runs is set up is specific
  ####           to the Padres since them allowing 4.87 runs on average to be scored per game is a stat that 
  ####           only applies to them
  ####
  
  return(total_runs)
}

##
## to calculate a season, we run game_won 162 times since there are 162 games in a season
##
#' How Many Games Did They Win in a Season?
#'
#' @param data dataframe with 9 rows; Must have columns named "OBP", "First", "Second", "Third" and "Home" in which the values are probabilites;
#'             the probabilities provided in "First", "Second", "Third" and "Home" should add to 1 for each player
#'
#' @return The value returned is a numeric, indicating how many games they won out of 162 in a season
#' @export
#'
#' @examples   season(data.frame(OBP = c(0.354, 0.289, 0.334, 0.310, 0.304, 0.321, 0.283, 0.321, 0.235),
#'                               First = c(0.7416, 0.6241, 0.7442, 0.7402, 0.7405, 0.7355, 0.7098, 0.7951, 0.8465),
#'                               Second = c(0.1005, 0.1348, 0.0977, 0.1422, 0.1450, 0.1419, 0.0933, 0.1220, 0.1080),
#'                               Third = c(0.0335, 0.0071, 0.0093, 0.0098, 0.0229, 0.0065, 0.0000, 0.0195, 0.0000),
#'                               Home = c(0.1244, 0.2340, 0.1488, 0.1078, 0.0916, 0.1161, 0.1969, 0.0634, 0.0455)))
season <- function(data){
  sum(map_dbl(1:162, ~game_won(data)))
}
