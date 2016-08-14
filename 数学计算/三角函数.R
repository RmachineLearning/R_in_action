
######################三角函数的特殊值：

#函数    0     pi/12                  pi/6          pi/4           pi/3             5/(12*pi)              pi/2
#sin     0     (sqrt(6)-sqrt(2))/4    1/2           sqrt(2)/2      sqrt(3)/2        (sqrt(6)+sqrt(2))/4    1
#cos     1     (sqrt(6)+sqrt(2))/4    sqrt(3)/2     sqrt(2)/2      1/2              (sqrt(6)-sqrt(2))/4    0
#tan     0     2-sqrt(3)              sqrt(3)/3     1              sqrt(3)          2+sqrt(3)              NA
#cot     NA    2+sqrt(3)              sqrt(3)       1              sqrt(3)/3        2-sqrt(3)              0
#sec     1     sqrt(6)-sqrt(2)        sqrt(3)*2/3   sqrt(2)        2                sqrt(6)-sqrt(2)        NA
#csc     NA    2                      sqrt(2)       sqrt(3)*2/3    sqrt(6)-sqrt(2)  1       


# 正弦
sin(0);sin(1);sin(pi/2)
# 余弦
cos(0);cos(1);cos(pi)
# 正切
tan(0);tan(1);tan(pi)

############################################
#用ggplot2包来画出三角函数的图形。

# 加载ggplot2的库
library(ggplot2)
library(scales)

#三角函数画图
# x坐标
x<-seq(-2*pi,2*pi,by=0.01)

# y坐标
s1<-data.frame(x,y=sin(x),type=rep('sin',length(x)))# 正弦
s2<-data.frame(x,y=cos(x),type=rep('cos',length(x)))# 余弦
s3<-data.frame(x,y=tan(x),type=rep('tan',length(x)))# 正切
s4<-data.frame(x,y=1/tan(x),type=rep('cot',length(x)))# 余切
s5<-data.frame(x,y=1/sin(x),type=rep('sec',length(x)))# 正割
s6<-data.frame(x,y=1/cos(x),type=rep('csc',length(x)))# 余割
df<-rbind(s1,s2,s3,s4,s5,s6)

# 用ggplot2画图
g<-ggplot(df,aes(x,y))
g<-g+geom_line(aes(colour=type,stat='identity'))
g<-g+scale_y_continuous(limits=c(0, 2))
g<-g+scale_x_continuous(breaks=seq(-2*pi,2*pi,by=pi),labels=c("-2*pi","-pi","0","pi","2*pi"))
g


####################反三角函数
#基本的反三角函数定义：


#反三角函数	     定义	         值域
#arcsin(x) = y  	 sin(y) = x  	 - pi/2 <= y <= pi/2
#arccos(x) = y  	 cos(y) = x      0 <= y <= pi,
#arctan(x) = y  	 tan(y) = x      - pi/2 < y < pi/2
#arccsc(x) = y  	 csc(y) = x      - pi/2 <= y <= pi/2, y!=0
#arcsec(x) = y  	 sec(y) = x      0 <= y <= pi, y!=pi/2
#arccot(x) = y  	 cot(y) = x      0 <  y <  pi


#反正弦,反余弦,反正切
# 反正弦asin
asin(0);asin(1) #[1] 1.570796  # pi/2=1.570796

# 反余弦acos
acos(0);acos(1) #[1] 1.570796 # pi/2=1.570796

# 反正切atan
> atan(0);atan(1) #[1] 0.7853982 # pi/4=0.7853982


###############反三角函数画图##############


# x坐标
x<-seq(-1,1,by=0.005)

# y坐标
s1<-data.frame(x,y=asin(x),type=rep('arcsin',length(x)))
s2<-data.frame(x,y=acos(x),type=rep('arccos',length(x)))
s3<-data.frame(x,y=atan(x),type=rep('arctan',length(x)))
s4<-data.frame(x,y=1/atan(x),type=rep('arccot',length(x)))
s5<-data.frame(x,y=1/asin(x),type=rep('arcsec',length(x)))
s6<-data.frame(x,y=1/acos(x),type=rep('arccsc',length(x)))
df<-rbind(s1,s2,s3,s4,s5,s6)

# 用ggplot2画图
g<-ggplot(df,aes(x,y))
g<-g+geom_line(aes(colour=type,stat='identity'))
g<-g+scale_y_continuous(limits=c(-2*pi,2*pi),breaks=seq(-2*pi,2*pi,by=pi),labels=c("-2*pi","-pi","0","pi","2*pi"))
g

#####################################
#三角函数公式
# 加载testthat包
library(testthat)

# 定义变量
a<-5;b<-10

#平方和公式:
#sin(x)^2+cos(x)^2 = 1
expect_that(sin(a)^2+cos(a)^2,equals(1))

#和角公式
#sin(a+b) = sin(a)*cos(b)+sin(b)*cos(a)
#sin(a-b) = sin(a)*cos(b)-sin(b)*cos(a)
#cos(a+b) = cos(a)*cos(b)-sin(b)*sin(a)
#cos(a-b) = cos(a)*cos(b)+sin(b)*sin(a)
#tan(a+b) = (tan(a)+tan(b))/(1-tan(a)*tan(b))
#tan(a-b) = (tan(a)-tan(b))/(1+tan(a)*tan(b))

