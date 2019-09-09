
## Lab 1: Exploratory Data Analysis

### This Bitter Earth

(based on exercise 10 on p. 56 of the book)

To begin, load in the `Boston` data set. The `Boston` data set is part
of the `MASS` library in R.

``` r
library(MASS)
```

Now the data set is contained in the object `Boston`. Read about the
data set.

``` r
?Boston
```

1.  How many rows are in this data set? How many columns? What do the
    rows and columns represent?

2.  Make some (2-3) pairwise scatterplots of the predictors (columns) in
    this data set. Describe your findings.

3.  Are any of the predictors associated with per capita crime rate? If
    so, explain the relationship.

4.  Are there any suburbs of Boston that appear to have particularly
    high crime rates? Tax rate? Pupil-teacher ratios? Comment on the
    range of each predictor.

5.  How many of the suburbs in this data set bound the Charles river?

6.  What is the median pupil-teacher ratio among the towns in this data
    set?

7.  If you want to build a model to predict the average value of a home
    based on the other variables, what is your output/response? What is
    your input?
