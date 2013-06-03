# Used to loop through csv files that contained x/y points coded by year and output scatter plot.
# sqld is used in the loop to select each year

# Setup
workingDir="I:/" 
outputDir="I:/output/"
fileExt = "csv"
years <- c("2004","2008","2009","2010","2011","2012")

# Include
library(sqldf)

# Get files in dir
setwd(workingDir)
files=list.files() #Could set to only filter CSV
names <- substr(files,1,7)

# Loop through CSV files
for (i in 1:length(files)){

  # Set random colour for use in plot
  random = sample(1:3,1)
  if(random == 1){colour="#FF8C0032"} # Orange
  else if (random == 2){colour="#00640032"} #Green
  else if (random == 3) {colour="#FF303032"} #Red

  thisFile = paste(names[i],fileExt,sep="",collapse=NULL)	
	csvData=read.csv(thisFile)

	#Loop through years, query data
	for (year in years){

		thisData=sqldf(sprintf("SELECT * from csvData WHERE year = '%s'",year))
		#print(summary(thisData)) # Lists basic stats for thisData
		
		mapTitle=paste("File#",i,", Year: ",year,sep="",collapse=NULL)
		outputFile=paste(outputDir,"g",i,"_",year,".png",sep="",collapse=NULL)		
		png(filename=outputFile,width=800,height=800,units="px")		

		# Map x/y fields
		x <- thisData$xField
		y <- thisData$yField

		plot(x,y,col=colour, pch=20, main=mapTitle,xlab="X axis label", ylab="Y axis label")
		dev.off()
	}

}


