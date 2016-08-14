
7 / 2

7 %% 2

7 %/% 2


11.8 %% 5

11.8 %/% 5

x <- 11.8
y <- 5
(x %% y) + y*(x %/% y)


13 %% 1:5


# May produce different results:
1 %% 0.2

1 %/% 0.2


# To access the help file for %% and %/%,
# use acute accents around %%
?`%%`


#=====> See txtProgressBar Post <=====#
SEQ  <- seq(1,100000)
TIME <- Sys.time()
for(i in SEQ){
  Sys.sleep(0.00002)
}
Sys.time() - TIME

pb   <- txtProgressBar(1, 100000, style=3)
TIME <- Sys.time()
for(i in SEQ){
  Sys.sleep(0.00002)
  setTxtProgressBar(pb, i)
}
Sys.time() - TIME

pb   <- txtProgressBar(1, 100000, style=3)
TIME <- Sys.time()
for(i in SEQ){
  Sys.sleep(0.00002)
  if(i %% 1000 == 0){
    setTxtProgressBar(pb, i)
  }
}
Sys.time() - TIME
