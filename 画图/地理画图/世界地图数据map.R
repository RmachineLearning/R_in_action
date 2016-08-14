#从maps中获取地图数据
library(maps)
#map_data来着包ggplot2，用来取得maps包中map里面保存的各国地理数据
library(ggplot2)
states_map <-  map_data("state" )
#得到的是一个数据框结构
class(states_map)
str(states_map)
#region：地区的名字
#order：在一组里面每个点的连接顺序
#subregion 一个区域中子区域的名字
head(states_map)
#geom_polygon()可用颜色填充；fill填充颜色，colour边界线条颜色
ggplot(states_map,  aes(x=long,  y=lat,  group=group)) +
  geom_polygon(fill="white" ,  colour="black" )

# geom_path(不能填充)绘制；
#coord_map("mercator")指定一个投影，默认投影"mercator"（墨卡托投影）和直角坐标系不同
#墨卡托投影钟纬度线之间的距离会逐渐发生变化
ggplot(states_map,  aes(x=long,  y=lat,  group=group)) +
  geom_path() + coord_map("mercator")


########################################################
#画世界地图
library(maps)
library(ggplot2)
world_map <-  map_data("world" )
world_map
#查看该地图数据中，各个区域（国家）的名字
sort(unique(world_map$region))
#选出指定区域的地图数据
east_asia <-  map_data("world" ,  region=c("Japan" , "China" , "North Korea" ,
                                           "South Korea" ))
#要借助coord_map("mercator")投影才能让地图显示更像地图
#scale_fill_brewer不同区域填充不同
#
ggplot(east_asia,  aes(x=long,  y=lat,  group=group,  fill=region)) +
  geom_polygon(colour="black" ) +
  coord_map("mercator")+
  scale_fill_brewer(palette="Set2")


###########################################################
#从世界地图中提取的新西兰地理数据
nz1 <-  map_data("world" ,  region="New Zealand" )
#剔除岛屿
nz1 <-  subset(nz1,  long > 0 & lat > -48) 
ggplot(nz1,  aes(x=long,  y=lat,  group=group)) + geom_path()
## 如果一个区域有单独地图，如nz新西兰，那么地图数据将会从世界地图中提取的数据的分辨率要搞
nz2 <-  map_data("nz" )
ggplot(nz2,  aes(x=long,  y=lat,  group=group)) + geom_path()

  
################################################
#绘制等值区域图，使得不同区域根据变量填充不同的颜色
#方法：把变量值和地图数据合并在一起

#数值数据
#tolower()将字符大写全部改为小写
crimes <-  data.frame(state = tolower(rownames(USArrests)),  USArrests)
crimes

#地理数据
library(maps) 
states_map <-  map_data("state" )
head(states_map)

#融合数值数据和地理数据
#by.x="region"针对第一个states_map；by.y="state"针对第二个crimes
crime_map <-  merge(states_map,  crimes,  by.x="region" ,  by.y="state" )

head(crime_map)
#用plyr包处理数据
library(plyr) 
#使用包中arrange函数，按照先group 后order排序
crime_map <-  arrange(crime_map,  group,  order)
head(crime_map)

#把一列值Assault映射到fill上，颜色从深蓝到浅蓝
ggplot(crime_map,  aes(x=long,  y=lat,  group=group,  fill=Assault)) +
  geom_polygon(colour="black" ) +
  coord_map("polyconic" )


#利用geom_map()不需要把变量取值与地图数据合并起来，前提是必须要有region（区域）列匹配
#crimes中的map_id = state  要与geom_map中的map = states_map中的region匹配
#因为geom_map() 不能自动设定x和y的界限，所以还需要用expand_limits使得经纬度包含x和y
#展示变量值从某个中点值向外发散，用scale_fill_gradient2()函数
#第一 画crimes 数值数据，进行数据填充
#第二 画地图数据
#第三 中心点映射颜色
#第四 地图界限
ggplot(crimes,  aes(map_id = state,  fill=Assault)) +
  geom_map(map = states_map,  colour="black" ) +
  scale_fill_gradient2(low="#559999" ,  mid="grey90" ,  high="#BB650B" ,
                       midpoint=median(crimes$Assault)) +
  expand_limits(x = states_map$long,  y = states_map$lat) +
  coord_map("polyconic" )

#前面的例子是把连续取值映射到fill上，下面是离散取值进行映射
#取分位点进行映射
#找到分位数的边界
qa <-  quantile(crimes$Assault,  c(0, 0.2, 0.4, 0.6, 0.8, 1.0))

#根据犯罪案例数 对分位点进行离散化
crimes$Assault_q <-  cut(crimes$Assault,  qa,
                         labels=c("0-20%" , "20-40%" , "40-60%" , "60-80%" , "80-100%" ),
                         include.lowest=TRUE)
#产生离散的颜色
pal <-  colorRampPalette(c("#559999" , "grey80" , "#BB650B" ))(5)

#
ggplot(crimes,  aes(map_id = state,  fill=Assault_q)) +
  geom_map(map = states_map,  colour="black" ) +
  scale_fill_manual(values=pal) +
  expand_limits(x = states_map$long,  y = states_map$lat) +
  coord_map("polyconic" ) +
  labs(fill="Assault Rate\nPercentile" )


#################################################
#创建空白背景地图

# 创建一个去掉了很多背景元素的主题
theme_clean <- function(base_size = 12) {
  require(grid) # Needed for unit() function
    theme_grey(base_size) %+replace%
    theme(
      axis.title = element_blank(),
      axis.text = element_blank(),
      panel.background = element_blank(),
      panel.grid = element_blank(),
      axis.ticks.length = unit(0, "cm" ),
      axis.ticks.margin = unit(0, "cm" ),
      panel.margin = unit(0, "lines" ),
      plot.margin = unit(c(0, 0, 0, 0), "lines" ),
      complete = TRUE
    )
}

#去掉了背景色
ggplot(crimes,  aes(map_id = state,  fill=Assault_q)) +
  geom_map(map = states_map,  colour="black" ) +
  scale_fill_manual(values=pal) +
  expand_limits(x = states_map$long,  y = states_map$lat) +
  coord_map("polyconic" ) +
  labs(fill="Assault Rate\nPercentile" ) +
  theme_clean()


########################################################   
#基于shapefile文件创建地图
#读取地理数据方法一：
#用maptools包中的readShapePoly读取地理数据
library(maptools)
China <- readShapePoly("E:\\workspace\\R\\画图\\地理画图\\全国地理文件\\中国地理总文件\\CHN_adm1.shp")

#################################################################
#读取地理数据方法二：
#library(rgdal)
#不能用绝对路径引用
#myChina <- readOGR(".", "CHN_adm2")

#读取地理数据方法三：
#vent.map <-readShapeSpatial("E:\\workspace\\R\\画图\\地理画图\\全国地理文件\\中国地理总文件\\CHN_adm1.shp")
#选择点、线、面
#point.mp <- readShapePoints("E:\\workspace\\R\\画图\\地理画图\\全国地理文件\\中国地理总文件\\CHN_adm1.shp") 
#line.mp <- readShapeLines("E:\\workspace\\R\\画图\\地理画图\\全国地理文件\\中国地理总文件\\CHN_adm1.shp")) 
#poly.mp <- readShapePoly("E:\\workspace\\R\\画图\\地理画图\\全国地理文件\\中国地理总文件\\CHN_adm1.shp") 
#查看shapefile属性，添加坐标信息
#summary(vent.map) 
#添加坐标信息
#proj4string(vent.map) <- "+proj=longlat +datum=WGS84"
#显示地图
#plot(vent.map, axes=TRUE, border="gray")
###############################################################


#查看数据类型,两种方法读出来的数据都是一样的
class(China)
#class(myChina)
#查看数据变量名
names(China)
#names(myChina)

#用ggplot2画图
library(ggplot2)
#fortify 在ggplot2包中，将 china 转化为常规数据框，region 参数是必须的
#它将名字传递给分组数据id
#获得地理文件数据：1 long纬度；2 lat经度；3：order连接点的顺序；4 hole空；
#6 piece  ;7 group ; 8 id 表示地区
china_data <- fortify(China, region = "NAME_1")
class(china_data)
#查看数据
head(china_data)
dim(china_data)
table(as.factor(china_data$id))

#1 颜色填充白色
chinamap <- ggplot(data=china_data, aes(x=long, y=lat,group=group)) +
                  geom_polygon(fill = "white", colour = "black")+
                  coord_map("mercator")
#2 没有填充和墨卡托投影
chinamap <- ggplot(data=china_data, aes(x=long, y=lat,group=group)) +
                  geom_path()+
                 coord_map("mercator")

#3 不同区域映射不同的颜色
chinamap <- ggplot(data=china_data, aes(x=long, y=lat,group=group, fill = id)) +
                  geom_polygon(colour = "black")+
                  coord_map("mercator")

############################################################
#绘制等值区域图

#用iconv函数经过GBK转化为中文字符
#NAME_0表示中国， NAME_1表示省级名称一共32个地区
city <- iconv(China$NAME_1, from="GBK")
table(city)

#水资源数据
water <- c(1085,325,1473,3524,1079,2935,3989,2790,4147,358,2046,434,
           1652,2490,451,3362,1467,871,2145,182,1000,12278,448,377,
           182,1221,3135,152,4976,10000,5298,1234)
#将列名添加到数据框中
water_data = data.frame(city=as.factor(city),water=water)

################################################################
#将地理数据与数值数据结合在一起
#china_data已经转化为数据框时抵达数据融合
#head(china_data)
China_merge <- merge(china_data ,water_data, by.x="id", by.y = "city" )
#head(China_merge)
#使用用plyr包处理数据
library(plyr) 
#使用包中arrange函数，按照先group 后order排序
China_plyr <-  arrange(China_merge,  group,  order)

#把一列值water映射到fill上，颜色从深蓝到浅蓝
ggplot(China_plyr,  aes(x=long,  y=lat,  group=group,  fill=water)) +
  geom_polygon(colour="black" ) +
  coord_map("polyconic" )

##############################################################
#在不进行数据融合的情况下画图
#head(water_data)
ggplot(water_data,  aes(map_id = city,  fill=water)) +
  geom_map(map = china_data,  colour="black" ) +
  scale_fill_gradient2(low="#559999" ,  mid="grey90" ,  high="#BB650B" ,
                       midpoint=median(water_data$water)) +
  expand_limits(x = china_data$long,  y = china_data$lat) +
  coord_map("polyconic" )

##############################################################
#离散化连续型变量数据，得到分位点画图
qa <-  quantile(water_data$water,  c(0, 0.2, 0.4, 0.6, 0.8, 1.0))

#根据water数 对分位点进行离散化
water_data$water_q <-  cut(water_data$water,  qa,
                         labels=c("0-20%" , "20-40%" , "40-60%" , "60-80%" , "80-100%" ),
                         include.lowest=TRUE)
#产生离散的颜色
pal <-  colorRampPalette(c("#559999" , "grey80" , "#BB650B" ))(5)

#画图labs是标签名称
ggplot(water_data,  aes(map_id = city,  fill=water_q)) +
  geom_map(map = china_data,  colour="black" ) +
  scale_fill_manual(values=pal) +
  expand_limits(x = china_data$long,  y = china_data$lat) +
  coord_map("polyconic" ) +
  labs(fill="water Rate\nPercentile" )


##############################################################
#把地图中某个城市抠出来画图
#对已经做了数据融合的China_plyr画图,画出北京
ggplot(China_plyr[China_plyr$id == "Beijing", ],  aes(x=long,  y=lat,  group=group,  fill=water)) +
  geom_polygon(colour="black" ) +
  coord_map("polyconic" )

#在没有进行数据融合情况下画图
ggplot(water_data[water_data$city == "Beijing",],  aes(map_id = city,  fill=water)) +
  geom_map(map = china_data,  colour="black" ) +
  scale_fill_gradient2(low="#559999" ,  mid="grey90" ,  high="#BB650B" ,
                       midpoint=median(water_data[water_data$city == "Beijing",]$water)) +
  expand_limits(x = china_data[China_plyr$id == "Beijing", ]$long,  
                y = china_data[China_plyr$id == "Beijing", ]$lat) +
  coord_map("polyconic" )


#############################################################
#把某省下面各个市的地理数据找出来并抠图出来
library(maptools)
China_city <- readShapePoly("E:\\workspace\\R\\画图\\地理画图\\全国地理文件\\中国地理总文件\\CHN_adm2.shp")
names(China_city)
#查看一下地理数据的变量，以及地点名称
tmp <- iconv(China_city$NAME_1, from="GBK")
table(tmp)
tmp2 <- iconv(China_city$NAME_2, from="GBK")
table(tmp2)

#把浙江省抠出来
#第一种方法抠图
Zhejiang  = China_city[as.character(China_city$NAME_1) == "Zhejiang" , ]
#查看数据
names(Zhejiang)
tmp3 <- iconv(Zhejiang$NAME_2, from="GBK")
table(tmp3)

#第二种方法抠图方法，当地名有重复的时候，只能通过id的数字来辨别不同的城市
#找Zhejiang省的行脚标,value=F 表示返回整数型的数值，即行角标
zhejiang_row = grep(pattern="Zhejiang", tmp, value=F)
Zhejiang_row_id = China_city[zhejiang_row, ]


library(ggplot2)
#fortify 在ggplot2包中，将 china 转化为常规数据框，region 参数是必须的
#它将名字传递给分组数据id
#获得地理文件数据：1 long纬度；2 lat经度；3：order连接点的顺序；4 hole空；
#6 piece  ;7 group ; 8 id 表示地区
Zhejiang_data <- fortify(Zhejiang,  region = "NAME_2")
#head(Zhejiang_data)

#1 颜色填充白色
Zhejiangmap <- ggplot(data=Zhejiang_data , aes(x=long, y=lat,group=group)) +
                      geom_polygon(fill = "white", colour = "black")+
                      coord_map("mercator")
#2 没有填充和墨卡托投影
Zhejiangmap <- ggplot(data=Zhejiang_data , aes(x=long, y=lat,group=group)) +
                      geom_path()+
                      coord_map("mercator")

#3 不同区域映射不同的颜色
Zhejiangmap <- ggplot(data=Zhejiang_data , aes(x=long, y=lat,group=group, fill = id)) +
                      geom_polygon(colour = "black")+
                      coord_map("mercator")
                      
#在地图上展示流行病学数据
#我们给一串随机数当成是流行病学数据，并用颜色填充到地图上。
Zhejiang_data$rand <- runif(length(Zhejiang_data$id))
#此时相当于数据已经融合了
ggplot(data = Zhejiang_data,  aes(x=long,  y=lat,  group=group,  fill=rand)) +
        geom_polygon(colour="black" ) +
        coord_map("polyconic" )





