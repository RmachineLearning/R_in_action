#R语言提供了3种底层对象类型，一种是S3类型，一种是S4类型，还有一种是RC类型。
#s3对象简单、具有动态性、结构化特征不明显 s4对象结构化、功能强大
#RC对象是2.12版本后使用的新类型，用于解决S3,S4很难实现的对象。

#######S3对象的介绍
#在R语言中，基于S3对象的面向对象编程，是一种基于泛型函数的实现方式。
#泛型函数是一种特殊的函数, 根据传入对象的类型决定调用哪个具体的方法。
#基于S3对象实现的面向对象编程，不同其他语言的面向对象编程，是一种动态函数调用的模拟实现。
#S3对象被广泛应用于R的早期的开发包中。

#创建S3对象
#为了方便我们检查对象的类型，引入pryr包作为辅助工具
setwd("E:/workspace/R/R in Action/面向对象设计")
#install.packages("pryr")
library(pryr)

#通过变量创建S3对象
x = 1
attr(x, 'class') = 'foo' #将x类型改为foo
class(x)
# 用pryr包的otype函数，检查x的类型
otype(x)

#通过structure()函数(base包中的函数)创建S3对象
y = structure(2, class = "foo")
y
class(y)
otype(y)

##################################
#创建一个多类型的S3对象
#S3对象没有明确结构关系，一个S3对象可以有多个类型, 
#S3对象的 class 属性可以是一个向量，包括多种类型。
x = 1
attr(x, 'class')  = c('foo', 'bar')
class(x)
otype(x)

########################################################
#3 泛型函数和方法调用

#对于S3对象的使用，通常用UseMethod()函数来定义一个泛型函数的名称，
#通过传入参数的class属性，来确定不同的方法调用。

#定义一个teacher的泛型函数
#+ 用UseMethod()定义teacher泛型函数
#+ 用teacher.xxx的语法格式定义teacher对象的行为
#+ 其中teacher.default是默认行为

# 用UseMethod()定义teacher泛型函数
teacher = function(x, ...) UseMethod("teacher")
#用pryr包中ftype()函数，检查teacher的类型
ftype(teacher)

#定义teacher内部函数, lecture就是对象teacher的属性
teacher.lecture = function(x) print('讲课')
teacher.assignment <- function(x) print("布置作业")
teacher.correcting <- function(x) print("批改作业")
teacher.default<-function(x) print("你不是teacher")

#######################################################
#方法调用时，通过传入参数的class属性，来确定不同的方法调用。

#1定义一个变量a，并设置a的class属性为lecture
#2把变量a，传入到teacher泛型函数中
#3函数teacher.lecture()函数的行为被调用

#把对象实例化给a
a = 'teacher'
#给老师变量设置行为
attr(a,'class')  =  'lecture' #把属性设置给实例对象a
otype(a)
# 执行老师的行为，对象teacher取得实例a中的属性，来执行老师a的行为
teacher(a)

#当然，我们也可以直接调用teacher中定义的行为，如果这样做了就失败了面向对象封装的意义。
teacher.lecture()
teacher.lecture(a)
teacher()

###############################################
#4 查看S3对象的函数
# 查看teacher对象
teacher
# 查看teacher对象的内部函数
methods(teacher)
#通过methods()的generic.function参数，来匹配泛型函数(predict)名字。
methods(generic.function=predict)

#通过methods()的class参数，来匹配类(lm)的名字。
methods(class=lm)

#用getAnywhere()函数，查看所有的函数。
# 查看teacher.lecture函数
getAnywhere(teacher.lecture)

# 查看不可见的函数predict.ppr
predict.ppr
# getAnywhere()函数查找predict.ppr
getAnywhere("predict.ppr")

#使用getS3method()函数，也同样可以查看不可见的函数
# getS3method()函数查找predict.ppr
getS3method("predict", "ppr")

##############################################
#5 S3对象的继承关系
#S3对象有一种非常简单的继承方式，用NextMethod()函数来实现。

#定义一个 node泛型函数
node <- function(x) UseMethod("node", x)
node.default <- function(x) "Default node"

# father函数
node.father <- function(x) c("father")

# son函数，通过NextMethod()函数指向father函数
node.son <- function(x) c("son", NextMethod())

# 定义n1
n1 <- structure(1, class = c("father"))
# 在node函数中传入n1，执行node.father()函数
node(n1)

# 定义n2，设置class属性为两个
n2 <- structure(1, class = c("son", "father"))
# 在node函数中传入n2，执行node.son()函数和node.father()函数
node(n2)

#通过对node()函数传入n2的参数，node.son()先被执行，然后通过NextMethod()函数继续执行了node.father()函数。
#这样其实就模拟了，子函数调用父函数的过程，实现了面向对象编程中的继承。


####
#6 S3对象的缺点

#从上面对S3对象的介绍来看，S3对象并不是完全的面向对象实现，而是一种通过泛型函数模拟的面向对象的实现。

#S3使用起来简单，但在实际的面向对象编程过程中，当对象关系有一定的复杂度，S3对象所表达的意义就会变得不太清楚。
#S3封装的内部函数，可绕过泛型函数的检查，以直接被调用。
#S3参数的class属性，可以被任意设置，没有预处理的检查。
#S3参数，只能通过调用class属性进行函数调用，其他属性则不会被class()函数执行。
#S3参数的class属性有多个值时，调用时会按照程序赋值顺序来调用第一个合法的函数。
#所以，S3只能R语言面向对象的一种简单的实现。

####


#7 S3对象的使用

#S3对象系统，被广泛地应用于R语言的早期开发中。在base包中，就有很多的S3对象。

#base包的S3对象
# mean函数
mean
ftype(mean)
# t函数
ftype(t)
ftype(plot)

#自定义的S3对象
# 定义数字型变量a
a <- 1
# 变量a的class为numeric
class(a)


# 定义泛型函数f1
f1 <- function(x) {
     a <- 2
     UseMethod("f1")
   }

# 定义f1的内部函数
> f1.numeric <- function(x) a

# 给f1()传入变量a
f1(a)

# 给f1()传入数字99
f1(99)


# 定义f1的内部函数
f1.character <- function(x) paste("char", x)

# 给f1()传入字符a
f1("a")


