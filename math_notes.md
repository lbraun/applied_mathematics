# SIW004 NOTES

## January 17, 2018
- 12 minutes late starting class
- Homework 2 due next Monday (Jan. 22)
- There will be one final homework that is individually based
- Should have ten days to do this final exercise

### Cluster analysis continued
- We can make homogeneous groups based on the rows or on the columns
- Individuals belonging to the same group should behave similarly
- Individuals belonging to different groups should behave differently
- Three types:
  - PCA
  - Hierarchical Cluster Analysis
  - K-Means
- Clustering can be highly grouped or highly separate. Either extreme is not helpful, somewhere in the middle is ideal
- Inter-cluster distance measures
  - Three ways to calculate (three ways to join clusters together):
    - Single linkage (minimum distance)
    - Complete linkage (minimum distance)
    - Group average clustering (average distance between cluster individuals)
- Dendrograms: tree showing how clusters will break out for each cluster distance
- Deciding what part of the diagram to use is very subjective
- Is there a way to calculate clustering objectively?
  - Yes, with K-Means clustering

#### K-Means Clustering
- Helps the researcher know the optimal number of clusters
- Optimal is defined when some "numerical criterion" is minimized
  - The numerical criterion is the "within-group sum of squares over all variables"
  - Within-group means within each group
  - Which variables do we square? The variability measure, so that we have the lowest variability from the mean value of each cluster.
  - Find the minimum number of clusters where the within-group sum of squares stops decreasing
  - Rule of thumb says number of groups should not exceed the square root of the number of individuals
    - E.g. 46 individuals => no more than 6 groups

#### 7.2.2 Fisher's Linear Discriminant Function
- What to do with new individuals?
- Build an equation, a linear combination of the original equation
  - The coefficients have to be chosen very carefully, so as to maximize the ratio of B/S
  - B is the between-group distance
  - S is the within-group distance
- Then use the equation to calculate a "discriminate score" _z_ for the newcomer
- The allocation rule says that the individual goes into group 1 if the score is greater than the average between the scores for group 1 and group 2

### Practical practice
- Load data "life": represents life expectancies based on age groups in different countries
- Can we cluster the countries?
- `hclust` is the function for Hierarchical Cluster Analysis
  - Takes matrix of distances and clustering method
- `plclust` gives the dendrogram
- `dist(life)` gives distances
- `cutree` cuts the dendrogram at given value "h"
- `lapply` can show cluster memberships or cluster mean values
  - "‘lapply’ returns a list of the same length as ‘X’, each element of which is the result of applying ‘FUN’ to the corresponding element of ‘X’."

#### Tibet data
- `lda` = linear discriminate analysis
  - Prior means probability that an individual will belong to a certain group-- when you have no idea, just use 0.5
  - When we use this function, the "LDs" are the coefficients from the Fisher's LD function we were talking about earlier
- `predict` gives probabilities of which group new individuals belong to
  - Should be at least a 30 percent difference between the probabilities for the result to be considered significant


## December 21, 2017
- R squared represents "goodness of fit"

### Cluster analysis
- Figure out which variables are behaving "homogeneously"
- To find commonality, check distances

## December 20, 2017
- What is a big matrix? 1000 columns might be hard to work with.
- How to reduce the number of dimensions of your data?

### Principal Components Analysis (PCA)
- Transform original data (x1, x2, ..., xq) into principal components (y1, y2, ..., yq)
- Variables are derived in decreasing order of importance
- How to derive these y values? `y1 = a11 * x1 + a12 * x2 + ... + a1q * xq`
  - With the condition `a'j * aj = 1` and `a'j * ai = 0` when `i < j`
- One variable gets most of the variance means it holds most of the information from the original values
- "S" is the variance-covariance matrix
- Is always square
- This is good because we can only do PCA on square matrices
- Eigenvalues and eigenvectors--- ???
  - Every time you have a covariance matrix, we can obtain eigenvalues and eigenvectors
  - There will be one eigenvalue for each dimension of the matrix
  - There will be one eigenvector for each eigenvalue
- Stopping rule:
  - After you are representing 70 percent of the variation

#### Example
- Follow rsplus3.r
- Use `princomp` method to perform PCA
- Look at the summary to see which components can me ignored (after the third the "cumulative proportion" is higher than 70 percent)
- `⊥` signifies independence


## December 13, 2017
- Late by 10 minutes
- Review: chiplot shows correlation between two values
- Homework:
  - Complete description: everything we've done on multivariate data. Looking at graphical data.
  - Ex. 3 is from the first chapter

### Bivariate Box Plot
- `boxplot(x)` produces box-and-whisker plot(s) of the given (grouped) values.
  - The box contains fifty percent of the data (second and third quartile aka between Q25 and Q75)
  - The line in the middle represents the median (quartile 50)
  - If line is not in the middle, it's an indication of asymmetry
- `boxplot(SO2)` shows outliers
  - Outliers defined as anything larger than quartile 75 plus two times the standard deviation of the value
- `bvbox(x)` shows a two dimensional box plot

