
library(RCurl)

#=====> Sign Up To Be An OpenIntro Donor <=====#
url    <- "http://www.openintro.org/cont/donorProcess.php"
result <- postForm(url, name="David Diez",
                        email="david@openintro.org",
                        phone="857-288-8547")

# The result is an empty string since the page redirects
# Otherwise postForm and getForm return the resulting HTML
result
