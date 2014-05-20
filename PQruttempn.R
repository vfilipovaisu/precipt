
library(xts)
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
  colnames(precip)=c("Date", "precip1")
}
precip$Date=strptime(precip$Date, format="%m/%d/%Y %I:%M:%S %p")
ntser=seq(from=as.Date("1979-01-02 06:00"), to=as.Date("2009-12-31 06:00"), by="day")

precip=data.frame(Date=precip$Date[11:length(precip$Date)],precip1=precip$precip1[11:length(precip$precip1)])
precipn=as.numeric(as.character(precip$precip1))
j=8
i=1
for(k in 1:round(length(precipn)/8)){
precipp1=sum(precipn[i:j])
i=i+8
j=j+8
k=k+1
precipp=append(precipp,precipp1)
}



#precipn1=subset(precip,precip$Date>=as.POSIXct("1979-01-01 00:00:00")&precip$Date<as.POSIXct("1979-01-2 03:00:00"),
             # select=c("Date","precip1"))


precip1=data.frame(Date=ntser,precip1=precipp)
npath=file.path(".",paste(N,sep=""),paste("3-timerP/",paste(N),"hp1n.txt", sep=""))

write.table (precip1, npath, row.names=FALSE)
}