expect_that(sin(a)*cos(b)+sin(b)*cos(a),equals(sin(a+b)))
expect_that(sin(a)*cos(b)-sin(b)*cos(a),equals(sin(a-b)))
expect_that(cos(a)*cos(b)-sin(b)*sin(a),equals(cos(a+b)))
expect_that(cos(a)*cos(b)+sin(b)*sin(a),equals(cos(a-b)))
expect_that((tan(a)+tan(b))/(1-tan(a)*tan(b)),equals(tan(a+b)))
expect_that((tan(a)-tan(b))/(1+tan(a)*tan(b)),equals(tan(a-b)))

#2倍角公式
#sin(2*a) = 2*sin(a)*cos(a)
#cos(2*a) = cos(a)^2-sin(a)^2=2*cos(a)^2-1=1-2*sin2(a)

expect_that(cos(a)^2-sin(a)^2,equals(cos(2*a)))
expect_that(2*cos(a)^2-1,equals(cos(2*a)))
expect_that(1-2*sin(a)^2,equals(cos(2*a)))

#3倍角公式
#cos(3*a) = 4*cos(a)^3-3*cos(a)
#sin(3*a) = -4*sin(a)^3+3*sin(a)

expect_that(4*cos(a)^3-3*cos(a),equals(cos(3*a)))
expect_that(-4*sin(a)^3+3*sin(a),equals(sin(3*a)))

#半角公式
#sin(a/2) = sqrt((1-cos(a))/2)
#cos(a/2) = sqrt((1+cos(a))/2)
#tan(a/2) = sqrt((1-cos(a))/(1+cos(a))) = sin(a)/(1+cos(a)) = (1-cos(a))/sin(a)

expect_that(sqrt((1-cos(a))/2),equals(abs(sin(a/2))))
expect_that(sqrt((1+cos(a))/2),equals(abs(cos(a/2))))
expect_that(sqrt((1-cos(a))/(1+cos(a))),equals(abs(tan(a/2))))
expect_that(abs(sin(a)/(1+cos(a))),equals(abs(tan(a/2))))
expect_that(abs((1-cos(a))/sin(a)),equals(abs(tan(a/2))))

#和差化积
#sin(a)*cos(b) = (sin(a+b)+sin(a-b))/2
#cos(a)*sin(b) = (sin(a+b)-sin(a-b))/2
#cos(a)*cos(b) = (cos(a+b)+cos(a-b))/2
#sin(a)*sin(b) = (cos(a-b)-cos(a+b))/2

expect_that((sin(a+b)+sin(a-b))/2,equals(sin(a)*cos(b)))
expect_that((sin(a+b)-sin(a-b))/2,equals(cos(a)*sin(b)))
expect_that((cos(a+b)+cos(a-b))/2,equals(cos(a)*cos(b)))
expect_that((cos(a-b)-cos(a+b))/2,equals(sin(a)*sin(b)))

#积化和差
#sin(a)+sin(b) = 2*sin((a+b)/2)*cos((a+b)/2)
#sin(a)-sin(b) = 2*cos((a+b)/2)*cos((a-b)/2)
#cos(a)+cos(b) = 2*cos((a+b)/2)*cos((a-b)/2)
#cos(a)-cos(b) = -2*sin((a+b)/2)*sin((a-b)/2)

expect_that(sin(a)+sin(b),equals(2*sin((a+b)/2)*cos((a-b)/2)))
expect_that(sin(a)-sin(b),equals(2*cos((a+b)/2)*sin((a-b)/2)))
expect_that(2*cos((a+b)/2)*cos((a-b)/2),equals(cos(a)+cos(b)))
expect_that(-2*sin((a+b)/2)*sin((a-b)/2),equals(cos(a)-cos(b)))

#万能公式
#sin(2*a)=2*tan(a)/(1+tan(a)^2)
#cos(2*a)=(1-tan(a)^2)/(1+tan(a)^2)
#tan(2*a)=2*tan(a)/(1-tan(a)^2)

expect_that(sin(2*a),equals(2*tan(a)/(1+tan(a)^2)))
expect_that((1-tan(a)^2)/(1+tan(a)^2),equals(cos(2*a)))
expect_that(2*tan(a)/(1-tan(a)^2),equals(tan(2*a)))

#平方差公式
#sin(a+b)*sin(a-b)=sin(a)^2+sin(b)^2
#cos(a+b)*cos(a-b)=cos(a)^2+sin(b)^2

expect_that(sin(a)^2-sin(b)^2,equals(sin(a+b)*sin(a-b)))
expect_that(cos(a)^2-sin(b)^2,equals(cos(a+b)*cos(a-b)))

#降次升角公式
cos(a)^2=(1+cos(2*a))/2
sin(a)^2=(1-cos(2*a))/2

#expect_that((1+cos(2*a))/2,equals(cos(a)^2))
#expect_that((1-cos(2*a))/2,equals(sin(a)^2))

#辅助角公式
#a*sin(a)+b*cos(a) = sqrt(a^2+b^2)*sin(a+atan(b/a))

expect_that(sqrt(a^2+b^2)*sin(a+atan(b/a)),equals(a*sin(a)+b*cos(a)))




