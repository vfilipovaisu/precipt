
Catchm=read.delim("Catchmnp1.txt",header=FALSE) 
for(N in Catchm$V1) {

precipp=numeric()
path=file.path(".", paste(N,sep=""), paste("3-timerP/", paste(N),"_1979_2009.txt",sep=""))
precip=read.csv(path,skip=90586)

colnames(precip)=c("Date", "precip1")
ni=0
for(j in 1:100){
if(precip$precip1[j]<0) {
  ni=ni+1
}
}
if(ni>0){
  precip=read.csv(path,nrow=90585)
  colnames(precip)=c("Date", "precip")
}
precip$Date=strptime(precip$Date, format="%m/%d/%Y %I:%M:%S %p")
ntser=seq(from=as.POSIXct("1979-01-01 00:00:00"), to=as.POSIXct("2009-12-31 24:00:00"), by="hour")
precipn=as.numeric(as.character(precip$precip1))/3

#precipn1=subset(precip,precip$Date>=as.POSIXct("1979-01-01 00:00:00")&precip$Date<as.POSIXct("1979-01-2 03:00:00"),
             # select=c("Date","precip1"))

for(i in 1:length(precipn)){
precippn1=rep(precipn[i],3)
precipp=append(precipp,precippn1)
}

precip1=data.frame(Date=ntser,precip1=precipp[3:length(precipp)])
npath=file.path(".",paste(N,sep=""),paste("3-timerP/",paste(N),"hp1.txt", sep=""))

write.table (precip1, npath, row.names=FALSE)
}

