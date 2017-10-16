# Converts those csv into json arrays, also concatenating hours with minutes.

filenames <- c(
  "./schedules_datasets/direto_ru.csv",
  "./schedules_datasets/expresso_ru_cet_vd.csv",
  "./schedules_datasets/expresso_ru_reitoria_vd.csv",
  "./schedules_datasets/expresso_vd_cet_ru.csv",
  "./schedules_datasets/expresso_vd_cet.csv",
  "./schedules_datasets/expresso_vd_reitoria_ru.csv",
  "./schedules_datasets/expresso_vd_reitoria.csv",
  "./schedules_datasets/inverso_ru.csv"
);

schedulings <- read.csv(filenames[1]);

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
      
      print(paste(
        identation,
        "{\"time\": \"",
        hour, ":", min_op,
        "\"},",
        sep=""
      ));
      
      }
  }
}

for (filename in filenames){
  schedulings = read.csv(filename);
  paste(paste(replicate(2, "  "), collapse=""), "ok", sep="");
}
