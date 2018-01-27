# SIW004: Homework 2
# --------------------------------------------------------------------------------------------------------
# H2: Principal Component Analysis, Cluster Analysis and Discriminant Analysis
# --------------------------------------------------------------------------------------------------------
# 1) Exercise 3.6 (page 63)
# The data in Table 3.6 show the nutritional content of different foodstuffs (the quantity involved
# is always three ounces). Use S-PLUS or R to create a scatterplot matrix of the data labeling the
# foodstuffs appropriately in each panel. On the basis of this diagram undertake what you think is an
# appropriate principal components analysis and try to interpret your results.
food.dat <- read.table("/Users/lucasbraun/Google\ Drive/Grad\ School/Applied\ Mathematics/RSPCMA/Data/chap3food.csv", header = TRUE, sep = ",")
food.dat <- read.table("<insert path here>/RSPCMA/Data/chap3food.csv", header = TRUE, sep = ",")
attach(food.dat)

# Create a scatterplot matrix
pairs(food.dat[,-1])

# Run PCA
cor(food.dat[,-1])
food.pc<-princomp(food.dat[,-1],cor=TRUE)
summary(food.pc,loadings=TRUE)


# 2) Exercise 6.5 (page 136)
# Reanalyze the life expectancy data by clustering the countries on the basis of differences between
# the life expectancies of men and women at corres- ponding ages.
life<-source(paste(getwd(), "/Data/chap4lifeexp.dat", sep = ""))$value

# Find the life expectancy differences between women and men
life.data<-life[,5:8] - life[,0:4]
colnames(life.data)<-c("diff0", "diff25", "diff50", "diff75")

# Calculate the within-group sum of squares for clustering factor 1
wss <- (nrow(life.data)-1) * sum(apply(life.data,2,var))

# Determine maximum number of clusters we will want
sqrt(nrow(life.data)) # => 5.6

# Calculate the within-group sum of squares for clustering factors 2 through 6
for (i in 2:6) wss[i] <- sum(kmeans(life.data, centers=i)$withinss)
plot(1:6, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")

# K-Means Cluster Analysis
fit <- kmeans(life.data, 4) # The graph indicates 4 is the right number of clusters
# Get cluster means
aggregate(life.data,by=list(fit$cluster),FUN=mean)
# Append cluster assignment
life.kmeans <- data.frame(life.data, fit$cluster)

# Cluster Plot against 1st 2 principal components
library(cluster)
clusplot(life.data, fit$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)


# Considering the groups/clusters previously found, classify into these groups the following two new
# observations:
# Country1:(65,50,33,15,69,57,37,16)
# Country2:(59,46,31,15,64,56,33,16)
library(MASS)
attach(life.kmeans)
dis<-lda(fit.cluster ~ diff0 + diff25 + diff50 + diff75, data = life.data)
#
#
newdata<-rbind(c(65,50,33,15,69,57,37,16),c(59,46,31,15,64,56,33,16))
newdata<-newdata[,5:8] - newdata[,0:4]
colnames(newdata)<-colnames(life.data[,-5])
#
newdata<-data.frame(newdata)
predict(dis,newdata=newdata)

## => RESULT =>
$class
[1] 1 1
Levels: 1 2 3 4

$posterior
          1           2             3          4
1 0.9807523 0.005720613 3.604093e-130 0.01352713
2 0.5454961 0.059387509 7.751078e-168 0.39511636

$x
        LD1        LD2        LD3
1 -3.562779 -0.6443488 -0.9184824
2 -7.570186 -1.5280845  0.1528172




##### How he did it in class:
n<-length(life.data[,1])
wss1<-(n-1)*sum(apply(life.data,2,var))
wss<-numeric(0)
for(i in 2:6) {
  W<-sum(kmeans(life.data,i)$withinss)
  wss<-c(wss,W)
}

#
wss<-c(wss1,wss)
plot(2:6,wss,type="l",xlab="Number of groups",ylab="Within groups sum of squares",lwd=2)
#
life.kmeans<-kmeans(life.data,3)
life.kmeans
lapply(1:3,function(nc) apply(life[life.kmeans$cluster==nc,],2,mean))

# 3) From Table 7.1 (page 138, Chapter 7 Everitt)
tibet.data_with_clusters<-source(paste(getwd(), "/Data/chap7tibetskull.dat", sep = ""))$value
# (a) Perform a PCA and interpret the results
tibet.data <- tibet.data_with_clusters[,0:5]
cor(tibet.data)
tibet.princomp <- princomp(tibet.data, cor = TRUE)
summary(tibet.princomp, loadings = TRUE)

# (b) Find homogeneous clusters amongst the skulls. Compare the results with existing groups given by variable "Type"
# Calculate the within-group sum of squares for clustering factor 1
wss <- (nrow(tibet.data) - 1) * sum(apply(tibet.data, 2, var))

# Determine maximum number of clusters we will want
sqrt(nrow(life.data)) # => 5.6

# Calculate the within-group sum of squares for clustering factors 2 through 6
for (i in 2:6) wss[i] <- sum(kmeans(life.data, centers=i)$withinss)
plot(1:6, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")

# K-Means Cluster Analysis
fit <- kmeans(life.data, 4) # The graph indicates 4 is the right number of clusters
# Get cluster means
aggregate(life.data,by=list(fit$cluster),FUN=mean)
# Append cluster assignment
life.kmeans <- data.frame(life.data, fit$cluster)

# Cluster Plot against 1st 2 principal components
library(cluster)
clusplot(life.data, fit$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)



