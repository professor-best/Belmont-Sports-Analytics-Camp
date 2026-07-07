## =========================================================
## SPORTS ANALYTICS CAMP -- DAY 2
## Intro to ggplot2: Prepping for the Mock Analytics Draft
## =========================================================
##
## LEADER NOTES (delete before printing for students):
## - Total time: ~60 minutes
## - THIS SESSION NEEDS THE ggplot2 PACKAGE. Please install it on every
##   lab computer BEFORE camp starts (school wifi + package installs
##   live can eat your whole hour):
##       install.packages("ggplot2")
##   Test it ahead of time with library(ggplot2) on each machine.
## - Make sure Draft_Data_Full_Practice.csv is in the SAME FOLDER as
##   this script (Session > Set Working Directory > To Source File
##   Location in RStudio)
## - This is a BLIND draft data set -- no player names, just an ID,
##   a season of stats, and a Salary. Students are meant to judge
##   players purely on the numbers, like a real front office would.
## - Suggested pacing: Setup (5 min) | Explore & clean (10 min) |
##   Scatter plots (15 min) | Boxplot (8 min) | Bar chart (8 min) |
##   Histogram (5 min) | Draft Board Challenge (remaining time)
## =========================================================


## ---------------------------------------------------------
## PART 0: Setup
## ---------------------------------------------------------
## ggplot2 is a package for making graphs. A "package" is a toolbox
## of extra functions that isn't built into R by default -- we load
## it once per session with library().
install.packages("ggplot2")
library(ggplot2)


## ---------------------------------------------------------
## PART 1: Loading Our Data
## ---------------------------------------------------------
## This time it's basketball: one season of stats for 441 players,
## identified only by an ID number (no names!) plus their salary.

draft <- read.csv("Draft_Data_Full_Practice.csv")

head(draft)
names(draft)
dim(draft)


## ---------------------------------------------------------
## PART 2: A Couple Things Worth Noticing
## ---------------------------------------------------------
## 1) Small sample sizes lie. A player who appeared in 4 games can
##    have a wild, unreliable stat line. Let's only keep players
##    with at least 10 games played, so our graphs reflect real
##    seasons, not flukes.

draft <- draft[draft$Games >= 10, ]
dim(draft)   # should drop from 441 rows to 401

## 2) Look closely at the PPG column and compare it to Games:

head(draft[, c("ID", "Games", "PPG")])

## Despite the name, PPG here is actually TOTAL points scored for the
## whole season -- not "points per game" like it sounds! Compare it to
## columns like ASTPG or REBPG, which really ARE already per-game.
## Let's build the real thing ourselves, the same way we built ISO
## yesterday:

# Put your code here! Finish the line

draft$PTSPG <- draft$PPG / draft$Games

head(draft[, c("ID", "Games", "PPG", "PTSPG")])

## We'll also make Salary easier to read by converting it to millions:

draft$SalaryM <- draft$Salary / 1000000

summary(draft$PTSPG)
summary(draft$SalaryM)


## ---------------------------------------------------------
## PART 3: Your First ggplot -- A Scatter Plot
## ---------------------------------------------------------
## Every ggplot has the same 2 ingredients:
##   1. ggplot(data, aes(x = ..., y = ...))   -- what data, what goes
##      on which axis ("aes" = aesthetics)
##   2. + geom_point()                         -- HOW to draw it
##      (a "geom" = geometry = the shape on screen)

ggplot(draft, aes(x = PTSPG, y = SalaryM)) +
  geom_point()

## Does it look like scoring more points per game relates to a
## bigger salary?


## >>> YOUR TURN #1 --------------------------------------------------
## Make a scatter plot of REBPG (rebounds per game) on the x-axis
## and SalaryM on the y-axis.
##
## Hint: copy the plot above and swap PTSPG for REBPG.

# write your code here:




## ---------------------------------------------------------------------


## ---------------------------------------------------------
## PART 4: Adding Color and Labels
## ---------------------------------------------------------
## We can color every point by position just by adding one more
## aesthetic. ggplot automatically builds the legend for us.

