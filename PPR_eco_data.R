rm(list=ls())

require(graphics)

library(readxl)
Economic_data <- read_excel("GitHub/Economic_data_regression/Economic_data.xlsx")

xx = Economic_data[,3]
yy = Economic_data[,2]
xx = as.numeric(unlist(xx))
yy = as.numeric(unlist(yy))
eco.ppr <- ppr(xx,yy, nterms = 1, model = TURE)

#par(mfrow = c(3,2))   # maybe: , pty = "s")
plot(eco.ppr, main = "ppr(nterms=2)")
detach()



#scatter.smooth(as.numeric(unlist(xx)), eco.ppr[["fitted.values"]])
#plot((xx), eco.ppr[["fitted.values"]])

#plot((xx), predict(eco.ppr))

plot(xx,yy)
lines(xx[order(xx)], predict(eco.ppr)[order(xx)])


#cbind(as.numeric(unlist(xx)), prediction = round(exp(predict(eco.ppr)), 1))
plot(eco.ppr)