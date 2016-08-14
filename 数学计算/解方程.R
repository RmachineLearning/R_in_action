
##################################
#4 方程计算

#方程计算是数学计算的一种基本形式，R语言也可以很方便地帮助我们解方程，下面将介绍一元多次的方程，和二元一次方程的解法。

###############################################
#解一元多次方程，可以用uniroot()函数！

#4.1 一元一次方程
#一元一次方程：a*x+b=0，设a=5，b=10，求x？
# 定义方程函数
f1 <- function (x, a, b) a*x+b
# 给a,b常数赋值
a<-5;b<-10

# 在(-10,10)的区间，精确度为0.0001位，计算方程的根
result <- uniroot(f1,c(-10,10),a=a,b=b,tol=0.0001)

# 打印方程的根x
result$root  # [1] -2
#一元一次方程非常容易解得，方程的根是-2！

#以图形展示方程：y = 5*x + 10
# 创建数据点
x<-seq(-5,5,by=0.01)
y<-f1(x,a,b)
df<-data.frame(x,y)

# 用ggplot2来画图
g<-ggplot(df,aes(x,y))
g<-g+geom_line(col='red') #红色直线
g<-g+geom_point(aes(result$root,0),col="red",size=3) #点
g<-g+geom_hline(yintercept=0)+geom_vline(yintercept=0) #坐标轴
g<-g+ggtitle(paste("y =",a,"* x +",b))
g


#############################################
#4.2 一元二次方程
#一元二次方程：a*x^2+b*x+c=0，设a=1，b=5，c=6，求x？
f2 <- function (x, a, b, c) a*x^2+b*x+c
a<-1;b<-5;c<-6
result <- uniroot(f2,c(0,-2),a=a,b=b,c=c,tol=0.0001)
result$root  #[1] -2

 #把参数带入方程，用uniroot()函数，我们就解出了方程的一个根，改变计算的区间，我们就可以得到另一个根。
result <- uniroot(f2,c(-4,-3),a=a,b=b,c=c,tol=0.0001)
result$root #[1] -3
#方程的两个根，一个是-2，一个是-3。

#由于uniroot()函数，每次只能计算一个根，而且要求输入的区间端值，必须是正负号相反的。如果我们直接输入一个(-10,0)这个区间，那么uniroot()函数会出现错误。
#result <- uniroot(f2,c(-10,0),a=a,b=b,c=c,tol=0.0001)
Error in uniroot(f2, c(-10, 0), a = a, b = b, c = c, tol = 1e-04) : 
#  位于极点边的f()值之正负号不相反
#这应该是uniroot()为了统计计算对一元多次方程而设计的，所以为了使用uniroot()函数，我们需要取不同的区别来获得方程的根。

#以图形展示方程：y = x^2 + 5*x + 6


# 创建数据点
x<-seq(-5,1,by=0.01)
y<-f2(x,a,b,c)
df<-data.frame(x,y)

# 用ggplot2来画图
g<-ggplot(df,aes(x,y))
g<-g+geom_line(col='red') #红色曲线
g<-g+geom_hline(yintercept=0)+geom_vline(yintercept=0) #坐标轴
g<-g+ggtitle(paste("y =",a,"* x ^ 2 +",b,"* x +",c))
g


#我们从图，并直接的看到了x的两个根取值范围。

#######################################
#4.3 一元三次方程

#一元二次方程：a*x^3+b*x^2+c*x+d=0，设a=1，b=5，c=6，d=-11，求x？


f3 <- function (x, a, b, c,d) a*x^3+b*x^2+c*x+d
a<-1;b<-5;c<-6;d<--11
result <- uniroot(f3,c(-5,5),a=a,b=b,c=c,d=d,tol=0.0001)
result$root #[1] 0.9461458
#如果我们设置对了取值区间，那么一下就得到了方程的根。

#以图形展示方程：y = x^2 + 5*x + 6
# 创建数据点
x<-seq(-5,5,by=0.01)
y<-f3(x,a,b,c,d)
df<-data.frame(x,y)

# 用ggplot2画图
g<-ggplot(df,aes(x,y))
g<-g+geom_line(col='red') # 3次曲线
g<-g+geom_hline(yintercept=0)+geom_vline(yintercept=0) #坐标轴
g<-g+ggtitle(paste("y =",a,"* x ^ 3 +",b,"* x ^2 +",c,"* x + ",d))
g

######################################################
#4.4 二元一次方程组
#R语言还可以解二次的方程组，当然计算方法，其实是利用于矩阵计算。
#假设方程组：是以x1,x2两个变量组成的方程组，求x1,x2的值
# 3 * x1 + 5 * x2 = 4 
#     x1 + 2 * x2 = 1
#构建矩阵形式
# 左矩阵
lf<-matrix(c(3,5,1,2),nrow=2,byrow=TRUE)
# 右矩阵
rf<-matrix(c(4,1),nrow=2)
# 计算结果
result<-solve(lf,rf)
result

#接下来，我们画出这两个线性方程的图。设y=X2, x=X1，把原方程组变成两个函数形式。
# 定义2个函数
fy1<-function(x) (-3*x+4)/5
fy2<-function(x) (-1*x+1)/2

# 定义数据
x<-seq(-1,4,by=0.01)
y1<-fy1(x)
y2<-fy2(x)
dy1<-data.frame(x,y=y1,type=paste("y=(-3*x+4)/5"))
dy2<-data.frame(x,y=y2,type=paste("y=(-1*x+1)/2"))
df <- rbind(dy1,dy2)

