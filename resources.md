## GitHub and RStudio

Instructions for all of this are here:

[http://happygitwithr.com](http://happygitwithr.com)

### Claim your repository

Head over to [http://www.github.com/stat-learning](http://www.github.com/stat-learning). Note that we have added you to a private repository (aka folder) that belongs only to you. There are exactly three people that can see this repo: you, Andrew, and Philip, the class TA. Other than that, it's private - the rest of the internet cannot see it.

Go to that repository in your browser.

Copy the HTTPS URL. It will be something like this:

```https://github.com/stat-learning/andrew-bray```

In RStudio, start a new Project:

- File > New Project > Version Control > Git. In the “repository URL” paste the URL of your new GitHub repository.
- Be sure to notice the local directory for the Project. This will be the main folder for your coursework on your computer. Edit the location of this folder if you want it elsewhere. This project will create a new sub-directory, which will be all of these things:
    - a directory/folder on your computer
    - a git repository, linked to a remote GitHub repository
    - an RStudio Project
- Create the Project.

Make some local changes, e.g. edit or add files.

Commit these changes to your local repo.

Push to GitHub.

Repeat ad nauseum as you do your coursework.


## Homework workflow

### Creating, committing, pushing

Every time you're ready to work on an assignment, open up RStudio and be sure you're open to your named project (like "andrew_bray") indicated by the blue cube in the upper right hand corner. This is where you'll do the bulk of your coursework from here on out: it is a directory on your computer, a Git repo associated with GitHub remote, and an RStudio project.

To start an assignment, create a new R Markdown file and change its output format to `github_document`. As you save this file, you'll see it pop up in the Git pane in the upper right hand panel. Periodically, you may want to "knit" the file to see how the compiled version looks. 

Whenever you complete a good chunk of work on the assignment, click the boxes next to any changed files then click "commit", provide a commit message, and click "commit". This records how the file has changed. Close out of these windows and resume working on the assignment.

Once you're done with the assignment, commit any final changes to files and click the green "push" arrow in the Git pane. This will send all of your commits to Github.

* * *

## Materials to review

#### Statistics

For review of the fundamental concepts of statistics, see [OpenIntro: Introductory Statistics with Randomization and Simulation](https://www.openintro.org/stat/textbook.php?stat_book=isrs) (2014), by Diez, Barr and Çetinkaya-Rundel, available in three formats: pdf, tablet-friendly pdf, and paperback edition. The textbook is free and open-source. For general concepts
of data and inference, see chapters 1 and 2. For regression, see chapters 5 and 6.

#### R

If you're new to R or need a refresher, there are some free online courses
that can be helpful. You can sign-up for a free semester-long subscription to DataCamp [here](https://www.datacamp.com/groups/shared_links/121d32ce5a79905070920376db7d559bcf630fc6). I recommend the *Introduction to Data Visualization with ggplot2* and *Data Manipulation with dplyr in R* courses. You may also be interested in Intro to R and Intro to the Tidyverse.

There is also a free online reference book for the fundamentals of the R languaged called [Cookbook for R](http://www.cookbook-r.com/).

Once you're up and running, it can be helpful to have the most important information
distilled into one sheet of paper. RStudio puts out several great ones including
the [Visualization Cheatsheet (ggplot2)](http://www.rstudio.com/wp-content/uploads/2015/12/ggplot2-cheatsheet-2.0.pdf)
and the [Data Wrangling Cheatsheet (dplyr)](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf).

If you imagine yourself using R and RStudio after this course and after
Reed, you should get it setup on your own machine. [This tutorial](http://www.reed.edu/data-at-reed/software/R/r_studio.html) will walk
you through all the downloading, installing, and configuration.

#### R Markdown
R Markdown is a very important tool to enable data analysis that is completely
transparent and easily reproducible. [These slides](https://prezi.com/dvmgx17e_was/reproducible/) walk through the motivation
and basic structure of R Markdown while [this video](https://www.youtube.com/watch?v=DNS7i2m4sB0) is a good walkthrough to making
your first R Markdown document.

[Here](https://www.stat.cmu.edu/~cshalizi/rmarkdown/) is a great primer for using R Markdown and Latex.

For all the important ideas summarized into a single place, you can use the [R Markdown cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf).
