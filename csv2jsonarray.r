# Converts those csv into json arrays, also concatenating hours with minutes.

datasetsRootDir = "./schedules_datasets/";
translationsRootDir = "./generated/";

filenames <- c(
  "direto_ru.csv",
  "expresso_ru_cet_vd.csv",
  "expresso_ru_reitoria_vd.csv",
  "expresso_vd_cet_ru.csv",
  "expresso_vd_cet.csv",
  "expresso_vd_reitoria_ru.csv",
  "expresso_vd_reitoria.csv",
  "inverso_ru.csv"
);

for (filename in filenames){
  schedulings <- read.csv(paste(datasetsRootDir, filename, sep=""));
  translationFile <- file(paste(translationsRootDir, filename, ".json", sep=""));
  lines <- character()
  
  identation <- paste(replicate(7, "  "), collapse="");
  
  for(i in 1:nrow(schedulings)) {
    hour <- schedulings[i, 1];
    
    if (as.numeric(hour) < 10){
      hour <- paste("0", hour, sep="");
    }
    
    for (min_op in schedulings[i, 2:ncol(schedulings)]){
      if (!is.na(min_op)){
        
        if (as.numeric(min_op) < 10){
          min_op <- paste("0", min_op, sep="");
        }
        
        lines <- c(lines, paste(identation, "{\"time\": \"", hour, ":", min_op, "\"},", sep=""));
        
      }
    }
  }
  
  writeLines(lines, translationFile);
  close(translationFile);
  
  print(paste("`", filename, "` translated.", sep=""));
  
}
