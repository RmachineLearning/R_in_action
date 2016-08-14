####################################
#3 复数计算
#复数，为实数的延伸，它使任一多项式都有根。复数中的虚数单位i，是-1的一个平方根，即i^2 = -1。任一复数都可表达为x + yi，其中x及y皆为实数，分别称为复数之“实部”和“虚部”。

#3.1 创建一个复数
# 直接创建复数
ai<-5+2i;ai  #[1] 5+2i
 class(ai) #[1] "complex"

# 通过complex()函数创建复数
bi<-complex(real=5,imaginary=2);bi
#[1] 5+2i
is.complex(bi)
#[1] TRUE

# 实数部分
Re(ai)
#[1] 5

# 虚数部分
Im(ai)
#[1] 2

# 取模
 Mod(ai)
#[1] 5.385165 # sqrt(5^2+2^2) = 5.385165

# 取辐角
Arg(ai)
#[1] 0.3805064

# 取轭
#Conj(ai)
#[1] 5-2i

########################################
3.2 复数四则运算

#加法公式：(a+bi)+(c+di) = (a+c)+(b+d)i
#减法公式：(a+bi)-(c+di)= (a-c)+(b-d)i
#乘法公式：(a+bi)(c+di) = ac+adi+bci+bidi=ac+bdi^2+(ad+bc)i=(ac-bd)+(ad+bc)i
#除法公式：(a+bi)/(c+di) = ((ac+bd)+(bc-ad)i)/(c^2+d^2)

# 定义系数
a<-5;b<-2;c<-3;d<-4

# 创建两个复数
ai<-complex(real=a,imaginary=b)
bi<-complex(real=c,imaginary=d)

expect_that(complex(real=(a+c),imaginary=(b+d)),equals(ai+bi))
expect_that(complex(real=(a-c),imaginary=(b-d)),equals(ai-bi))
expect_that(complex(real=(a*c-b*d),imaginary=(a*d+b*c)),equals(ai*bi))
expect_that(complex(real=(a*c+b*d),imaginary=(b*c-a*d))/(c^2+d^2),equals(ai/bi))

######################
#3.3 复数开平方根
# 在实数域，给-9开平方根
sqrt(-9)
#[1] NaN

# 在复数域，给-9开平方根
sqrt(complex(real=-9))
#[1] 0+3i


















