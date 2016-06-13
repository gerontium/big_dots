########Outlier function: (I need to work out how to save function files then just call them whenever I want)
outlierSummary<-function(variable, digits = 2){zvariable<-(variable-mean(variable, na.rm = TRUE))/sd(variable, na.rm = TRUE)
                                               outlier95<-abs(zvariable) >= 1.96
                                               outlier99<-abs(zvariable) >= 2.58
                                               outlier999<-abs(zvariable) >= 3.29
                                               
                                               ncases<-length(na.omit(zvariable))
                                               
                                               percent95<-round(100*length(subset(outlier95, outlier95 == TRUE))/ncases, digits)
                                               percent99<-round(100*length(subset(outlier99, outlier99 == TRUE))/ncases, digits)
                                               percent999<-round(100*length(subset(outlier999, outlier999 == TRUE))/ncases, digits)
                                               cat("Absolute z-score greater than 1.96 = ", percent95, "%", "\n")
                                               cat("Absolute z-score greater than 2.58 = ",  percent99, "%", "\n")
                                               cat("Absolute z-score greater than 3.29 = ",  percent999, "%", "\n")}
########