# 用ggplot2画图
g<-ggplot(df,aes(x,y))
g<-g+geom_line(aes(colour=type,stat='identity')) #2条直线
g<-g+geom_hline(yintercept=0)+geom_vline(yintercept=0) #坐标轴
g



##########################################################
#3. 二阶导数计算
#当我们对一个函数进行多次接连的求导计算，会形成高阶导数。
a<-2                 # 设置a的值
dx<-deriv(y~sin(a*x),"x",func = TRUE) # 生成一阶导数公式
dx(pi/3)                              # 计算一阶导数
#[1] 0.8660254
#attr(,"gradient")
#x
#[1,] -1     # 导函数计算结果y'= a*cos(a*x)=2*cos(2*pi/3)=-1

dx<-deriv(y~a*cos(a*x),"x",func = TRUE)    # 对一阶导函数求导
#dx(pi/3)
#[1] -1
#attr(,"gradient")
#x
#[1,] -3.464102     # 导函数计算结果y'= -a^2*sin(a*x)=-2^2*sin(2*pi/3)=-3.464102

#上面二阶导数的计算，我们是动手划分为两次求导进行计算的，利用deriv3()函数其实合并成一步计算。
dx<-deriv3(y~sin(a*x),"x",func = TRUE)  # 生成二阶导数公式
dx(pi/3)                                # 计算导数
#[1] 0.8660254
#attr(,"gradient")
#x
#[1,] -1         # 一阶导数结果
#attr(,"hessian")
#, , x
#x
#[1,] -3.464102  # 二阶导数结果

#我们再计算另外一个二阶导数，计算y=a*x^4+b*x^3+x^2+x+c，其中a,b,c为常数a=2,b=1,c=3，
dx<-deriv3(y~a*x^4+b*x^3+x^2+x+c,"x",func=function(x,a=2,b=1,c=3){})  # 通过func参数，指定常数值
dx(2)
#[1] 49
#attr(,"gradient")
#x
#[1,] 81           # 一阶导数结果
#attr(,"hessian")
#, , x
#x
#[1,] 110          # 二阶导数结果


#####################################################################
#4偏导数计算

#在数学中，一个多变量的函数的偏导数，就是它关于其中一个变量的导数而保持其他变量恒定（相对于全导数，在其中所有变量都允许变化）。
#偏导数的算子符号为:∂。记作∂f/∂x 或者 f’x。偏导数反映的是函数沿坐标轴正方向的变化率，在向量分析和微分几何中是很有用的。
#在xOy平面内，当动点由P(x0,y0)沿不同方向变化时，函数f(x,y)的变化快慢一般说来是不同的，因此就需要研究f(x,y)在(x0,y0)点处沿不同方向的变化率。在这里我们只学习函数f(x,y)在x0y平面沿着平行于x0y轴和平行于y轴两个特殊方位变动时，f(x,y)的变化率。

#x方向的偏导：
#设有二元函数z=f(x,y)，点(x0,y0)是其定义域D内一点.把y固定在y0而让x在x0有增量△x，相应地函数z=f(x,y)有增量(称为对x的偏增量)△z=f(x0+△x,y0)-f(x0,y0)。如果△z与△x之比当△x→0时的极限存在，那么此极限值称为函数z=f(x,y)在(x0,y0)处对x的偏导数(partial derivative)。记作f’x(x0,y0)。

#y方向的偏导：
#函数z=f(x,y)在(x0,y0)处对x的偏导数，实际上就是把y固定在y0看成常数后，一元函数z=f(x,y0)在x0处的导数。同样，把x固定在x0,让y有增量△y,如果极限存在那么此极限称为函数z=(x,y)在(x0,y0)处对y的偏导数。记作f’y(x0,y0)
#同样地，我们可以通过R语言的 deriv()函数进行偏导数的计算。下面我们计算一个二元函数f(x,y)=2*x^2+y+3*x*y^2的偏导数，由于二元函数曲面上每一点都有无穷多条切线，描述这个函数的导数就会相当困难。如果让其中的一个变量y取值为常数，那么就可以求出关于另一个自变量x的偏导数了，即∂f/∂x。
#下面我们分别对x,y两个自变量求偏导数，设变量y为常数，计算x的偏导数∂f/∂x=4*x+3*y^2，当x=1,y=1时，x的偏导数∂f/∂x=4*x+3*y^2=7。设变量x为常数，计算y的偏导数∂f/∂y=1+6*x*y，当x=1,y=1时，y的偏导数∂f/∂x=1+6*x*y=7。


fxy = expression(2*x^2+y+3*x*y^2)     # 二元函数公式
dxy = deriv(fxy, c("x", "y"), func = TRUE)
dxy

dxy(1,1)                          # 设置自变量
#[1] 6
#attr(,"gradient")
#x y                            # 计算结果，x的偏导数为7，y的偏导数为7
#[1,] 7 7


#计算一个二元函数f(x,y)=x^y + exp(x * y) + x^2 – 2 * x * y + y^3 + sin(x*y)在点(1,3)和点(0,0)的偏导数。
fxy = expression(x^y + exp(x * y) + x^2 - 2 * x * y + y^3 + sin(x*y))
dxy = deriv(fxy, c("x", "y"), func = TRUE)
dxy(1,3)        # 设置自变量
#[1] 43.22666
#attr(,"gradient")
#x        y
#[1,] 56.28663 44.09554        # 计算结果，x的偏导数为56.28663，y的偏导数为 44.09554
dxy(0,0)
#[1] 2
#attr(,"gradient")
#x    y
#[1,] NaN -Inf                 # 计算结果，x的偏导数无意义，y的偏导数负无穷大
