### Bivariate Density
- ???
- Useful for determining probability
- `persp` produces a 3D plot
  - Change "theta" and "phi" to change the angle of view
- Analytical (or closed) form means a formula depending on the two values that can be evaluated
  - Required in order to integrate
- "Integration is summing"
  - Dividing up the domain in to a small grid and sum up all the values
  - This technique is known as "Monte Carlo approximation"

### Other useful visualizations
- `pairs(x)` produces a matrix of scatter plots
- `coplot(<formula>)` shows how the correlation between two variables is impacted by a third



## December 7, 2017
- First exercise on Wednesday: will be based on first two chapters
- One way to access columns in a dataset: `<dataset>$<column_name>`
- Another way: `<dataset>[,<column_index>]`
- A third way: `attach(<dataset>)` then just `<column_name>`

### Plot variables
- `lwd = 2` sets line width to 2
- `pty = "s"` defines plot within a square
- `pch = 1` sets symbols to circles
- `plot(<x_variable>, <y_variable>)`

- `par` is "used to set or query graphical parameters."
- `lm` is used to fit linear models.
  - "It can be used to carry out regression, single stratum analysis of variance and analysis of covariance."
- `lm(Mortality~SO2)` gives you intercept and slope
  - Mortality = 917.9 + 0.4181 SO2
  - Check `summary(lm(Mortality~SO2))`
  - `Multiple R-squared:  0.1815`, so they are not linearly dependent
  - If Multiple R-squared is close to 1, they may be linearly dependent
- `jitter(<vector>)` shifts the data just a little bit for a clearer visual impression
  - "Add a small amount of noise to a numeric vector."
  - Can help you see data when points are very close together
- `help(<command>)`
  - Loads documentation
- `rug(<vector>)`
  - "Adds a _rug_ representation (1-d plot) of the data to the plot"
- `text(<x>, <y>, <labels>)`
  - "Draws the strings given in the vector ‘labels’ at the coordinates given by ‘x’ and ‘y’"
- `abbreviate(<names>)`
  - "Abbreviate strings to at least ‘minlength’ characters"
- `lowess(<vector>)`
  - "Performs the computations for the _LOWESS_ smoother which uses locally-weighted polynomial regression"
  - Fits a line locally, and then joins the lines together

### Our example with SO2 x Mortality
- Not good to plot linearly for two reasons:
  - One variable (SO2) is not normally distributed
  - ??

Convex Hull
- Polygon made with straight edges using extremal points as nodes
- Size of convex hull is directly related to number of extremal points
  - Helps to identify outliers
  - Outlying data lowers correlation
- `x = seq(1,30,len=20)` gives a sequence of 20 numbers
- `x[-c(1,20)]` says "do not take" values in column 1 and 20

Chiplot
- Helps to discover if two variables are dependent or not (in any way)
- Gives a plot graph with two lines
  - If the values are within the two lines, the values are independent
  - This is called the confidence interval

## December 4, 2017
- Vector of means: single "row" with mean of each column
- Variance covariance matrix: shows if relationships are linear or inverse
  - R syntax: var(<matrix>)
  - Cannot be used to show how strong the correlation is
- Correlation matrix: shows how strong the correlation is
  - R syntax: cor(<matrix>)
  - Values between -1 and 1
- Euclidean distance
  - Most commonly used distance
  - Major problem: dependent on units
  - R syntax: dist(<matrix>)
    - For efficiency, outputs only half of a matrix (lower triangle matrix) because output would be symmetric
    - Can use function `dist2full` from "functions.txt"

## November 30, 2017
Classic matrices

Variables can hold anything
Discrete vs. continuous values
- Important to know which you are working with if trying to perform calculations on a matrix
- Depending on the input variables, the output varies
- Every type of variable has its own rules of behavior
- Cannot make a regression for every type of variable (e.g. temp = pollution * 13 is just false)
- What to do with missing data? Throw the whole row out? Or find "the meaning of the missing"

Simple operations on matrices
- Means
  - Has two meanings:
    1. Arithmetic mean -- standard "average" calculation
    2. Expected value -- a.k.a. theoretical mean: arithmetic means are representatives of this common value
- Variances

When we devide values by their standard deviation, we remove the dependence on units

### Correlations
- Fall between -1 and +1
- Do not depend on units
- Work with these because they are easy to compare


### Distance Properties
- dist(A, A) is 0
- dist(A, B) = dist(B, A)
- dist(A, B) is always less than or equal to dist(A, C) + dist(C, B)
- *But these only apply to Euclidean distances*

### Taxicab geometry (Manhattan distance)
- dist(A, B) depends on one-way-streets

### Getting started with R
Define a matrix:
`mat=matrix(runif(25),ncol=5,nrow=5,byrow=T)`

Get the 4th col:
`mat[,4]`


Get the 2nd row:
`mat[2,]`

???
`mat[c(2,4),5]`

Transpose:
`t(mat)`

Get the inverse:
`matinv = solve(mat)`

Check identity (`%*%` used to multiply matrices):
`mat%*%matinv`


### Singular Matrices
- Determinant = 0
- Don't have an inverse
- Some column is linearly dependent on another column
