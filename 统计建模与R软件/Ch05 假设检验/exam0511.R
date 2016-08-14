#### 输入数据
X<-0:6; Y<-c(7, 10, 12, 8, 3, 2, 0)
#### 计算理论分布, 其中mean(rep(X,Y))为样本均值
q<-ppois(X, mean(rep(X,Y))); n<-length(Y) 
p<-numeric(n); p[1]<-q[1]; p[n]<-1-q[n-1]
for (i in 2:(n-1))
   p[i]<-q[i]-q[i-1]
#### 作检验
chisq.test(Y,p=p)

#### 重新分组
Z<-c(7, 10, 12, 8, 5)
#### 重新计算理论分布
n<-length(Z); p<-p[1:n-1]; p[n]<-1-q[n-1]
#### 作检验
chisq.test(Z,p=p)

