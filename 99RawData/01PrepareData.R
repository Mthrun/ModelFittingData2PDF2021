#require(remotes)
#https://github.com/aultsch/DataIO"
#remotes::install_github("aultsch/DataIO")#dbt.DataIO

require(dbt.DataIO)
require(DataVisualizations)
require(ggplot2)

Disk="E"
pathraw="PRO/MCT/ModelFittingData2PDF2021/99RawData"
path=paste0(gsub("C",Disk,SubversionDirectory()),pathraw)
V2=dbt.DataIO::ReadLRN(FileName='Einkommen2001bereinigt',InDirectory=path)
Key=V2$Key
DataFull=V2$Data
V2$Header
V2$Comments
ind=sample(1:length(DataFull),50000)
Data=round(DataVisualizations::SignedLog(DataFull[ind]),2)
DataVisualizations::InspectVariable(Feature = Data,Name="Log Einkommen")

#Fuers Ausscheiben
Data=as.matrix(Data)
KeyNew=Key[ind]
rownames(Data)=KeyNew
colnames(Data)="LogEinkommen"

V=DataVisualizations::PDEplot(Data,color = "black",lwd = 3,title = "PDEplot von Log des Einkommens",xlab = "Log Einkommen")

V$ggPlot +ggplot2::theme_bw()+ ggplot2::theme(
  axis.title.y = ggplot2::element_text(size = ggplot2::rel(2)),
  axis.title.x = ggplot2::element_text(size = ggplot2::rel(2)),
  axis.text.x = ggplot2::element_text(size = ggplot2::rel(2)),
  axis.text.y = ggplot2::element_text(size = ggplot2::rel(2)),
  plot.title =  ggplot2::element_text(size = ggplot2::rel(1.8))
)+ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))

setwd(gsub("99RawData","09Originale",path))
write.table(file = "LogEinkommenSample.csv",sep = ",",x = Data,fileEncoding = "UTF8",row.names = TRUE,dec=".",col.names = T)

