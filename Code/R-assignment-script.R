# Author     : Ryan Peterson
# Last Modified   : 08/31/2020
# Description: BIOS 6621 R introduction

##### OUTLINE #####

# Part 1: Intro to the R language (Basics)
  # Basic Arithmetic
  # Sequences
  # Storing scalars and vectors
  # Common Functions
  # Indexing
  # The ? function
  # Reading in data, attaching

# Part 2: Types of objects in R

# Part 3: Simple tables and graphs in R
  # Tables and bar charts
  # Contingency tables and stratified bar charts
  # Continuous Data in R 
    # Histograms
    # One-Way Scatter plots
    # Box plots 
    # Two-Way Scatter plots
    # Measures of center and spread

# Part 4: Exercises

###

###### PART 1: Basics ######

### Basic Arithmetic, using R as a calculator ###
4 + 5 - 24/6
(6-4)*3

5^2
5**2

### Sequences ###
1:8 # This notation provides all integers between 1 and 8

# this seq() function provides a sequence from 1 to 10 by 2
seq(1,10,2) 

###  Repeating ###

# General:  rep( x, times= , each= )
# Repeat each element using argument 'each'
# Repeat whole result using argument 'times'

rep( 10, times=5 )            # c(10,10,10,10,10)
rep( c(1,3,5), times=2 )      # c(1,3,5,1,3,5)
rep( c(1,3,5), each=2 )       # c(1,1,3,3,5,5)

### Storing scalars and vectors ###

x <- 1:9  # stores a vector
x         # prints out that vector
x <- 6    # stores a scalar
x         # prints out that scalar
x + 10    # arithmetics can be performed on stored values

x <- x + 10 
x

### Common functions ###
x <- 1:9

mean(x) # Calculates the mean of what you stored in x
mean(1:9)
sd(x) # Calculates the standard deviation

sum(x)
min(x)
max(x)

#this is the max of the vector x
max_x <- max(x)
max_x
avg <- mean(x)

# c() is a function that tells R to store a vector
x <- c(2,3,5)  
x

### Indexing ###
# Say we want to extract the 2nd value in x. We use x[2]
b <- x[2] 
b

### The ? funtion ###
# If you are unsure of a function or how to use it, use ?
# Help documentation will appear on the right
?max
?seq
seq(to = 10,from = 1, by = 2)
seq(10,1,2) # this will yield an error

# More examples
seq( from=4, to=8, by=1 )     # c(4,5,6,7,8)   or ...
seq( 4, 8, by=1 )             # same
4:8                           # same, shorthand
seq( 0, 1, by=0.1 )           # c(0, 0.1, 0.2, ..., 0.9, 1.0)

### Reading in data ###
# The following code will open up a file browser
# Download, then read in the "week01-assignment-data-titanic.csv" data set on Canvas
mydata <- read.csv(file=file.choose()) 

# The head() function shows the first 6 observations
# of each variable, along with variable names
head(mydata) 

# Each observation is one person who was on the Titanic
# how many people were on the Titanic?

dim(mydata) # this gives you the dimensions of the data set
# Now I know there were 2201 people on the Titanic (how?)

# To work with the variables in mydata, use the $ operator
head(mydata$Class)

##### PART 2: Types of objects, data management ##### 

### There are many kinds of objects in R.  Some of the most common are
#   vector
#   matrix
#   data frame (matrix where columns may be of different types (eg numeric or character)
#   list (set of common objects bound together with one name)

### Vectors

x <- c(1,3,4,6,9,10,11,14)                 # numeric vectors
y1 <- c(102,101,89,92,81,80,75,72)
y2 <- c(88,85,81,80,76,71,66,64)
lab <- c("a","b","c","d","e","f","g","h")  # character vector

# Sub-vectors
x[c(1,3,7)]         # selects elements 1, 3, and 7 of x
x[c(3:5)]           # selects elements 3,4,5 of x
x[3:5]              # same
x[-4]               # x omitting element 4
x[-c(2,4,6)]        # x omitting elements 2,4,6

# Note that there is no <- in these, so the object is created and printed but not stored

# Vectors can be added, multiplied, logged, etc -- check the result on a small example
2*x
log(x)
x+y1
x*y1

# Concatenating vectors
c(x,y1,y2)
c(x, lab)           # note vectors are different types

### Matrices

### First dimension is row (horizontal), 2nd dimension is column (vertical)

