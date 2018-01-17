#
huswif<-source("/Users/lucasbraun/Google Drive/Grad School/2017 Applied Mathematics/RSPCMA/Data/chap1huswif.dat")$value
#
#
mean(huswif)
sd(huswif)^2
#
#
var(huswif)
cor(huswif)
#
#
dis<-dist(huswif)
dis.matrix<-dist2full(dis)
round(dis.matrix,digits=2)
#
std<-sd(huswif)
# Error: (list) object cannot be coerced to type 'double'
# Solutions:
std<-sd(data.matrix(huswif))
std=c(sd(huswif[,1]), sd(huswif[,2]), sd(huswif[,3]), sd(huswif[,4]), sd(huswif[,5]))
#
#
# sweep usage: sweep(x, MARGIN, STATS, FUN = "-", check.margin = TRUE, …)
huswif.std<-sweep(huswif,2,std,FUN="/")
dis<-dist(huswif.std)
dis.matrix<-dist2full(dis)
round(dis.matrix,digits=2)
#
#load MASS library
library(MASS)
#set seed for random number generation to get the same plots
set.seed(1203)
X<-mvrnorm(200,mu=c(0,0),Sigma=matrix(c(1,0.5,0.5,1.0),ncol=2))
#
#
par(mfrow=c(1,2))
qqnorm(X[,1],ylab="Ordered observations")
qqline(X[,1])
qqnorm(X[,2],ylab="Ordered observations")
qqline(X[,2])
#
#
par(mfrow=c(1,1))
chisplot(X)
#
par(mfrow=c(1,2))
qqnorm(log(abs(X[,1])),ylab="Ordered observations")
qqline(log(abs(X[,1])))
qqnorm(log(abs(X[,2])),ylab="Ordered observations")
qqline(log(abs(X[,2])))
#
par(mfrow=c(1,1))
chisplot(log(abs(X)))
#
dist2full<-function(dis) {
	n<-attr(dis,"Size")
	full<-matrix(0,n,n)
	full[lower.tri(full)]<-dis
	full+t(full)
}
