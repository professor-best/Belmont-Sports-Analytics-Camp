## =========================================================
## SPORTS ANALYTICS CAMP -- DAY 1, AFTERNOON SESSION
## Intro to R: Team Baseball Statistics
## =========================================================

## ---------------------------------------------------------
## PART 0: The Basics
## ---------------------------------------------------------
## Anything after a # is a "comment" -- R ignores it. Comments are
## just notes for humans.
##
## The <- arrow is how we save something into a name. Think of it as
## "put this into a box labeled ___".
##
## Try running the two lines below one at a time (cursor on the line,
## then Ctrl+Enter or Cmd+Enter):

my_name <- "Type your name here"
print(my_name)


## ---------------------------------------------------------
## PART 1: Loading Our Data
## ---------------------------------------------------------
## We're going to load a spreadsheet (.csv file) with every MLB
## team's hitting stats from this season.

baseball <- read.csv("mlb-player-data-7.04.26.csv")

## Now let's look at what we just loaded:

head(baseball)      # first 6 rows
names(baseball)     # every column name
dim(baseball)       # (number of rows, number of columns)

## ---------------------------------------------------------
## PART 2: Pulling Out a Column
## ---------------------------------------------------------
## The $ sign grabs one column out of our data.

baseball$HR      # home runs, every team
baseball$Tm      # team names

## Once we have a column, we can do math on it:

mean(baseball$HR)    # average HR across all 30 teams
max(baseball$HR)     # most HR by any one team
min(baseball$HR)     # fewest HR by any one team
sum(baseball$HR)     # total HR hit across all of MLB


## >>> YOUR TURN #1 --------------------------------------------------
## 1. Find the average batting average (BA) across all teams
## 2. Find the most stolen bases (SB) by any one team
## 3. Find the total strikeouts (SO) across all of MLB
##
## Hint: same functions as above, just swap the column name.

# write your code here:




## ---------------------------------------------------------------------


## ---------------------------------------------------------
## PART 3: Finding One Team
## ---------------------------------------------------------
## What if we only want the Yankees? We put a TRUE/FALSE test inside
## square brackets [ ]. Note it's TWO equal signs (==) -- that means
## "is equal to?" -- one equal sign (=) means something different!

baseball[baseball$Tm == "New York Yankees", ]

## We can combine this with $ to grab just one stat for that team:

baseball$HR[baseball$Tm == "New York Yankees"]


## >>> YOUR TURN #2 --------------------------------------------------
## 1. Pull up ALL the stats for your favorite team
## 2. Find just the batting average (BA) for the Los Angeles Dodgers
## 3. Find just the home runs (HR) for the Atlanta Braves
##
## Hint: copy the pattern above and change the team name and stat.

# write your code here:




## ---------------------------------------------------------------------


## ---------------------------------------------------------
## PART 4: Who's the Best? Sorting Teams
## ---------------------------------------------------------
## order() sorts a column from smallest to largest, and gives us back
## the row order to use.

# fewest to most home runs:
baseball[order(baseball$HR), c("Tm", "HR")]

# most to fewest (a minus sign flips the order):
baseball[order(-baseball$HR), c("Tm", "HR")]


## >>> YOUR TURN #3 --------------------------------------------------
## 1. Which team has the HIGHEST batting average (BA)? Sort teams
##    from highest to lowest BA to find out.
## 2. Which team strikes out (SO) the most? Which strikes out the
##    least?
##
## Hint: copy the pattern above and change the column name.

# write your code here:




## ---------------------------------------------------------------------


## ---------------------------------------------------------
## PART 5: Making a New Stat (Challenge!)
## ---------------------------------------------------------
## Sabermetrics is all about building NEW stats out of existing ones.
## Let's make Isolated Power (ISO) = SLG - BA. It measures raw power,
## separate from batting average.

baseball$ISO <- baseball$SLG - baseball$BA

# see it sorted from most to least power:
baseball[order(-baseball$ISO), c("Tm", "ISO")]


## >>> YOUR TURN #4 (Challenge!) --------------------------------------
## Create a new stat called BB_K = walks (BB) divided by strikeouts (SO).
## This shows how "disciplined" a team's hitters are -- higher means
## more walks per strikeout, i.e. more patient hitters.
##
## Then find out which team has the HIGHEST BB_K.
##
## Hint: follow the ISO pattern above, but use / instead of -.

# write your code here:




## ---------------------------------------------------------------------

## ---------------------------------------------------------
## PART 6: Baseball's Pythagorean Thm
## ---------------------------------------------------------
## Let's pull it all together! Read in the mlb-phy and ausl-phy dataset and 
## create new columns for win % and the Pythagorean theorem.




## ---------------------------------------------------------
## BONUS -- if you finish early
## ---------------------------------------------------------
## 1. What is the league-wide average on-base percentage (OBP)?
## 2. Which team has the fewest strikeouts (SO) in all of baseball?
## 3. Add OBP + SLG together by hand -- does it match the OPS column?
## 4. Pick any two teams and compare their HR and BA side by side.
