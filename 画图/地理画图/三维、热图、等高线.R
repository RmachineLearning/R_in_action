library(nutshell)
data(yosemite)
#是矩阵
class(yosemite)
#双精度
typeof(yosemite)
dim(yosemite)
head(yosemite)

#选择一部分海拔点
rightmost = yosemite[(nrow(yosemite) - ncol(yosemite) + 1) : 562, seq(from = 253, to = 1)]
#图片旋转 225°（theta = 225）；视角该为20°(phi = 20)
#光源调整45°(ltheta = 45); 阴影参数设为0.75（shade = 0.75）
persp(rightmost, col = grey(0.25), border = NA, expand = 0.15, 
      theta = 225, phi = 20, ltheta = 45, lphi = 20, shade = 0.75)

#三维显示，把矩阵中的数据点画成一个个格子，格子的颜色对应矩阵中相应元素的值
#asp = 253/562设置长宽比，使其能与数据匹配，该参数是传递给par的标准图形参数
#ylim=c(1,0) 保证数据是从上到下绘制
#col = sapply((0:32)/32, gray)设置32阶灰度颜色
image(yosemite, asp = 253/562, ylim=c(1,0), col = sapply((0:32)/32, gray))

#热图heatmap
heatmap(yosemite)

#等高线图contour
contour(yosemite, asp = 253/562, ylim=c(1,0))

