# SIW004: Homework 3
# -------------------------------
# H3: Final Homework (individual)
# -------------------------------

# 0. Load data
sids <- read.table("/Users/lucasbraun/Google\ Drive/Grad\ School/Applied\ Mathematics/RSPCMA/Data/chap7sids.csv", header = TRUE, sep = ",")

# 1. Extract as much information as possible from the data
# set using graphical tools as described in Chapter 2 of Everitt.

# Graphs of all variables with Group as text label, ablines and rugs with jitter
CombinedPlot <- function(data, x.label, y.label, labels=NULL) {
  x <- do.call("$", list(data, x.label))
  y <- do.call("$", list(data, y.label))
  title <- paste(x.label, 'vs.', y.label)

  if (is.null(labels)) {
    plot(x, y, xlab=x.label, ylab=y.label, pch=1, lwd=2)
  } else {
    plot(x, y, xlab=x.label, ylab=y.label, lwd=2, type="n")
    text(x, y, labels=labels, lwd=2)
  }

  title(title, lwd=2)
  abline(lm(y ~ x),lwd=2)
  rug(jitter(x), side=1)
  rug(jitter(y), side=2)

  file.name <- paste(x.label, '_vs_', y.label, '.png', sep="")
  dev.copy(png, file.name)
  dev.off()
}

names <- names(sids)

for (i in names) {
  for (j in names) {
    if (i != j && i != "Group" && j != "Group") {
      CombinedPlot(sids, i, j, labels = sids$Group)
    }
  }
}


# Scatterplot matrix
CustomPanel <- function(x, y) {
  abline(lsfit(x, y)$coef, lwd=2)
  lines(lowess(x, y), lty=2, lwd=2)
  text(x, y, labels=sids$Group, lwd=2)
}

CustomDiagonalPanel <- function(x, ...) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}

pairs(sids, panel=CustomPanel, diag.panel=CustomDiagonalPanel)
dev.copy(png, 'scatterplot_matrix.png')
dev.off()


# Chiplots of all variables
ChiplotThis <- function(data, x.label, y.label, jitter.on = FALSE) {
  x <- do.call("$", list(data, x.label))
  y <- do.call("$", list(data, y.label))

  if (jitter.on) {
    chiplot(jitter(x), jitter(y), vlabs=c(x.label, y.label))
  } else {
    chiplot(x, y, vlabs=c(x.label, y.label))
  }
    chiplot(mydata$BW, mydata$HR, vlabs=c(x.label, y.label))

  title(paste(x.label, 'vs.', y.label), lwd=2)

  file.name <- paste('chi_', x.label, '_vs_', y.label, '.png', sep="")
  dev.copy(png, file.name)
  dev.off()
}

# Bivariate boxplots
BoxplotThis <- function(data, x.label, y.label) {
  source(paste(getwd(), "/functions.txt", sep = "")) # Load functions from file

  x <- do.call("$", list(data, x.label))
  y <- do.call("$", list(data, y.label))

  bvbox(cbind(x, y), xlab = x.label, ylab = y.label)
  title(paste(x.label, 'vs.', y.label), lwd=2)

  file.name <- paste('box_', x.label, '_vs_', y.label, '.png', sep="")
  dev.copy(png, file.name)
  dev.off()
}

names <- names(sids)

for (i in names) {
  for (j in names) {
    # if (i != j && i != "Group" && j != "Group") {
    if (i != j) {
      # ChiplotThis(sids, i, j)
      BoxplotThis(sids, i, j)
    }
  }
}


# Coplots
CustomCoplotPanel <- function(x, y, ...) {
  panel.smooth(x,y,span=.8,iter=5,...)
  abline(lm(y ~ x), col="blue")
}
coplot(sids$BW ~ sids$Group | sids$HR, panel = CustomCoplotPanel)
coplot(sids$Factor68 ~ sids$Group | sids$HR, panel = CustomCoplotPanel)
coplot(sids$Gesage ~ sids$Group | sids$HR, panel = CustomCoplotPanel)



# 2. Perform a PCA and interpret the results.
cor(sids)
sids.princomp <- princomp(sids, cor = TRUE)
summary(sids.princomp, loadings = TRUE)

> cor(sids)
               Group          HR          BW   Factor68      Gesage
Group     1.00000000  0.09840039 -0.36515165  0.4517354 -0.29920724
HR        0.09840039  1.00000000 -0.02192954  0.2098967  0.04031584
BW       -0.36515165 -0.02192954  1.00000000 -0.0785167  0.42490365
Factor68  0.45173535  0.20989675 -0.07851670  1.0000000 -0.24570910
Gesage   -0.29920724  0.04031584  0.42490365 -0.2457091  1.00000000
> sids.princomp <- princomp(sids, cor = TRUE)
> summary(sids.princomp, loadings = TRUE)
Importance of components:
                          Comp.1    Comp.2    Comp.3    Comp.4     Comp.5
Standard deviation     1.4013823 1.0769124 0.9080590 0.7983384 0.64379513
Proportion of Variance 0.3927744 0.2319481 0.1649142 0.1274688 0.08289443
Cumulative Proportion  0.3927744 0.6247225 0.7896367 0.9171056 1.00000000

Loadings:
         Comp.1 Comp.2 Comp.3 Comp.4 Comp.5
Group    -0.558 -0.105 -0.240  0.564 -0.549
HR       -0.147 -0.697  0.674 -0.129 -0.146
BW        0.468 -0.407 -0.493 -0.325 -0.517
Factor68 -0.456 -0.454 -0.491 -0.213  0.547
Gesage    0.490 -0.363         0.717  0.334

# So it looks like (based on the 70% stopping rule) with three components we can
# represent enough of the variation, 79%!



# 3. Find homogeneous clusters amongst the individuals without
# considering the variable Group (use hierarchical and k-means methods
# under two distinct choices of distance methods). Compare the results
# with the existing groups given by variable "group".
sids.no.groups <- sids[,-1]

# Determine maximum number of clusters we will want
sqrt(nrow(sids.no.groups)) # => 8.062258 => 8

# Calculate the within-group sum of squares for clustering factor 1
wss <- (nrow(sids.no.groups) - 1) * sum(apply(sids.no.groups, 2, var))

# Calculate the within-group sum of squares for clustering factors 2 through 8
for (i in 2:8) wss[i] <- sum(kmeans(sids.no.groups, centers=i)$withinss)
plot(1:8, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")
title("WSS vs. Number of Clusters", lwd=2)
dev.copy(png, "wss_vs_clusters.png")
dev.off()

# K-Means Cluster Analysis
fit <- kmeans(sids.no.groups, 3) # The graph indicates 4 is the right number of clusters
# Get cluster means
aggregate(sids.no.groups, by=list(fit$cluster), FUN=mean)
# Append cluster assignment
sids.kmeans <- data.frame(sids.no.groups, fit$cluster)

# Cluster Plot against 1st 2 principal components
library(cluster)
clusplot(sids.no.groups, fit$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)


# # Then perform LDA and classify into these groups the following two new
# # observations:
# # Obs1: (110,3320,0.240,39); Obs2: (120,3310,0.298,37).
# library(MASS)
# attach(sids.kmeans)
# dis<-lda(fit.cluster ~ diff0 + diff25 + diff50 + diff75, data = sids.no.groups)


# newdata<-rbind(c(65,50,33,15,69,57,37,16),c(59,46,31,15,64,56,33,16))
# newdata<-newdata[,5:8] - newdata[,0:4]
# colnames(newdata)<-colnames(sids.no.groups[,-5])

# newdata<-data.frame(newdata)
# predict(dis,newdata=newdata)
