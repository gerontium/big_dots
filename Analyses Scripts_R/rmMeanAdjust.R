rmMeanAdjust<-function(dataframe)
{
  varNames<-names(dataframe)
  
  pMean<-(dataframe[,1] + dataframe[,2])/2
  grandmean<-mean(c(dataframe[,1], dataframe[,2]))
  adj<-grandmean-pMean
  varA_adj<-dataframe[,1] + adj
  varB_adj<-dataframe[,2] + adj
  
  output<-data.frame(varA_adj, varB_adj)
  names(output)<-c(paste(varNames[1], "adj", sep = "_"), paste(varNames[2], "_adj", sep = "_"))
  return(output)
}