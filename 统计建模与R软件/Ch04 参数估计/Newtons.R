Newtons<-function (fun, x, ep=1e-5, it_max=100){
    index<-0; k<-1
    while (k<=it_max){
        x1 <- x; obj <- fun(x);
        x  <- x - solve(obj$J, obj$f);
        norm <- sqrt((x-x1) %*% (x-x1))
        if (norm<ep){
            index<-1; break
        }
        k<-k+1
    }
    obj <- fun(x);
    list(root=x, it=k, index=index, FunVal= obj$f)
}