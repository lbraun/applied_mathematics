# SIW004: Homework 3
# -------------------------------
# H3: Final Homework (individual)
# -------------------------------

# 0. Load data
sids <- read.table("/Users/lucasbraun/Google\ Drive/Grad\ School/Applied\ Mathematics/RSPCMA/Data/chap7sids.csv", header = TRUE, sep = ",")

# 1. Extract as much information as possible from the data
# set using graphical tools as described in Chapter 2 of Everitt.

# One of the questions about these data might be “How is birthweight related to heart rate?”
# A first step in answering the question would be to examine a scatterplot of the two variables.
# Here, in fact, we will produce four versions of the basic scatterplot:

PlotFourWays <- function(data, x.label, y.label) {
  x = do.call("$", list(data, x.label))
  y = do.call("$", list(data, y.label))

  # Set up plotting area to take four graphs
  par(mfrow=c(2,2))
  par(pty="s")
  SimplePlot("(a)", x, y, x.label, y.label)

  SimplePlot("(b)", x, y, x.label, y.label)
  # Add regression line
  abline(lm(y~x),lwd=2)

  # Jitter data
  data.jitter<-jitter(cbind(x,y))
  SimplePlot("(c)", data.jitter[,1], data.jitter[,2], x.label, y.label)

  SimplePlot("(d)", x, y, x.label, y.label)
  # Add rug plots
  rug(jitter(x), side=1)
  rug(jitter(y), side=2)

  file.name <- paste(x.label, '_vs_', y.label, '.png', sep="")
  dev.copy(png, file.name)
  dev.off()
}

SimplePlot <- function(data, x.label, y.label) {
  plot(x, y, xlab=x.label, ylab=y.label, pch=1, lwd=2)
  title(title, lwd=2)
}

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
  abline(lm(y~x),lwd=2)
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


# 2. Perform a PCA and interpret the results.

# 3. Find homogeneous clusters amongst the individuals without
# considering the variable Group (use hierarchical and k-means methods
# under two distinct choices of distance methods). Compare the results
# with the existing groups given by variable "group". Then perform LDA
# and classify into these groups the following two new observations:
# Obs1: (110,3320,0.240,39); Obs2: (120,3310,0.298,37).
