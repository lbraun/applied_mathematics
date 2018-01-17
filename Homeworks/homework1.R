#
usair.dat<-source(paste(getwd(), "/Data/chap3usair.dat", sep = ""))$value


panel.hist <- function(x, ...)
{
   usr <- par("usr"); on.exit(par(usr))
   par(usr = c(usr[1:2], 0, 1.5) )
   h <- hist(x, plot = FALSE)
   breaks <- h$breaks; nB <- length(breaks)
   y <- h$counts; y <- y/max(y)
   rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}

pairs(usair.dat,panel=function(x,y) {abline(lsfit(x,y)$coef,lwd=2)
                                     lines(lowess(x,y),lty=2,lwd=2)
                                     points(x,y)}, diag.panel=panel.hist)


####

attach(usair.dat)
plot(Manuf, SO2)
abline(lsfit(Manuf, SO2), lwd=2)
abline(lines(lowess(Manuf, SO2), lty=2, lwd=2))

####

chiplot(Manuf, SO2, vlabs=c("SO2", "Manufacturing"))
# chiplot(Manuf, Pop, vlabs=c("Population", "Manufacturing"))

####

# Get functions
source(paste(getwd(), "/functions.txt", sep=""))
bvbox(cbind(Manuf, SO2), xlab="Manufacturing", ylab="SO2")
# bvbox(cbind(Manuf, Pop), xlab="Manufacturing", ylab="SO2")

####

coplot(Manuf~SO2|Days)

#### Euclidian distances
# Original data
dis<-dist(usair.dat)
dis.matrix<-dist2full(dis) # Function dist2full is defined at the bottom of this file
round(dis.matrix,digits=2)

# Normalized data
usair.dat <- data.matrix(usair.dat)
std<-sd(usair.dat)
usair.dat.std<-sweep(usair.dat,2,std,FUN="/")
dis<-dist(usair.dat.std)
dis.matrix<-dist2full(dis)
round(dis.matrix,digits=2)

# Mahalobis
Sx <- cov(usair.dat)
mdis <- mahalanobis(usair.dat, colMeans(usair.dat), Sx)


#### Q-Q Plot
qqnorm(usair.dat[,1],ylab="Ordered observations of SO2")
qqline(usair.dat[,1])
dev.copy(png,'3.1.SO2_Neg.Temp.png')
dev.off()

qqnorm(usair.dat[,2],ylab="Ordered observations of Neg.Temp")
qqline(usair.dat[,2])
dev.copy(png,'3.2.SO2_Manuf.png')
dev.off()

qqnorm(usair.dat[,3],ylab="Ordered observations of Manuf")
qqline(usair.dat[,3])
dev.copy(png,'3.3.SO2_Neg.Temp.png')
dev.off()

qqnorm(usair.dat[,4],ylab="Ordered observations of Pop")
qqline(usair.dat[,4])
dev.copy(png,'3.4.SO2_Neg.Temp.png')
dev.off()

qqnorm(usair.dat[,5],ylab="Ordered observations of Wind")
qqline(usair.dat[,5])
dev.copy(png,'3.5.SO2_Neg.Temp.png')
dev.off()

qqnorm(usair.dat[,6],ylab="Ordered observations of Precip")
qqline(usair.dat[,6])
dev.copy(png,'3.6.SO2_Neg.Temp.png')
dev.off()

qqnorm(usair.dat[,7],ylab="Ordered observations of Days")
qqline(usair.dat[,7])
dev.copy(png,'3.7.SO2_Neg.Temp.png')
dev.off()


