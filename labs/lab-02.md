
## Lab 2: Linear Regression

### An Island Never Cries

1000 large seimic events around Fiji have been collected in a data set
called `quakes` that is built into R. You can learn more about it with
the following commands:

``` r
data(quakes)
str(quakes)
?quakes
```

#### Earthquake detection

Included in the data set is a column recording the number of stations
that detected each earthquake. This refers to a global network of
seismographs and it stands to reason that the larger the quake, the more
widely it will be detected.

1.  Create a plot of the relationship between `stations` and
    `magnitude`. How would you characterize the relationship? (If you
    see overplotting, you may want to add `jitter` to your points or
    make them transparent by playing with the `alpha` value.)

2.  Before you go ahead and fit a linear model to this trend, if in fact
    there was *no relationship* between the two, what would you expect
    the slope to be? What about the intercept?

3.  Ok, now go ahead and fit a linear model called `m1` to the trend and
    add that line to the plot from exercise 1. Interpret your slope and
    intercept in the context of the problem.

4.  Verify the way that `lm()` has computed your slope correctly by
    using R to do the calculation using the equation for the slope based
    on X and Y.

5.  Using R, calculate a 95% confidence interval for the slope of the
    model that you fit in exercise 3. Confirm the calculation using
    `confint()`.

6.  How many stations do you predict would be able to detect an
    earthquake of magnitude 7.0?

7.  Questions 1 - 6 in this lab involve elements of *data description*,
    *inference*, and/or *prediction*. Which was the dominant goal in
    each question?

-----

### Simulation

One good way to assess whether your fitted model seems appropriate is to
simulate data from it and see if it looks like the data that you
observed. For the following questions it will be useful to reference the
R code provided in the previous two lectures.

9.  Please simulate a data set that has the same number of observations
    as `quakes`. To start, generate a vector of x’s. You can either
    generate your own x’s or use the exact same x’s as the `quakes`
    data.

10. Next, generate your \(\hat{y}\)’s (the value of the mean function at
    the observed x’s). Please generate them by writing your own function
    of the form:

<!-- end list -->

``` r
f_hat <- function(x) {
  # code goes here
}
```

11. Now, generate the y’s. Note that you’ll need an estimate of
    \(\sigma^2\), for which you can use \(\hat{\sigma}^2 = RSS/n - 2\).
    You can extract the vector of residuals with `m1$res`.

12. Finally, make a plot of your simulated data. How is it similar to
    the original data? How is it different? How might you change your
    model to make it more consistent with the data?

-----

**Challenge problem** Use the latitude and longitude data to plot each
of these earthquakes in `quakes` on a map with their magnitude mapped to
the size of the plotting character. You may need to ad some transparency
to prevent overplotting.

# Part II: TBA
