###########R的数学计算
#基本计算
#三角函数计算
#复数计算
#方程计算


#数学计算: 幂, 自然常用e的幂, 平方根, 对数
a<-10;b<-5;c<-4
# 幂
c^b;c^-b;c^(b/10)
# 自然常数e
exp(1)
# 平方根
sqrt(c)
# 以2为底的对数
log2(c)
# 以10为底的对数
log10(b)
# 自定义底的对数
log(c,base = 2)
# 自然常数e的对数
log(a,base=exp(1))
# 指数对数操作
log(a^b,base=a)
log(exp(3))

############################
#比较计算: ==, >, <, !=, <=, >=, isTRUE, identical
a<-10;b<-5

# 比较计算
a==a;a!=b;a>b;a=c

# 判断是否为TRUE
isTRUE(a)
# 精确比较两个对象
identical(1, as.integer(1))
identical(NaN, -NaN)

f <- function(x) x
g <- compiler::cmpfun(f)
identical(f, g)

#####################################################
#逻辑计算： &, |, &&, ||, xor
x<-c(0,1,0,1)
y<-c(0,0,1,1)
# 只比较第一个元素 &&, ||
x && y;x || y
# S4对象的逻辑运算，比较所有元素 &, |
x & y;x | y

# 异或
xor(x,y)
xor(x,!y)
#约数计算： ceiling,floor,trunc,round,signif
# 向上取整
ceiling(5.4) #[1] 6
# 向下取整
floor(5.8) #[1] 5
# 取整数
trunc(3.9) #[1] 3

# 四舍五入 
round(5.8)
# 四舍五入,保留2位小数
round(5.8833, 2) #[1] 5.88
# 四舍五入,保留前2位整数
signif(5990000,2) #[1] 6e+06


##############################
#数组计算： 最大, 最小, 范围, 求和, 均值, 加权平均, 连乘, 差分, 秩，,中位数, 分位数, 任意数，全体数
d<-seq(1,10,2);d

# 求最大值，最小值,范围range
max(d);min(d);range(d)
# 求和,均值
sum(d);mean(d)
# 加权平均
weighted.mean(d,rep(1,5))
weighted.mean(d,c(1,1,2,2,2))
# 连乘
prod(1:5)
# 差分
diff(d)
# 秩
rank(d)
# 中位数
median(d)
# 分位数
quantile(d)
# 任意any，全体all
e<-seq(-3,3);e

any(e<0);all(e<0)

######################################
#排列组合计算: 阶乘, 组合, 排列

# 5!阶乘
factorial(5)
# 组合, 从5个中选出2个
choose(5, 2)

# 列出从5个中选出2个的组合所有项
combn(5,2)

# 计算0:10的组合个数
for (n in 0:10) print(choose(n, k = 0:n))


# 排列，从5个中选出2个
choose(5, 2)*factorial(2)

############################################
#累积计算: 累加, 累乘, 最小累积, 最大累积

# 累加
cumsum(1:5)
# 累乘
cumprod(1:5)
e<-seq(-3,3);e
# 最小累积cummin
cummin(e)

# 最大累积cummax
 cummax(e)

####################### 
#两个数组计算: 交集, 并集, 差集, 数组是否相等, 取唯一, 查匹配元素的索引, 找重复元素索引

# 定义两个数组向量
x <- c(9:20, 1:5, 3:7, 0:8);x
y<- 1:10;y

# 交集
intersect(x,y)
# 并集
union(x,y)
# 差集，从x中排除y
setdiff(x,y)
# 判断是否相等
setequal(x, y)
# 取唯一
unique(c(x,y))


# 找到x在y中存在的元素的索引
which(x %in% y)
which(is.element(x,y))
# 找到重复元素的索引
which(duplicated(x))










