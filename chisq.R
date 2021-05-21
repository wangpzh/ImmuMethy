args<-commandArgs(T)
mat<-read.table(args[1],header=F,sep="\t",row.names=1) 
# mat<-read.table("Sample.idatbeta.matrix.txt",header=F,sep="\t",row.names=1) 

test<-function(x){
uts<-sum(x<0.5)
mts<-sum(x>0.5)
regions<-c(uts,mts)
result<-chisq.test(regions)
return(data.frame(result$p.value,uts,mts))
}

result2<-apply(mat,1,test)
mat2<-t(sapply(result2,c))
colnames(mat2)<-c("p.value","uts","mts")
write.table(mat2,file=paste(args,".chisq",sep=""),sep="\t",quote=F,row.names=T,col.names=NA)

