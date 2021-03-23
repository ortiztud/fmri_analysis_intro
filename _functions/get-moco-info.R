# Read fMRIPrep's confounds output and create a text file compatible with SPM that contains 
# only MOCO, global signals and linear trends.


## Get the following info from the shell call
func_file <- commandArgs()[6] 

print("Extracting confounds")
#
#install.packages("scales")
library(scales)
# Read in confounds files
conf_data <- read.csv2(paste(func_file), sep='\t', stringsAsFactors=F)

# Select the columns with moco info
moco <- cbind(conf_data$rot_x, conf_data$rot_y, conf_data$rot_z, conf_data$trans_x, conf_data$trans_y, conf_data$trans_z)

# Get non linear trends from run files  
cos1 <- conf_data$cosine00
cos2 <- conf_data$cosine01

## Now combine different confounds into a single file for SPM
csf <- conf_data$csf
wm <- conf_data$white_matter
global <- conf_data$global_signal
output <- cbind(moco, csf, wm, global, cos1, cos2)
output <- format(output, scientific = F)

# Write output info to txt file
output_name <- strsplit(func_file, "timeseries.tsv")
output_name <- paste(output_name[1], "SPM.txt", sep="")
write.table(output, col.names=F,row.names=F,output_name,quote = FALSE)
  