library(knitr)
library(ggplot2) # pretty plots
library(minfi)
library(xlsx) # load Excel files
library(wateRmelon) #pfilter and BMIQ funcitons
library(FDb.InfiniumMethylation.hg19)
library(devtools)
install_git("git://github.com/hbc/CHBUtils.git") # misc personal utilities
library(CHBUtils)
library(methylumi)
library(beanplot)


dataDirectory <- "~/orch_P/PIs/anne_goldfeld/TBHIV_850K/data"


barcodes <- unique(sub("_Grn.idat|_Red.idat", "", list.files(path = dataDirectory, pattern = "idat$",recursive = TRUE)))

if(file.exists(file.path(resultsDir, "RDATA.mldat"))){
    load(file.path(resultsDir, "RDATA.mldat"))
} else {  
    mldat <- methylumIDAT(barcodes=barcodes, idatPath=dataDirectory, parallel=TRUE, oob=TRUE)
    save(mldat, file=file.path(resultsDir, "RDATA.mldat"))
}

mset450k <- methylumIDAT(getBarcodes(path=dataDirectory), idatPath=dataDirectory)


epX <- readEPIC(idatPath= dataDirectory), barcodes=barcodes, pdat=NULL,parallel=F,n=T,oob=F,force=F)


mldat <- readEPIC(barcodes=barcodes, idatPath=dataDirectory, parallel=TRUE, oob=TRUE)

