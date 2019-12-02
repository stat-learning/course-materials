# Project

This is your chance to put all of the modeling techniques that you've been learning into action on a question and data set that is of interest to you. The main deliverable will be a presentation during the final week of class, but there are several other components that prepare the groundwork. They are, with their due dates:

1. Pre-proposal: Sunday 11/3 11:59 pm
2. Group proposal: Thursday 11/7 11:59 pm
3. Technical Report (Exploratory Data Analysis section only) : Wednesday 11/20 before class
4. Technical Report: Monday 12/2 before class
5. Final Presentations: Wednesday 12/4 and Monday 12/9 in class

## Pre-proposal

Please suggest three topics that are of interest to you to study in this project. For each, you should indicate your question, whether it suggests a classification or regression model, whether it is primarily predictive or descriptive, and a sense of what data you would use (along with a link if you have it).

An example:

1. Can we built a model to accurate predict whether a person is a republican or democrat based on their tweets? Classification. Predictive. We will train our model on data gather through the Twitter API from elected officials with known party affiliation.

I encourage you to think broadly about your topic area. This can build off of a neat idea you came across in another class, allow you to delve into the data modeling side of a particular hobby of yours, or a chance to build a tool for something that you're passionate about.

When it comes to "data", you can also think beyond CSVs. Rich data lives online in unstructured data at websites like the New York Times archive, IMDB, Yelp, Twitter, Rotten Tomatoes, etc. The data can also be in the form of images or sound files. You might also want to consider generating your own data using a new tool like: http://nickstrayer.me/shinysense/ .

I will be putting people in groups of three. If you have strong opinions of who you'd like to work with, please include those as well.

### Groups

1. Naomi Boss, Kyla Hayworth, Nat Rubin
2. Josh Dey, Gio Ramirez, Emmett Powers
3. Claire Jellison, Jacob Goldsmith, Ryan Kobler 
4. Sarah Maebius, Nolan Anderson, Tim Shinners
5. Joe Yalowitz, Eva Licht, Alyssa Andrichik
6. Yilin Li, Hien Nguyen, Lyn Peterson
7. Ben Thomas, Olek Wojcik, Alice Chang
8. Isidore Weiss, Evan Pugh, Isaac Martin
9. David Herrero Quevedo, Paul Nguyen


## Group Proposal

Meet with your group and decide on three topics to put forward. These should have component (question, model type, data source, etc) clearly articulated. Each group member should submit to GitHub the same .md file.


## Technical Report

Your technical report should be an .Rmd file that contains the following sections. So as not to make the compilation (knitting) of the document not take too long, consider setting `cache = TRUE` in the curly braces of any R chunk with substantial computing. Please knit both to pdf and github document (.md).

### Abstract
A brief overview of the area that you’ll be investigating, the research question(s) of interest, your approach to analysis, and the general conclusions.

### Introduction
Overview of the setting of the data, existing theories/models (particularly if you are working in a descriptive/inferential setting), and your research questions.

### The Data
Where does the data come from? How many observations? How many variables? What does each observation refer to (what is the observational unit)? What sorts of data processing was necessary to get the data in shape for analysis?

### Exploratory Data Analysis
Explore the structure of the data through graphics. Here you can utilize both traditional plots as well as methods from unsupervised learning. Understanding the distribution of your response is particular important, but also investigate bivariate and higher-order relationships that you expect to be particular interesting.

### Modeling
Construct (descriptive and/or predictive) (classification and/or regression) models that address your research questions. You are encouraged to fit many different classes of models and see how they compare in terms the bias/variance tradeoff (do you have a Rashomon effect going on?). Also be sure to guard against overfitting through cross-validation or shrinkage/penalization (don’t forget about ridge regression and the lasso).

This will be the most extensive section and will include your results as well.

### Discussion
Review the results generated above and sythensize them in the context from which the data originated. What do the results tell your about your original research question? Are there any weaknesses that you see in your analysis? What additional questions would you explore next?

### References
At minimum, this will contain the full citation for your data set. If you reference existing analyses, they should be cited here as well.


## Presentations

Each group will have 10 minutes to present their work. You are encouraged to use slides and/or handouts to help your audience understand your work. When using slides, any format is fine as long as they can be projected from your laptop or the classroom computer. The structure of the talk should mirror the structure of the technical report. Each talk will be followed by five minutes of Q and A.

Some recommendations:

- Practice your talk beforehand and be sure you have your first three sentences and your last three sentences down pat. Be cognizant of timing to use the full 10 minutes and not more.
- Be judicious in your use of slides. Much better a small number of well-composed slides with a unified aesthetic than a pile of messy slides.
- Consider slides like writing: start with drafts then revisit and ask yourself: what is the main story this slide is trying to tell? What can I add or take away to help that story?