ggplot(draft, aes(x = PTSPG, y = SalaryM, color = Pos)) +
  geom_point() +
  labs(title = "Points Per Game vs Salary",
       x = "Points Per Game",
       y = "Salary ($ Millions)")


## >>> YOUR TURN #2 --------------------------------------------------
## Take your REBPG plot from Your Turn #1 and:
##   1. Color the points by Pos
##   2. Add a title and axis labels with labs()
##
## Hint: copy the pattern above.

# write your code here:




## ---------------------------------------------------------------------


## ---------------------------------------------------------
## PART 5: Boxplot -- Comparing Groups
## ---------------------------------------------------------
## A boxplot is great for comparing a number (y) across categories
## (x) -- like comparing scoring by position.

ggplot(draft, aes(x = Pos, y = PTSPG)) +
  geom_boxplot()

## The thick line in each box is the MEDIAN. The box itself covers
## the middle 50% of players at that position. Dots above the
## whiskers are outliers -- unusually high scorers for that spot.


## >>> YOUR TURN #3 --------------------------------------------------
## Make a boxplot comparing SalaryM across positions (Pos).
## Which position has the highest median salary? The widest range?
##
## Hint: same pattern, just swap the y variable.

# write your code here:




## ---------------------------------------------------------------------


## ---------------------------------------------------------
## PART 6: Bar Chart -- Comparing Averages
## ---------------------------------------------------------
## Bar charts need one number per category. First we calculate the
## average PTSPG for each position using aggregate() (a base R
## function -- no package needed), THEN we hand that small summary
## table to ggplot.

pos_avg <- aggregate(PTSPG ~ Pos, data = draft, FUN = mean)
pos_avg     # take a look -- just 5 rows, one per position

ggplot(pos_avg, aes(x = Pos, y = PTSPG)) +
  geom_col() +
  labs(title = "Average Points Per Game by Position",
       x = "Position", y = "Average PTS/G")


## >>> YOUR TURN #4 --------------------------------------------------
## 1. Use aggregate() to find the average SalaryM for each position
##    (follow the pos_avg pattern above, but average SalaryM instead
##    of PTSPG)
## 2. Turn that into a bar chart with geom_col()
##
## Hint: aggregate(SalaryM ~ Pos, data = draft, FUN = mean)

# write your code here:




## ---------------------------------------------------------------------


## ---------------------------------------------------------
## PART 7: Histogram -- Seeing a Distribution
## ---------------------------------------------------------
## A histogram shows how one variable is spread out, by grouping
## values into "bins" and counting how many players fall in each.

ggplot(draft, aes(x = SalaryM)) +
  geom_histogram(binwidth = 2, color = "white")

## binwidth controls how wide each bar is (here, $2 million per bar).
## Try changing it to 1 or 5 and see how the shape changes!


## >>> YOUR TURN #5 --------------------------------------------------
## Make a histogram of PTSPG. Try a couple of different binwidth
## values (try 1, then try 5) and see which tells the story best.

# write your code here:




## ---------------------------------------------------------------------


## ---------------------------------------------------------
## BONUS / DRAFT BOARD CHALLENGE -- if you finish early
## ---------------------------------------------------------
## You're on the clock! Using only the stats (remember -- no names,
## no bias, just numbers), build ONE graph that would help you decide
## who to draft.
##
## Ideas to try:
##   - Compare VORP (Value Over Replacement Player) to SalaryM to
##     spot undervalued players
##   - Facet your scatter plot into one mini-graph per position:
##       + facet_wrap(~ Pos)
##   - Add a trend line to a scatter plot:
##       + geom_smooth(method = "lm")
##
## Example combining a few of these ideas:

ggplot(draft, aes(x = VORP, y = SalaryM, color = Pos)) +
  geom_point() +
  facet_wrap(~ Pos) +
  labs(title = "Value Over Replacement vs Salary, by Position")

## write your own version below, then answer:
## Based on your graph, which player (by ID) looks like the best
## value pick? Which looks overpaid?

# write your code here:



