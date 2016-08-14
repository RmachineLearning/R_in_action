X<-scan()
137.0 140.0 138.3 139.0 144.3 139.1 141.7 137.3 133.5 138.2 
141.1 139.2 136.5 136.5 135.6 138.0 140.9 140.6 136.3 134.1

wilcox.test(X, mu=140, alternative="less", 
          exact=FALSE, correct=FALSE, conf.int=TRUE)

