# ============================================================
# Mock NBA Draft — Getting to Know Your Data
# Sports Analytics Camp | Basketball Day
# ============================================================
# Leader notes: ~15 min, run BEFORE the draft begins.
# Goal: get comfortable navigating the dataset so the draft
# itself moves quickly. All base R, no packages needed.
#
# Reminder: Team salary cap for the draft = $110,000,000
#           10 roster spots, 2 per position
# ============================================================


# ---- 1. Load the data --------------------------------------

# NOTE: if the first column name looks weird (like "ï..ID"),
# re-read using fileEncoding = "UTF-8-BOM"
data <- read.csv("draft_data.csv", fileEncoding = "UTF-8-BOM")


# ---- 2. First look at the data ------------------------------

str(data)     # column names and types
head(data)    # first 6 rows
nrow(data)    # total number of players in the pool


# ---- 3. Positions --------------------------------------------

table(data$Pos)   # how many players at each position?

# YOUR TURN: Which position has the FEWEST players available?



# ---- 4. Salary basics ------------------------------------------

summary(data$SALARY)

hist(data$SALARY,
     main = "Player Salaries (2026)",
     xlab = "Salary ($)",
     col  = "steelblue")

# YOUR TURN: What is the salary of the single most expensive
# player in the whole pool? (hint: try the max() function)



# ---- 5. Sorting players -----------------------------------------

# Top 10 highest-paid players in the pool
top10 <- data[order(-data$SALARY), ]
head(top10, 10)

# YOUR TURN: Copy the code above and modify it to find the
# 10 CHEAPEST players instead (hint: remove the minus sign)



# ---- 6. Filtering players --------------------------------------

# Example: just the centers
centers <- data[data$Pos == "C", ]
nrow(centers)

# Example: players who cost $15,000,000 or less
affordable <- data[data$SALARY <= 15000000, ]
nrow(affordable)

# YOUR TURN: Filter for point guards (Pos == "PG") who make
# LESS than $5,000,000. How many are there?



# ---- 7. Salary by position ---------------------------------------

aggregate(SALARY ~ Pos, data = data, FUN = mean)

boxplot(SALARY ~ Pos, data = data,
        main = "Salary by Position",
        ylab = "Salary ($)",
        col  = "lightgreen")

# YOUR TURN: Which position has the highest AVERAGE salary?
# Looking at the boxplot, which position has the widest spread
# (biggest gap between cheap and expensive options)?



# ---- 8. Thinking like a GM ---------------------------------------

# Your team has a $110,000,000 cap and 10 roster spots.
# Suppose you spend big on 2 "star" players first.

star_cost   <- 28000000              # example star salary
spent       <- star_cost * 2
remaining   <- 110000000 - spent
spots_left  <- 8

remaining          # how much money is left?
remaining / spots_left   # average you'd have per remaining player

# YOUR TURN: Pick TWO real players from the dataset you'd want
# as your "stars." Add up their actual salaries, subtract from
# $110,000,000, and figure out your average budget per player
# for the remaining 8 spots.