#### 2.6 Chiplot
chiplot(SO2, Neg.Temp, vlabs=c("SO2", "Neg.Temp"))
dev.copy(png,'4.1.SO2_Neg.Temp.png')
dev.off()
chiplot(SO2, Manuf, vlabs=c("SO2", "Manuf"))
dev.copy(png,'4.2.SO2_Manuf.png')
dev.off()
chiplot(SO2, Pop, vlabs=c("SO2", "Pop"))
dev.copy(png,'4.3.SO2_Pop.png')
dev.off()
chiplot(SO2, Wind, vlabs=c("SO2", "Wind"))
dev.copy(png,'4.4.SO2_Wind.png')
dev.off()
chiplot(SO2, Precip, vlabs=c("SO2", "Precip"))
dev.copy(png,'4.5.SO2_Precip.png')
dev.off()
chiplot(SO2, Days, vlabs=c("SO2", "Days"))
dev.copy(png,'4.6.SO2_Days.png')
dev.off()

chiplot(Neg.Temp, Manuf, vlabs=c("Neg.Temp", "Manuf"))
dev.copy(png,'4.7.Neg.Temp_Manuf.png')
dev.off()
chiplot(Neg.Temp, Pop, vlabs=c("Neg.Temp", "Pop"))
dev.copy(png,'4.8.Neg.Temp_Pop.png')
dev.off()
chiplot(Neg.Temp, Wind, vlabs=c("Neg.Temp", "Wind"))
dev.copy(png,'4.9.Neg.Temp_Wind.png')
dev.off()
chiplot(Neg.Temp, Precip, vlabs=c("Neg.Temp", "Precip"))
dev.copy(png,'4.10.Neg.Temp_Precip.png')
dev.off()
chiplot(Neg.Temp, Days, vlabs=c("Neg.Temp", "Days"))
dev.copy(png,'4.11.Neg.Temp_Days.png')
dev.off()

chiplot(Manuf, Pop, vlabs=c("Manuf", "Pop"))
dev.copy(png,'4.12.Manuf_Pop.png')
dev.off()
chiplot(Manuf, Wind, vlabs=c("Manuf", "Wind"))
dev.copy(png,'4.13.Manuf_Wind.png')
dev.off()
chiplot(Manuf, Precip, vlabs=c("Manuf", "Precip"))
dev.copy(png,'4.14.Manuf_Precip.png')
dev.off()
chiplot(Manuf, Days, vlabs=c("Manuf", "Days"))
dev.copy(png,'4.15.Manuf_Days.png')
dev.off()

chiplot(Pop, Wind, vlabs=c("Pop", "Wind"))
dev.copy(png,'4.16.Pop_Wind.png')
dev.off()
chiplot(Pop, Precip, vlabs=c("Pop", "Precip"))
dev.copy(png,'4.17.Pop_Precip.png')
dev.off()
chiplot(Pop, Days, vlabs=c("Pop", "Days"))
dev.copy(png,'4.18.Pop_Days.png')
dev.off()

chiplot(Wind, Precip, vlabs=c("Wind", "Precip"))
dev.copy(png,'4.19.Wind_Precip.png')
dev.off()
chiplot(Wind, Days, vlabs=c("Wind", "Days"))
dev.copy(png,'4.20.Wind_Days.png')
dev.off()

chiplot(Precip, Days, vlabs=c("Precip", "Days"))
dev.copy(png,'4.21.Precip_Days.png')
dev.off()

#
#
#
#
var(usair.dat)
cor(usair.dat)
#
#
dis<-dist(usair.dat)
dis.matrix<-dist2full(dis) # Function dist2full is defined at the bottom of this file
round(dis.matrix,digits=2)
#
usair.dat <- data.matrix(usair.dat)
std<-sd(usair.dat)
# Error: (list) object cannot be coerced to type 'double'
# Solutions:
std<-sd(data.matrix(usair.dat)) # Doesn't work
std=c(sd(usair.dat[,1]), sd(usair.dat[,2]), sd(usair.dat[,3]), sd(usair.dat[,4]), sd(usair.dat[,5]), sd(usair.dat[,6]), sd(usair.dat[,7]))
#
#
# sweep usage: sweep(x, MARGIN, STATS, FUN = "-", check.margin = TRUE, …)
# Divide columns of data matrix by the appropriate standard deviation to normalize the data
usair.dat.std<-sweep(usair.dat,2,std,FUN="/")
dis<-dist(usair.dat.std)
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
