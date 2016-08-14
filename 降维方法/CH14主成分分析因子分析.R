#------------------------------------------- #
# R in Action: Chapter 14                    #
# requires that the psych has been installed #
# install.packages(c('psych'))               #
#------------------------------------------- #

# pause on each graph
par(ask = TRUE)

set.seed(1234)

# determine number of components in USJudgeRatings
library(psych)
fa.parallel(USJudgeRatings[, -1], fa = "pc", ntrials = 100, 
    show.legend = FALSE, main = "Scree plot with parallel analysis")

# Listing 14.1 - Principal components anaalysis of US Judge Ratings

pc <- principal(USJudgeRatings[, -1], nfactors = 1, score = TRUE)
pc

# determine number of components in Harman data
library(psych)
fa.parallel(Harman23.cor$cov, n.obs=302, fa="pc", ntrials=100,
    show.legend=FALSE, main="Scree plot with parallel analysis")
    
# Listing 14.2 Pricnicapl components analysis of body measurements

library(psych)
fa.parallel(Harman23.cor$cov, n.obs = 302, fa = "pc", 
    ntrials = 100, show.legend = FALSE, 
    main = "Scree plot with parallel analysis")
pc <- principal(Harman23.cor$cov, nfactors = 2, rotate = "none")
pc

# Listing 14.3 Principal components analysis with varimax rotation

rc <- principal(Harman23.cor$cov, nfactors = 2, rotate = "varimax")
rc

# Listing 14.4 - Obtaining component scores from raw data

library(psych)
pc <- principal(USJudgeRatings[,-1], nfactors=1, score=TRUE)
head(pc$scores)

# correlation between PC score and number of lawyer contacts
cor(USJudgeRatings$CONT, pc$score)

# Listing 14.5 - Obtaining principal component scroing coefficients

library(psych)
rc <- principal(Harman23.cor$cov, nfactors=2, rotate="varimax")
round(unclass(rc$weights), 2)

# Exploratory factor analysis of ability.cov data

options(digits = 2)
library(psych)
covariances <- ability.cov$cov
# convert covariances to correlations
correlations <- cov2cor(covariances)
correlations

# determine number of factors to extract
fa.parallel(correlations, n.obs = 112, fa = "both", 
    ntrials = 100, main = "Scree plots with parallel analysis")

# Listing 14.6 - Principal axis factoring without rotation

fa <- fa(correlations, nfactors = 2, rotate = "none", fm = "pa")
fa

# Listing 14.7 - Factor extraction with orthogonal rotation

fa.varimax <- fa(correlations, nfactors = 2, rotate = "varimax", 
    fm = "pa")
fa.varimax

# Listing 14.8 - Factor extraction with oblique rotation

fa.promax <- fa(correlations, nfactors = 2, rotate = "promax", 
    fm = "pa")
fa.promax

# Calculate factor loading matrix

fsm <- function(oblique) {
    if (class(oblique)[2]=="fa" & is.null(oblique$Phi)) {
        warning("Object doesn't look like oblique EFA")
    } else {
        P <- unclass(oblique$loading)
        F <- P %*% oblique$Phi
        colnames(F) <- c("PA1", "PA2")
        return(F)
    }
}

fsm(fa.promax)

# plot factor solution

factor.plot(fa.promax, labels = rownames(fa.promax$loadings))
fa.diagram(fa.promax, simple = FALSE)