xy.mat <- cbind(x, y1, y2)               # cbind puts columns together
xy.long <- rbind(x, y1, y2)              # rbind stacks rows together
na.mat <- matrix( NA, ncol=4, nrow=2 )   # useful to create a blank matrix to fill in later

# Warnings will generally be given when dimensions don't match
cbind(x, c(1:5))
# But maybe not ...  check, check, and check again (same in SAS)
cbind(x, c(1:4))

# Sub-matrices are selected the same way as sub-vectors,
#   using the methods above on each dimension
#   leaving a dimension blank means use all elements
xy.mat[2:4, ]         # rows 2, 3, 4, all columns
xy.mat[, -2]          # omit column 2
xy.mat[2:4, -2]
xy.mat[c(1,3,7),]

# Subsets can be formed from conditions
x[x > 10]
y1[x > 10]
xy.mat[x>10, ]
xy.mat[ x <= 10 & x > 4, ]

# Dimensions can be gotten using
length(x)
dim( xy.mat )


##### PART 3: Tables + Plots #####

### Tables and bar plots ###

# the table() function is straightforward
table(mydata$Class)
table(mydata$Sex)
table(mydata$Age)
table(mydata$Survived)

# R allows you to store these tables
tab1 <- table(mydata$Class)
tab1

# once you have a table...
# you can get the relative frequencies with prop.table()
prop.table(tab1)

# and you can create a bar chart with barplot()
barplot(tab1)

# how can we make this plot better?
?barplot
# notice that the "main" argument refers to an overall title for the plot
barplot(tab1, main = "Classes on the Titanic")

# let's add on a y-axis label
barplot(tab1, main = "Classes on the Titanic", ylab = "# of people")

# We can do relative frequencies as well
barplot(prop.table(tab1), main = "Classes on Titanic", 
        ylab = "Relative frequency")

### Contingency tables and stratified bar charts ###

# the table() function also works for multiple variables
tab2 <- table(mydata$Sex,mydata$Survived) 
tab2 # This is a contingency table

# barplot() works on these as well, but not perfectly
barplot(tab2)

# We'd prefer gender on the x axis, so let's flip our table
tab3 <- table(mydata$Survived, mydata$Sex)
barplot(tab3)

# we still need to add a title 
# and, more importantly, a legend
barplot(tab3, main = "Male and Female survival on Titanic", 
        legend.text = TRUE, args.legend = list(x = "topleft"))

### Continuous Data in R ###

# The disease-free survival example
# Note: for the “disease-free survival” example:
#   This is a sample of 25 cancer patients
#   The DFS time of a treated cancer patient is defined as the length of 
#   elapsed time between the time at which the patient goes into remission 
#   and the time at which the patient relapses.

dfsdata <- c(1, 2, 3, 5, 7, 8, 8, 9, 10, 
             10, 11, 11, 12, 12, 13, 14, 
             15, 17, 18, 19, 21, 22, 34, 
             35, 39)
hist(dfsdata) # absolute frequency histogram is default
hist(dfsdata, freq = F) # density histogram

# let's make it look a bit nicer
hist(dfsdata, main = "Histogram of DFS Data", 
     xlab = "Disease-free survival (months)")

# Feel free to play around with other graphical parameters
hist(dfsdata, main = "Histogram of DFS Data", 
     xlab = "Disease-free survival (months)",
     col = "grey", border = "white")

## One-Way Scatter plot ##

# You can create a scatter plot with plot()
plot(dfsdata) # the default x-axis is just an index
plot(dfsdata, pch = 16, col = "blue")
# For more pch options, check out the link below
# http://www.endmemo.com/program/R/pchsymbols.php 

# We can add to plots using other functions
# to add gridlines, you can use abline()
abline(h = c(10, 20, 30), lty = 3)

## Box Plot ##

example <- rnorm(100,5) # This generates random numbers around 5
example

boxplot(example)

boxplot(example, main = "Title", ylab = "Y label")
quantile(example) # returns important percentiles, 5 number summary

## Two-Way Scatter Plot ##

# This is the US execution data from class
Executions <- c(0,1,0,2,0,1,2,5,21,18,18,25,11,16,23,14,31,38,28)
Year <- 1976:1994
plot(Year, Executions, pch=19, main="Execution in the U.S. (1976-1994)", col="blue")
abline(h=10*0:3, lty=3)

# Some measures of center
mean(Executions)
median(Executions)
table(Executions) # note the mode is 0

# measures of spread
var(Executions) # Variance
sd(Executions)  # Standard Deviation

