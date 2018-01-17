headsize<-source("c:\\allwork\\rsplus\\chap8headsize.dat")$value
#
headsize.std<-sweep(headsize,2,sqrt(apply(headsize,2,var)),FUN="/")
#
#
headsize1<-headsize.std[,1:2]
headsize2<-headsize.std[,3:4]
r11<-cor(headsize1)
r22<-cor(headsize2)
r12<-c(cor(headsize1[,1],headsize2[,1]),cor(headsize1[,1],headsize2[,2]),
cor(headsize1[,2],headsize2[,1]),cor(headsize1[,2],headsize2[,2]))
#
r12<-matrix(r12,ncol=2,byrow=T)
r21<-t(r12)
#
R1<-solve(r11)%*%r12%*%solve(r22)%*%r21
R2<-solve(r22)%*%r21%*%solve(r11)%*%r12
R1
R2
#
eigen(R1)
eigen(R2)
#
sqrt(eigen(R1)$values)

#
girth1<-0.69*headsize.std[,1]+0.72*headsize.std[,2]
girth2<-0.74*headsize.std[,3]+0.67*headsize.std[,4]
shape1<-0.71*headsize.std[,1]-0.71*headsize.std[,2]
shape2<-0.70*headsize.std[,3]-0.71*headsize.std[,4]
cor(girth1,girth2)
cor(shape1,shape2)
#
par(mfrow=c(1,2))
plot(girth1,girth2)
plot(shape1,shape2)
#
#
#
r22<-matrix(c(1.0,0.044,-0.106,-0.180,0.044,1.0,-0.208,-0.192,-0.106,-0.208,1.0,0.492,
-0.180,-0.192,0.492,1.0),ncol=4,byrow=T)
r11<-matrix(c(1.0,0.212,0.212,1.0),ncol=2,byrow=2)
r12<-matrix(c(0.124,-0.164,-0.101,-0.158,0.098,0.308,-0.270,-0.183),ncol=4,byrow=T)
r21<-t(r12)
#
E1<-solve(r11)%*%r12%*%solve(r22)%*%r21
E2<-solve(r22)%*%r21%*%solve(r11)%*%r12
#
E1
E2
#
eigen(E1)
eigen(E2)



