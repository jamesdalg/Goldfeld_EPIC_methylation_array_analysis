#metadata<- rio::import(paste0(dataDirectory,"/SampleSheet.csv"))


metadata<-metadata %>% tidyr::separate(TargetID, c("Slide","Array","AVG","Beta"),remove = FALSE) %>% 
    dplyr::select(-c(AVG,Beta)) %>% dplyr::rowwise() %>%
    dplyr::mutate(Basename=paste0(dataDirectory,"/",Slide,"/",Slide,"_",Array))




colnames(metadata)[2] <-"Sample_Group"




rio::export(metadata,file=paste0(dataDirectory,"/metadata_final.csv"))


#/Users/victorbarrera/orch_P/PIs/anne_goldfeld/TBHIV_850K/data/201557540002/201557540002_R02C01
#####

metadata <- rio::import("~/Desktop/Projects/anne_goldfeld/TBHIV_850K/data/metadata_corrected.csv")
colnames(metadata)[2] <-"Sample_Group"
colnames(metadata) <- gsub(" ","_",tolower(colnames(metadata)))
metadata$sample_name<- gsub(" ","_",metadata$sample_name)

metadata$sentrix_id <- as.character(metadata$sentrix_id)
metadata$sentrix_position <- as.character(metadata$sentrix_position)


metadata<-metadata %>%
    dplyr::mutate(Basename=paste0(dataDirectory,"/",sentrix_id,"/",sentrix_id,"_",
                                  sentrix_position))

metadata$gender <- ifelse(metadata$gender == 0, "M", "F")
metadata$arm <- ifelse(metadata$arm == 0, "Early", "Late")
metadata$iris <- ifelse(metadata$iris == 0, "no", "yes")


rio::export(metadata,file=paste0(dataDirectory,"/metadata_final.csv"))

