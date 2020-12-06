Construction of the Adjusted Runs
================
Leah Marcus
12/6/2020

## Adjustments to the Simulation of the Padres 2019 Season

  Several adjustments had to be made to the simulation in order to
make it an accurate reflection of the San Diego Padres 2019 season.

  The Padres pitchers gave up a total of 789 runs during the 2019
season, for an average of 4.87 runs given up per game. However, using
this value resulted in an overestimation of the average number of wins
per season of about 15 wins – 85 wins rather than the true number of
wins of 70. This is likely due to how the lineup was constructed for our
dataset. While the goal was to make a lineup that reflects an average
2019 Padres lineup and adjustments were made based on injury and
platoons, the average lineup is still a bit of an ideal situation. There
are roughly 10 – 12 position players who were not included at all in the
simulation due to playing individually an inconsequential number of
games and having few at bats, but these players add up to be a full
player or player-and-a-half. Because they played so infrequently, it is
not a surprise that these players are worse on average than those were
included in the average lineup. Ultimately due to time constraints,
however, and the fact that they would not reflect an “average” lineup,
we decided to focus on cleaning up our code and documentation, rather
than finding a way to include these players. This likely partially
explains the overestimation of our model.

  It is also important to point out that our simulation is still an
oversimplification of how a baseball game would actually be played. We
assume that, once a player reaches whatever base of the type of hit (or
walk) they achieved, they stay there until a later player gets a
hit/walk. However, this is not a complete picture of how baseball is
actually played, and there are cases where this method of simulation
would both over- and under-estimate the number of runs scored. For an
example of each, assuming the first batter has reached first with a
single: If the next player makes an out, the first batter would remain
at first with our simulation and could score later in the inning;
however, in an actual game the second batter could have hit into a
double play, adding an out and removing both batters from the bases. If
the next player instead hits a double, the first batter would go to
third with our simulation – his original base of first plus the next two
bases. However, in an actual game, the first batter could have scored on
the double, but in our simulation, there is no guarantee that the next
batter(s) do not make outs, so he would not score.

  Finally, there is evidence that the Padres were an [especially
poor](https://www.fangraphs.com/leaders.aspx?pos=all&stats=bat&lg=all&qual=0&type=8&season=2019&month=0&season1=2019&ind=0&team=0,ts&rost=0&age=0&filter=&players=0&startdate=2019-01-01&enddate=2019-12-31&sort=17,d)
base-running team in 2019. This means that while the Padres were a
better hitting team in our simulation than their record suggests, they
consistently ran into outs on the base paths, which is something our
simulation could not account for directly but means they should score
fewer runs overall than their hitting metrics suggest and should thus
lose more games. This is good evidence that our model leads to
over-estimating with the hitting simulation than under-estimating
baserunning.

  We were able to improve the accuracy of our simulation by adding
one run to the cutoff of runs scored that the Padres must achieve to
earn a win. After considering the ways in which our simulation might not
reflect a true baseball game, this adjustment makes sense.