quantile(Executions)
IQR <- 22.0 - 1.5
IQR             # Interquartile range

max(Executions) - min(Executions) # range

# how many people were executed in the US from 1976 - 1994?
sum(Executions)

##### PART 4: Exercises ##### 

### Ex 1:  Add a red horizontal line at mean(Executions) and a blue 
### horizontal line at max(Executions) to the plot below
plot(Year, Executions, pch=19, main="Execution in the U.S. (1976-1994)", col="blue")
abline(h = mean(Executions), col = 'red') #My answer
abline(h = max(Executions), col = 'blue') #My answer

### Ex 2:  Color the blue points red if Year<1984, add a legend to the plot, 
###        and add a vertical line at Year 1983.5

plot(Year, Executions, pch=19, main="Execution in the U.S. (1976-1994)", col= ifelse(Year<1984,'red','blue'))
abline(h = mean(Executions), col = 'red') #My answer
abline(h = max(Executions), col = 'blue') #My answer
abline(v= 1983.5)
legend("topleft", c("Year < 1984", "Year >= 1984"), col = c("red", "blue"), pch = 19)



### Ex 3:  Use rep and seq to create c(.2,.2,.4,.4,.6,.6,.2,.2,.4,.4,.6,.6,.2,.2,.4,.4,.6.,6)

rep(seq(0.2, 0.6, by = 0.2), each = 2, times = 3)


### For many distributions there are four functions (example normal):
# rnorm            # generate pseudorandom numbers
# dnorm            # density values
# pnorm            # CDF
# qnorm            # quantiles

# Ex 4: a. Generate a sample of 10000 normal values with mean 10 and sd 4
#       b. Make a histogram of the values
#       c. Check that the empirical mean and SD match those used to generate the sample
#       d. For X~N(10, 16), find Pr(X > 18)
#       e. For X~N(10, 16), find the value so that 97.5% of the distribution is less than that value
#       f. Make a smooth line graph of the N(10, 16) density.  Don't superimpose on the histogram.
#          (Hint: Use seq)

# a. 
sample <- rnorm(10000, mean = 10, sd = 4)
sample

# b. 
hist(sample, main = "Histogram of Pseudorandom Sample Data", xlab = "Values")

# c. 
mean(sample) # 10.03388
sd(sample)   # 4.014537

# d. 
pnorm(q = 18, mean = 10, sd = 4, lower.tail = FALSE)

# e. 
qnorm(p = 0.975, mean = 10, sd = 4)

# f. 
#mean=10,sd=4
x_vals <- seq(10 - 4*4, 10 + 4*4, length.out = 100)
y_vals <- dnorm(x_vals, mean = 10, sd = 4)
plot(x_vals, y_vals, type = "l", main = "N(10, 16) Density Curve", 
     xlab = "X Values", ylab = "Density")

# Ex 5: Generate a sample of 10000 values from a Gamma distribution with mean 10 and sd 4
#       Verify empirically that your sample mean and sd are close to 10 and 4
#       This is very useful, when working with a new distn in R (or SAS or ...) it's good to do this

# For a Gamma distribution with Shape (alpha) and Scale (beta):
#   Mean     = alpha * beta
#   Variance = alpha * beta^2

#   beta = variance / mean = 16/10 = 1.6
#   alpha = Mean/ Beta = 10/1.6 = 6.25

sample_gamma <- rgamma(10000, shape = 6.25, scale = 1.6)

# Verify empirical mean and standard deviation
mean(sample_gamma)   # 10.02204
sd(sample_gamma)     # 3.99518

# Ex 6: Explain (1 sentence each) what each of these statements does

x[c(3:7)-2]      #This will extract the 1st through 5th elements of vector x (since c(3:7) - 2 evaluates to 1:5)
x[c(3:7)]-2      #This extracts elements 3 through 7 from vector x and subtracts 2 from each of those values.
xy.mat[14, ]     #This would select the 14th row of xy.mat along with all the columns for that row. 
xy.mat[c(2:4)]   #This extracts the 2nd, 3rd, and 4th entries of Column 1 (x).
cbind(x, lab)    #Binds vector x and character vector lab side-by-side as columns.

# Ex 7: Using the object xy.mat and not making any new assignments (don't use <-),
#       graph y2 versus x, omitting the 4th row, and with axis labels "y2" and "x"

plot(xy.mat[-4, "x"], xy.mat[-4, "y2"], xlab = "x", ylab = "y2")



