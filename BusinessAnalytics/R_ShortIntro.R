# BUAN 6356: Week 1 (A short intro to using R)
# Last Updated: January 13, 2020

#par(ask = FALSE)

# A few basic manipulations with R

5^2 + 11

4*2


# Generate a random sample
rnorm(15)
rnorm(20, mean=1, sd =3)


# Data Types - Scalars, Vectors, Matrices, Data Frames, Factors

  ## 1. Scalars
anything <-  4
anything

  ## 2. Vectors
a <- c(1,4,6,8,10) # numeric vector
b <- c("one","two","three") # character vector
c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE) # logical vector

a
a[5]
a[c(3:5)]
sum(a)

  ## 3. Matrices
y <- matrix(1:20, nrow = 5, ncol=4)
mean(y)
y
y[1:2, 3:4]


  ## 4. Data Frames
d <- c(1,2,3,4)
e <- c("red", "white", "red", NA)
f <- c(TRUE,TRUE,TRUE,FALSE)
g <- c(10, 25, 36, 72)
mydata <- data.frame(d,e,f,g)

names(mydata) <- c("ID","Color","Passed","Age") # variable names
mydata

  ## Access information in a data frame
    ### Retrieve columns by column numbers
mydata[,2:3]

    ###  Retrieve columns by columns names
mydata[,c("ID","Age")]    
mydata$Age 

  ## 5. Factors (strings, character variables) for nominal values
gender <- c(rep("female", 10), rep("male", 15))
gender
gender1 <- factor(gender)
gender1


# save objects to file

save(mydata, file="myfile.RData")


# Graphs
  
  ## 1. Basic graphs
library(stats)
?mtcars
plot(mtcars$mpg,mtcars$cyl, col='red')

  ## 2. Histogram  
hist(rnorm(1000), breaks=10, col="orange", border = FALSE)

  ## 3. Bar plot
count <- table(mtcars$gear)
barplot(count, col = "orangered", horiz = TRUE, border = FALSE, space = 2)

  ## 4. Box plot
boxplot(mpg~gear, data=mtcars, col = "gold1",
        xlab = "# of gears", ylab = "mileage")

  ## Save graphs (.pdf / png / jpeg / ps / ...)
pdf("mygraph.pdf")
dev.off()
?mtcars


# R packages

  ## 1. install packages
#install.packages("ggplot2")

  ## 2. load packages
library("ggplot2")

  ## 3. Which packages are loaded?
search()

  ## 4. delete packages
#remove.packages("ggplot2")



# Remove all objects from R's memory
rm(list=ls())



# Getting help

  ## Help for a function
help(plot)
?plot 
#example(plot)

  ## Search for Demos
#demo(package = "stats")
#demo("nlm")

  ## Conceptual search
help.search("linear models")





# A few useful commands

length(mtcars) 		# number of elements or components
str(mtcars)    		# structure of an object
class(mtcars)  		# class or type of an object
names(mtcars)  		# names
ls()       			  # list current objects






