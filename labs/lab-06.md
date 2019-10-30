
## Lab 6: Hands off my stack

Our data set this week looks at the relationship between US stock
prices, the earnings of the corporations, and the returns on investment
in stocks, with returns counting both changes in stock price and
dividends paid to stock holders. A corporation’s **earnings** in a given
year is its income minus its expenses. The return on an investment over
a year is the fractional change in its value, \((v_{t+1} - v_t)/v_t\),
and the average rate of return over \(k\) years is
\([(v_{t+k} - v_t)/v_t]^{1/k}\).

To read in the data from a csv the course website, you can use:

``` r
d <- read.csv("https://bit.ly/36kibHZ")
```

The dataset contains the following variables:

  - `Date`, with fractions of a year indicating months
  - `Price` of an index of US stocks (inflation-adjusted)
  - `Earnings` per share (also inflation-adjusted);
  - `Earnings_10MA_back`, a ten-year moving average of earnings, looking
    backwards from the current date;
  - `Return_cumul`, cumulative return of investing in the stock index,
    from the beginning;
  - `Return_10_fwd`, the average rate of return over the next 10 years
    from the current date.

“Returns” will refer to `Return_10_fwd` throughout.

### 1\. Inventing a variable

1.  Add a new column, `MAPE` to the data frame, which is the ratio of
    `Price` to `Earnings_10MA_back`. Bring up the summary statistics for
    the new column using the `summary()` command. Why are there exactly
    120 NAs? For ease of computing for the rest of the lab, you may want
    to remove all rows with any missing data.
2.  Build a linear model to predict returns using `MAPE` (and nothing
    else). What is the coefficient and it’s standard error? Is it
    significant?
3.  What is the MSE of this model under five-fold CV? I recommend you go
    about this by adding a column to your data frame indicating the
    randomly assigned *fold* to which every observation belongs. Then
    use a for-loop to fit and predict across each of the five folds,
    where you can use the appropriate data by subsetting based on the
    fold.

### 2\. Inverting a variable

1.  Build a linear model to predict returns using `1/MAPE` (and nothing
    else). What is the coefficient and its standard error? Is it
    significant?
2.  What is the CV MSE of this model? How does it compare to the
    previous one?

### 3\. A simple model

A simple-minded model says that the expected returns over the next ten
years should be exactly equal to `1/MAPE`.

1.  Find the *training* MSE for this model.
2.  Explain why the training MSE is equivalent to the estimate of the
    test MSE that we would get through five-fold CV.

### 4\. Is simple sufficient?

The model that we fit in no. 2 is very similar to the simple-minded
model. Let’s compare the similarity in these models. We could go about
this in two ways. We could *simulate* from the simple-minded model many
times and fit a model of the same form as no. 2 to each one to see if
our observed slope in no. 2 is probable under the simple-minded model.
We could also *bootstrap* the data set many times, fitting model 2 each
time, then see where the simple-minded model lays in that distribution.
Since we already have practiced with simulation, let’s do the bootstrap
method.

1.  Form the bootstrap distribution for the slope of `1/MAPE` (the code
    from class may be helpful). Plot this distribution with the
    parameter of interest (the slope corresponding to the simple-minded
    model) indicated by a vertical line.
2.  What is the approximate 95% bootstrap confidence interval for the
    slope? How does this interval compare to the one returned by running
    `confint()` on your model object from question 2? Please explain any
    difference you’ve found.

### 5\. One big happy plot

For this problem, you need to only include one plot and one paragraph of
writing. Also, in this problem, take “line” to mean “straight or curved
line” as appropriate, and be sure to plot actual lines and not
disconnected points.

1.  Make a scatterplot of the returns against `MAPE`.
2.  Add two lines showing the predictions from the models you fit in
    problems 1 and 2.
3.  Add a line showing the predictions from the simple-minded model from
    problem 3.

### The big picture

1.  **Cross-validation for model selection**: using CV MSE, which model
    would you select to make predictions of returns? Looking at the plot
    in question 5, does this seem like a good model? What are its
    strengths and weaknesses for prediction?
2.  **Bootstrapping for uncertainty estimation**: based on your
    bootstrapping procedure for the slope of the linear model using
    `1/MAPE` as a predictor, is the simple-minded model a plausible
    model given our data?

-----

Based on a homework of Cosma Shalizi at CMU.

-----

#### Chapter 5 exercises

Numbers 4 and 8.
