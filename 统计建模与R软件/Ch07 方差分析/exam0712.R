attach(tree)
shapiro.test(Y[A==1])
shapiro.test(Y[A==2])
shapiro.test(Y[A==3])

shapiro.test(Y[B==1])
shapiro.test(Y[B==2])
shapiro.test(Y[B==3])
shapiro.test(Y[B==4])

bartlett.test(Y~A, data=tree)
bartlett.test(Y~B, data=tree)
