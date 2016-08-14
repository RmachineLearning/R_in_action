
x <- '<a href="index.php">Home</a>'
y <- regexpr('>[A-Z0-9 ]{1,50}<', x, TRUE)
y

z <- y + attr(y, "match.length")-1
substr(x, y, z)

substr(x, y+1, z-1)


x  <- '<a href="code/120221.R" alt="regexpr">Download Code</a>'
y1 <- regexpr(">[A-Z0-9 ]{1,50}<", x, TRUE)
z1 <- y1 + attr(y1, "match.length")-1
substr(x, y1, z1)
substr(x, y1+1, z1-1)

y2 <- regexpr('href="[A-Z0-9/._ -]{1,50}"', x, TRUE)
z2 <- y2 + attr(y2, "match.length")-1
substr(x, y2, z2)
substr(x, y2+6, z2-1)

y3 <- regexpr('alt="[A-Z0-9/._ -]{1,50}"', x, TRUE)
z3 <- y3 + attr(y3, "match.length")-1
substr(x, y3, z3)
substr(x, y3+5, z3-1)


x <- c("ABCDE", "CDEFG", "FGHIJ")
regexpr("D", x)

gregexpr("D", x)

