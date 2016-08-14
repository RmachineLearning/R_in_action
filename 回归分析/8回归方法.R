setwd("/media/zhoutao/软件盘/workspace/R/Data for An Introduction to Statistical Learning with Applications in R ")

#############回归方法
#1 线性模型
##1 收集数据

##2 探索数据
data('longley')
str(longley)
summary(longley[-6])
table(longley[6])
  #1 做回归要探索 特征之间的关系 —— 相关系数矩阵
cor(longley[-6])
  #2 可视化特征之间的关系——散点图
pairs(longley[-6])
#install.packages('psych') 能产生更丰富的散点矩阵图
library(psych)
pairs.panels(longley[-6])



##3 基于 数据训练模型
#lm在stats包中, lm可以对是因子的自变量(虚拟变量)自动添加求解

fm1 <- lm(Employed ~ ., data = train_longley)
#4 预测
predict(fm1, test_longley)

#5 性能评估
summary(fm1)

#6 提高性能
  #1 添加非线性关系
longley$Unemployed2 = longley$Unemployed^2

  #2转换 将一个数值型变量转换为一个二进制指标
longley$GNP_100 = ifelse(longley$GNP >= 100, 1, 0)

  #3 加入交互效应
formulor = GNP + Unemploy + GNP:Unemploy