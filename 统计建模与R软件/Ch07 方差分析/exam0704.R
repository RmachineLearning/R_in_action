attach(mouse)
mu<-c(mean(X[A==1]), mean(X[A==2]), mean(X[A==3])); mu

# t检验
pairwise.t.test(X, A, p.adjust.method = "none")

pairwise.t.test(X, A, p.adjust.method = "holm")
pairwise.t.test(X, A, p.adjust.method = "hochberg")
pairwise.t.test(X, A, p.adjust.method = "hommel")
pairwise.t.test(X, A, p.adjust.method = "bonferroni")

pairwise.t.test(X, A, p.adjust.method = "BH")
pairwise.t.test(X, A, p.adjust.method = "BY")
pairwise.t.test(X, A, p.adjust.method = "fdr")

plot(mouse$X~mouse$A)