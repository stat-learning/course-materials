
## Lab 3: Regression Competition

### In the hot New Jersey night

Your objective is to build a multiple regression model that predicts the
amount of violent crime in a community as a function of other
characteristics of those communities. You will construct your model
using a training data set with information on over 100 variables
recorded for 1000 communities. I’ve held back the data on 200
communities; this will server as the test data set for assessing the
predictive accuracy of your model. Your model will be due by noon on
Friday.

The main components of this lab are two R functions, described below,
but consider and record the following as you go through the model
building process.

-----

#### 1\. Understanding the data provenance

A codebook for the data can be found
[here](http://andrewpbray.github.io/data/crime-codebook.txt). Read
through that and jot down any predictors that you expect to have a
strong association with violent crime - these will serve as a good
jumping off point. You’ll notice there are some variables that have lots
of missing data. I recommend that you don’t include these in your model.

#### 2\. Exploratory data analysis

This data set is far too large to make a full pairs plot, so start off
looking at the pairwise relationships between the response and the
predictors you expect will be useful. Do these relationships look
strong/weak? Linear/non-linear? Does it seem like a transformation would
be useful? To read in the data, you can use

``` r
d <- read.csv("http://andrewpbray.github.io/data/crime-train.csv")
```

#### 3\. Model building

Start building a series of models of varying complexity. Things to
consider include transformations, polynomials, and interaction terms.
You can compare predictive power of candidate models using several tools
including statistics that penalize for complexity (\(R^2_{adj}\) and
RSE) as well as the F-test (discussed in Ch. 3 of the book). Also, if
there is multicollinearity between your predictors, that’s a sign that
some of them can be removed.

#### 4\. Model diagnostics

If you’re relying on p-values to decide which variables to include in
your model, you’ll want to verify that they’re accurate. Bring up
residual plots for your models to assess the validity of your model
(normal residuals with constant variance, linear trend).

-----

### R Functions

#### 1\. Fitting the model

Please write a function that takes the training data as input and then
outputs an `lm` object. It should be of the form,

``` r
group_A_fit <- function(training_data) {
  # this function should be self-contained, so include 
  # any packages you need and any data processing that 
  # you do.
  
  # run lm() to fit your model.
  
  # on the last line, simply put m1, your final model.
  # this will return it as output.
}
```

#### 2\. Computing MSE

Please write a function that takes as input the output from
`group_A_fit` and a data set, and returns the MSE. (hint: there is a
`predict()` function that may be helpful.)

``` r
group_A_MSE <- function(model, data) {
  # when you run group_A_fit, save the output and put 
  # it here as the "model" argument.
  
  # use your model to find the predicted values for 
  # all of the observations in the data set.
  
  # use those fitted values and the true values to
  # compute the MSE, which this function should return
  # as output.
}
```

When you turn in this lab, you should be running `group_A_MSE` on the
training data to get training MSE. I’ll be changing out the data set
when I run this function to find your groups’ test MSE.
