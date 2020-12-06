Creating the Padres 2019 Batting Dataset
================
Leah Marcus
12/6/2020

`  ` The dataset that was used to create the hits and runs functions of
our Simulation of the San Diego Padres 2019 Baseball Season was taken
from [Baseball
Reference](https://www.baseball-reference.com/teams/SDP/2019.shtml)

`  ` The lineup was constructed to be as close to an average 2019 Padres
lineup as possible. Players that played at least 140 out of 162 games
were taken as being everyday players, so they were placed in the
nine-player lineup based on where they usually hit in the lineup after
looking at random lineups played by the Padres in 2019, which was found
from [MLB At Bat](https://www.mlb.com/padres/scores/2019-08-07) These
players were: Hunter Renfroe (2nd in the lineup, played 140 games),
Manny Machado (3rd in the lineup, played 156 games), Eric Hosmer (4th in
the lineup, played 160 games), Manuel Margot (5th in the lineup, played
151 games), Wil Myers (6th in the lineup, played 155 games)

`  ` Where constructing the lineup became more complicated was with
players who played in a fair number of games but were in a platoon
situation, were defensive replacements late in games, were pinch
hitters, or were injury replacement. This required more judgement to
combine and average players into the lineup that would represent a
typical Padres lineup in 2019. The final combinations were: Fernando
Tatis Jr./Luis Urias (1st in the lineup, played 84 and 71 games,
respectively; Urias was the primary replacement for Tatis Jr. after his
injury), Austin Hedges/Framil Reyes (7th in the lineup, played 102 and
99 games, respectively), Ian Kinsler/Greg Garcia (8th in the lineup,
played 87 and 134 games, respectively; Garcia was often a defensive
replacement for Kinsler and they had a similar number of actual at bats)

`  ` Finally, it is worth noting that because the Padres play in the
National League, their pitchers hit unless they are removed from the
game. So, to fill out lineup spot, the starting pitchers were averaged
(Joey Lucchesi, Eric Lauer, Chris Paddack, Cal Quantrill, and Matt
Strahm). Then that average was averaged with Josh Naylor who played the
most games (94) of a player who had not been included in the dataset.

`  ` The player’s on base percentage (OBP, chance of not making an out)
was included either as the player’s raw value (everyday players) or an
average of the player’s combined OBP. From there, the players’ chance of
making it to first base (singles and walks), second base (doubles),
third base (triples), and home to score a run (home runs), were taken as
the proportion of the time they achieved those outcome(s) over their
total number of hits plus walks (averaged over the totals for the
combination players).
