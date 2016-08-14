#横向合并
authors <- data.frame(
  surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  deceased = c("yes", rep("no", 4)))

books <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics ...",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis",
            "An Introduction to R"),
  other.author = c(NA, "Ripley", NA, NA, NA, NA,
                   "Venables & Smith"))

(m1 <- merge(authors, books, by.x = "surname", by.y = "name"))
(m2 <- merge(books, authors, by.x = "name", by.y = "surname"))

#一维数组间的相关操作
x = c(1,2,2,3,5,5,4)
y = c(2,3,3,5,6,5)
union(x,y) #合并两个一维数组，把重复值删除
c(x,y)
intersect(x,y)#提取两个数组中相同的值，并把重复的值删除
setdiff(x,y)#显示第一个一维数组有，但第二个数组无，的唯一值
setdiff(y,x)
setequal(x,y)#两个数组是否一样
is.element(x,y)#第一个数组的值是否在第二个一维数组中
x%in%y #与is.element(x,y)等价
#x中的元素与y中第几个元素匹配，返回的结果是与y相匹配的y的元素中的位置
match(x,y)
