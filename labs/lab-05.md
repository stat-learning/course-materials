
## Lab 5: The Sound of Gunfire, Off in the Distance

Our first dataset this week comes from a study of the causes of civil
wars.\[1\] The data can be read into from a csv posted online by using
the following
command.

``` r
war <- read.csv("http://www.stat.cmu.edu/~cshalizi/uADA/15/hw/06/ch.csv", row.names = 1)
```

Every row of the data represents a combination of a country and of a
five year interval — the first row is Afghanistan, 1960, really meaning
Afghanistan, 1960–1965. The variables are:

  - The country name;
  - The year;
  - An indicator for whether a civil war began during that period: 1
    indicates a civil war has begun, the code of NA means an on-going
    civil war, 0 means peace.
  - Exports, really a measure of how dependent the country’s economy is
    on com- modity exports;
  - Secondary school enrollment rate for males, as a percentage;
  - Annual growth rate in GDP;
  - An index of the geographic concentration of the country’s population
    (which would be 1 if the entire population lives in one city, and 0
    if it evenly spread across the territory);
  - The number of months since the country’s last war or the end of
    World War II, whichever is more recent;
  - The natural logarithm of the country’s population;
  - An index of social “fractionalization”, which tries to measure how
    much the country is divided along ethnic and/or religious lines;
  - An index of ethnic dominance, which tries to measure how much one
    ethnic group runs affairs in the country.

Some of these variables are NA for some countries.

### 1

**Estimate**: Fit a logistic regression model for the start of civil war
on all other variables except country and year (yes, this makes some
questionable assumptions about independent observations); include a
quadratic term for exports. Report the coefficients and their standard
errors, together with R’s p-values. Which ones are found to be
significant at the 5% level?

### 2

**Interpretation**: All parts of this question refer to the logistic
regression model you just fit.

1.  What is the model’s predicted probability for a civil war in India
    in the period beginning 1975? What probability would it predict for
    a country just like India in 1975, except that its male secondary
    school enrollment rate was 30 points higher? What probability would
    it predict for a country just like India in 1975, except that the
    ratio of commodity exports to GDP was 0.1 higher?
2.  What is the model’s predicted probability for a civil war in Nigeria
    in the period beginning 1965? What probability would it predict for
    a country just like Nigeria in 1965, except that its male secondary
    school enrollment rate was 30 points higher? What probability would
    it predict for a country just like Nigeria in 1965, except that the
    ratio of commodity exports to GDP was 0.1 higher?
3.  In the parts above, you changed the same predictor variables by the
    same amounts. If you did your calculations properly, the changes in
    predicted probabilities are not equal. Explain why not. (The reasons
    may or may not be the same for the two variables.)

### 3

**Confusion**: Logistic regression predicts a probability of civil war
for each country and period. Suppose we want to make a definite
prediction of civil war or not, that is, to classify each data point.
The probability of misclassification is minimized by predicting war if
the probability is ≥ 0.5, and peace otherwise.

1.  Build a 2 × 2 *confusion matrix* (a.k.a. “classification table” or
    “contigency table”) which counts: the number of outbreaks of civil
    war correctly predicted by the logistic regression; the number of
    civil wars not predicted by the model; the number of false
    predictions of civil wars; and the number of correctly predicted
    absences of civil wars. (Note that some entries in the table may be
    zero.)
2.  What fraction of the logistic regression’s predictions are
    incorrect, i.e. what is the misclassification rate? (Note that this
    is if anything too kind to the model, since it’s looking at
    predictions to the same training data set).
3.  Consider a foolish (?) pundit who always predicts “no war”. What
    fraction of the pundit’s predictions are correct on the whole data
    set? What fraction are correct on data points where the logistic
    regression model also makes a prediction?

### 4

**Comparison**: Since this is a classification problem with only two
classes, we can compare Logistic Regression right along side
Discriminant Analysis.

1.  Fit an LDA model using the same predictors that you used for your
    logistic regression model. What is the training misclassification
    rate?
2.  Fit a QDA model using the very same predictors. What is the training
    misclassification rate?
3.  How does the prediction accuracy of the three models compare? Why do
    you think this is?

-----

**Challenge problem**: Using the code available from class slides,
construct an ROC curve for your logistic regression model. For an extra
challenge, plot the ROC curves of all three models on the same plot.

-----

#### Chapter 4 exercises

4, 6, 7

-----

1.  Based on an exercise of Cosmo Shalizi’s that uses data from Collier,
    Paul and Anke Hoeffler (2004). *Greed and Grievance in Civil War.*
    Oxford Economic Papers, 56: 563–595. URL:
    <http://economics.ouls.ox.ac.uk/12055/1/2002-01text.pdf>.
