setwd('C:/Users/jayakumara/Desktop/Temp')
d.f <- read.csv(file = "sg.csv", head = TRUE, sep = ",")
d.f <- read.csv(file = "us.csv", head = TRUE, sep = ",")
d.f <- read.csv(file = "filtered.csv", head = TRUE, sep = ",")
d.f <- read.csv(file = "new_filtered.csv", head = TRUE, sep = ",")

d.f<-na.omit(d.f)
x$duration <- factor(x$duration)
x$duration <- factor(x$duration)

regmodel = lm(duration ~ factor(worklifefactor) * oldcompany, data = filtered)
summary(regmodel)

regmodel = lm(duration ~ factor(pastexperience) * oldcompany, data = filtered)
summary(regmodel)

sink("summary.txt")
summary(regmodel)
sink()

y <- d.f$duration
x <- d.f$worklifefactor
fit <- lm(y~x, d.f)
plot( y ~ x, data = d.f, type = "n", log = "xy", main = "duration vs worklifefactor", xlab = "No of Games", ylab = "Salary" )
points( y ~ x, data = d.f )
abline( h = seq( 0, 100, 10 ), lty = 3, col = colors()[ 440 ] )
abline( v = seq( 0, 4000, 10 ), lty = 3, col = colors()[ 440 ] )
abline(fit, col="red",untf=TRUE)

# Log - Log plot
y <- d.f$duration
x <- d.f$pastexperience
fit <- lm(y~x, d.f)
plot( y ~ x, data = d.f, type = "n", log = "xy", main = "duration vs pastexperience", xlab = "No of Games", ylab = "Salary" )
points( y ~ x, data = d.f )
abline( h = seq( 0, 100, 10 ), lty = 3, col = colors()[ 440 ] )
abline( v = seq( 0, 4000, 10 ), lty = 3, col = colors()[ 440 ] )
abline(fit, col="red",untf=TRUE)

y <- d.f$duration
x <- d.f$worklifefactor
fit <- lm(y~x, d.f)
plot( y ~ x, data = d.f, type = "n", log = "xy", main = "duration vs worklifefactor", xlab = "No of Games", ylab = "Salary" )
points( y ~ x, data = d.f )
abline( h = seq( 0, 100, 10 ), lty = 3, col = colors()[ 440 ] )
abline( v = seq( 0, 4000, 10 ), lty = 3, col = colors()[ 440 ] )
abline(fit, col="red",untf=TRUE)

# scatterplotMatrix
scatterplotMatrix(~duration + timetocommute + numconnections + pastexperience + degreescore + schoolscore + overallrating, reg.line=lm,smooth=TRUE, spread=FALSE, span=0.5, id.n=0, diagonal = 'density', data=d.f)

scatterplotMatrix(~duration + pastexperience + degreescore + schoolscore + overallrating, reg.line=lm,smooth=TRUE, spread=FALSE, span=0.5, id.n=0, diagonal = 'density', data=d.f)

scatterplotMatrix(~duration+overallfactor+culturefactor+leadershipfactor+compensationfactor+careerfactor+worklifefactor+recommendfactor, reg.line=lm,smooth=TRUE, spread=FALSE, span=0.5, id.n=0, diagonal = 'density', data=d.f)

# Model
regmodel = lm(duration ~ timetocommute + numconnections + pastexperience + 
                degreescore + schoolscore + overallrating + culture + leadership + 
                compensation + career + worklife + recommend + overallpast + 
                culturepast + leadershippast + compensationpast + careerpast + 
                worklifepast + recommendpast + overallfactor + culturefactor + 
                leadershipfactor + compensationfactor + careerfactor + worklifefactor + recommendfactor, data = filtered)

sink("summary.txt")
summary(regmodel)
sink()

coefficient = coefficients(regmodel)
coefficient

confint.default(regmodel)