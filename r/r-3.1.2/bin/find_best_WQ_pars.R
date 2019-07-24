#############################################################
# INTRO
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# This R Script:
#    1 - determines the average outflow concentration of distinct storm events
#    2 - determines which distribution of Cout best matches the observed distribution
# Inputs are:
#    1 - SUSTAIN model time series output ("Init_BMP_1.out")
#    2 - Water quality parameters supplied to the SUSTAIN simulation.  Either:
#         2.1 - first order decay values (k)
#         OR
#         2.2 - Kadlec-Knight parameters (k-C*)
#    3 - Observed event mean concentrations in BMP outflow
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---


DEBUG <- FALSE


wd = getwd()
args <- commandArgs(TRUE)
#wd = '/Users/cross/Desktop/Water_modeling_copy/R/R-3.1.2/bin'
csv_path <- if(!DEBUG) file.path(args[1],"/params.csv") else
  file.path("V:", "iDST_DeCal_Data", "Completed_Ongoing_Calibrations", "B512WD-FC", "data", "params.csv")
data_params_wdir <- read.csv(csv_path,header = F)
wdir <- as.character(data_params_wdir[1,1])
wdir <- gsub("\\\\","\\/", wdir)
data_params = read.csv(csv_path,header = T)
save_folder<-as.character(data_params_wdir[7,1])
main_save_path <- file.path(wdir,save_folder)
plot_save_path<-file.path(wdir,save_folder)
plot_save_path<-paste(plot_save_path,"/plots/",sep="")
data_save_path<-file.path(wdir,save_folder)
data_save_path<-paste(data_save_path,"/data/",sep="")
#wdir <- as.character(commandArgs(trailingOnly=T)[1])


#############################################################
# PARSE WORKING DIRECTORY [FOR PCs] AND MODEL PARAMETERS
# FROM INPUT ARG 
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
#wdir <- as.character(commandArgs(trailingOnly=T)[1])


# SINK MESSAGES
if (!DEBUG) {
  # Only sink stuff if not interactively debugging
  sink(paste(main_save_path, "/R_ParameterCalibration_Messages.txt", sep=""),append=F,type="output")
  sinkfile <- file(paste(main_save_path, "/R_ParameterCalibration_Errors.txt", sep=""), open="wt")
  sink(sinkfile, type="message")    # This will also redirect error output to the file, making things easier to debug
}




Rdir <- paste(wdir,"/R/", sep="")
print(Rdir)
Rinput_dir <- data_save_path
Routput_dir <- plot_save_path

SUSTAIN_dir <- paste(main_save_path, "/SUSTAIN/", sep="")
SUSTAINoutput_dir <- paste(main_save_path, "/SUSTAIN/Output/", sep="")


#num.sims <- as.numeric(commandArgs(trailingOnly=T)[2])
#num.sims <- 10
num.sims <- as.numeric(as.character(data_params[1,1]))
#StopEventFlowThreshold <- as.numeric(commandArgs(trailingOnly=T)[3])# default = 0.01 based on quickly playing with this code
StopEventFlowThreshold <- as.numeric(as.character(data_params[2,1]))



#############################################################
# Load necessary functions/packages
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
if(!require("goftest")){
   install.packages("goftest",repos = "http://cran.us.r-project.org")  
}
library("goftest")



#############################################################
# Read in all files
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

cout.obs <- read.csv(file=paste(Rinput_dir, "c_out.csv", sep=""), header=T)
wqpars <- read.table(file=paste(SUSTAIN_dir, "Output/WQPars.txt", sep=""), header=F)
out_ts_file <- file(paste(SUSTAIN_dir, "Output/Init_BMP_1.out", sep=""), open="r")


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
#  Read in just output time series rows/columns that are relevant
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# First - determine which columns have relvant data, and assign names:
cols.keep <- c("character", rep("numeric",8), rep("NULL",4), "numeric", rep("NULL",4), rep(c(rep("NULL",5), rep("numeric", 2)), num.sims))

# Column names
outnames <- NULL
for(i in seq(1:num.sims)){
outnames <- c( outnames, paste("Mout_lb_", i, sep=""), paste("Cout_mgL_", i, sep="") )
}
cols.names <- c("Loc","Year","Month","Day","Hour","Minute","BMP_Vol_ft3","BMP_depth_ft","TotalInflow_cfs","TotalOutflow_cfs",outnames)

# Skip header lines until "Date/time" line is found - which is the last of the header
while( TRUE ){
     line <- readLines( out_ts_file , 1L )
     if( grepl( "Date/time", line ) ){
          break
     }
}

# Read in rest of time series

out_ts <- read.table( out_ts_file, header = F, colClasses = cols.keep)
colnames(out_ts) <- cols.names
close( out_ts_file )


#############################################################
# Determine start/end of discrete INFLOW events based on modeled time series
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Establish a data frame to keep track of when the modeled inflow events start
# and stop
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
inflow_start_stop <- out_ts[1,2:6]
inflow_start_stop$flag[1] <- "start"
inflow_start_stop$rownum[1] <- 1
k <- 2

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Move through the modeled inflow time series, line by line,
# and flag if a rain event "stops" or "starts"
# 
# Start = when flow changes from 0 to >0
# Stop = when flow changes from >0 to 0
# 
# These values of 0 should be pretty easy to find, based on the
# way the input time series was generated
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

for(i in seq(1:(length(out_ts$TotalInflow_cfs)-1))){
     x <- i+1
     
     # If the flow changes from 0 to not 0 - record the time stamp as the START of an inflow event
     if(out_ts$TotalInflow_cfs[x] != 0 && out_ts$TotalInflow_cfs[i] == 0){
          inflow_start_stop[k,] <- c(out_ts[x,2:6], "start", x)
          k <- k+1
     }
     
     # If the flow changes from not 0 to 0 - record the time stamp as the END of an inflow event
     if(out_ts$TotalInflow_cfs[x] == 0 && out_ts$TotalInflow_cfs[i] != 0){
          inflow_start_stop[k,] <- c(out_ts[i,2:6], "stop", i)
          k <- k+1
     }
}


#############################################################
# Determine start/end of discrete OUTFLOW events based on modeled time series
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Establish a data frame to keep track of when the modeled outflow events start
# and stop
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# Use the same start times as were found with the inflow time series 
outflow_start_stop <- subset(inflow_start_stop, flag=="start")
k <- dim(outflow_start_stop)[1] + 1
rownames(outflow_start_stop) <- c()

# Now find the outflow event stop times, based on when the flow decreases across parameterized threshold: 
# "StopEventThreshold"
# This value is passed into R from the VBA (see the first section of the code)
plot(out_ts$TotalOutflow_cfs[c(10:7000)])
plot(out_ts$TotalInflow_cfs[c(40:7000)])
for(i in seq(1:(length(out_ts$TotalOutflow_cfs)-1))){
     x <- i+1
     # If flow was above the threshold, but crosses below the threshold, flag it as the end of an outflow event
     if(out_ts$TotalOutflow_cfs[x] <= StopEventFlowThreshold && out_ts$TotalOutflow_cfs[i] > StopEventFlowThreshold) {
          outflow_start_stop[k,] <- c(out_ts[i,2:6], "stop", i)
          k <- k+1
     }
}

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# remove any events where two inflow events bleed into each other (i.e., if there are two inflow event start
# timestamps in a row, with no outflow event stop in between)
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---


outflow_start_stop <- outflow_start_stop[order(outflow_start_stop$rownum),]
outflow_start_stop$remove <- 0

for(i in seq(1:(length(outflow_start_stop$flag)-1))){
     x <- i+1
     
     # determine is there are two or more inflow "start" flag back-to-back, wthiout and outflow "stop"
     if(outflow_start_stop$flag[i] == outflow_start_stop$flag[x] && outflow_start_stop$flag[i] == "start"){
          # If so, flag the whole "start"-"start"-"stop" sequence for removal
          outflow_start_stop$remove[i] = 1 
          outflow_start_stop$remove[i+1] = 1

          # Be sure not to flag a row that doesn't exist...
          if(i < (length(outflow_start_stop$flag)-1)) {
               outflow_start_stop$remove[i+2] = 1
          }
     }
}

# If the last event flag in the series is a "start" - flag for removal
if(tail(outflow_start_stop$flag,1) == "start") { outflow_start_stop$remove[length(outflow_start_stop$remove)] = 1 }

# Remove the flagged starts/stops
outflow_start_stop <- subset(outflow_start_stop, remove==0)


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Now, work backwards, and remove any events with two or more "stop" flags
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

for(i in (length(outflow_start_stop$flag):2)){
     x <- i-1
     
     # determine is there are two or more outflow "stop" flags back-to-back, without a "start" in between
     if(outflow_start_stop$flag[i] == outflow_start_stop$flag[x] && outflow_start_stop$flag[i] == "stop"){
          # If so, flag the whole "stop"-"stop"-"start" sequence for removal
          outflow_start_stop$remove[i] = 1 
          outflow_start_stop$remove[i-1] = 1
          
          # Be sure not to flag a row that doesn't exist...
          if(i > 3) {
               outflow_start_stop$remove[i-2] = 1 
          }
     }
}

# If the first event flag in the series is a "stop" - flag for removal
if(outflow_start_stop$flag[1] == "stop") { outflow_start_stop$remove[1] = 1 }

# Remove the flagged starts/stops
outflow_start_stop <- subset(outflow_start_stop, remove==0)

#############################################################
# Using the identified, discrete events, populate a data frame of 
# variables (notably, average Cout)
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
n.outflows <- length(outflow_start_stop$flag)/2

cout.mod <- as.data.frame(matrix(nrow = n.outflows, ncol = (5 + num.sims*2)))
colnames(cout.mod) <- c("event_num", "volume_out_ft3", "start_time", "end_time", "peakflow_cfs", outnames)

for(i in seq(1:n.outflows)){
     
     cout.mod$event_num[i] <- i
     
     # Keep just the part of the time series based on the row numbers
     # flagged +  saved in the outflow_start_stop data frame
     this.event.ts <- out_ts[(outflow_start_stop$rownum[1+2*(i-1)]:outflow_start_stop$rownum[2+2*(i-1)]),]
     
     # Log total volume
     cout.mod$volume_out_ft3[i] <- sum(this.event.ts$BMP_Vol_ft3)
     
     # Log start time
     cout.mod$start_time[i] <- paste(this.event.ts$Hour[1], ":", this.event.ts$Minute[1]," ", this.event.ts$Month[1],"/",this.event.ts$Day[1], "/", this.event.ts$Year[1], sep="")
     
     # Log end time
     cout.mod$end_time[i] <- paste(tail(this.event.ts$Hour,1), ":", tail(this.event.ts$Minute,1) ," ", tail(this.event.ts$Month,1),"/", tail(this.event.ts$Day,1), "/", tail(this.event.ts$Year,1), sep="")

     # Log peak outflow (not: this is over a 1 hr timestep)
     cout.mod$peakflow_cfs[i] <- max(this.event.ts$TotalOutflow_cfs)
     
     # Sum the total mass and concentration columes for the different WQ parameters
     # NOTE: the sums of the concentration are meaningless right now - will do the
     # calculation of EMC outside this for loop
     ####### error x must be numeric
     cout.mod[i,] <- c(cout.mod[i,1:5], colSums(this.event.ts[,-c(1:10)]))
     
     for(ii in seq(1:num.sims)) {
        j <- (12+2*(ii-1))
        k <- (7+2*(ii-1))
        cout.mod[i,k] <- sum(this.event.ts$TotalOutflow_cfs * this.event.ts[,j]) / sum(this.event.ts$TotalOutflow_cfs)
     }
     
}

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Compute EMC for each WQ parameter
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
emc.col.nums <- (7+2*((1:num.sims)-1))
cout.emc.mod <- cout.mod[,emc.col.nums]


#############################################################
# Determine which parameter set best matches the observed distriubtion of Cout
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Establish Data Frame to hold all the GOF stats
# NOTE: can potentially expand code later
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if( dim(wqpars)[1] == 1 ) {
     stats <- data.frame(ParameterSet = 1:num.sims, k=t(wqpars[1,1:num.sims]), ks.test.pval=rep(0,num.sims), ks.test.D=rep(0,num.sims), d.0=rep(0,num.sims), d.5=rep(0,num.sims), d.10=rep(0,num.sims), d.15=rep(0,num.sims), d.20=rep(0,num.sims), d.25=rep(0,num.sims), d.30=rep(0,num.sims), d.35=rep(0,num.sims), d.40=rep(0,num.sims), d.45=rep(0,num.sims), d.50=rep(0,num.sims), d.55=rep(0,num.sims), d.60=rep(0,num.sims), d.65=rep(0,num.sims), d.70=rep(0,num.sims), d.75=rep(0,num.sims), d.80=rep(0,num.sims), d.85=rep(0,num.sims), d.90=rep(0,num.sims), d.95=rep(0,num.sims), d.100=rep(0,num.sims))
     colnames(stats)[2] <- "k"
} else {
     stats <- data.frame(ParameterSet = 1:num.sims, k_prime=t(wqpars[1,]), C_star=t(wqpars[2,]), ks.test.pval=rep(0,num.sims), ks.test.D=rep(0,num.sims), d.0=rep(0,num.sims), d.5=rep(0,num.sims), d.10=rep(0,num.sims), d.15=rep(0,num.sims), d.20=rep(0,num.sims), d.25=rep(0,num.sims), d.30=rep(0,num.sims), d.35=rep(0,num.sims), d.40=rep(0,num.sims), d.45=rep(0,num.sims), d.50=rep(0,num.sims), d.55=rep(0,num.sims), d.60=rep(0,num.sims), d.65=rep(0,num.sims), d.70=rep(0,num.sims), d.75=rep(0,num.sims), d.80=rep(0,num.sims), d.85=rep(0,num.sims), d.90=rep(0,num.sims), d.95=rep(0,num.sims), d.100=rep(0,num.sims))
     colnames(stats)[2:3] <- c("kprime","Cstar")
}

for(i in seq(1:num.sims)){
     stats$ks.test.pval[i] <- ks.test(cout.emc.mod[,i], cout.obs$c_out.mg_per_L)$p.value
     stats$ks.test.D[i] <- ks.test(cout.emc.mod[,i], cout.obs$c_out.mg_per_L)$statistic
     stats[i,c("d.0","d.5","d.10","d.15","d.20","d.25","d.30","d.35","d.40","d.45","d.50","d.55","d.60","d.65","d.70","d.75","d.80","d.85","d.90","d.95","d.100")] <- quantile(cout.emc.mod[,i], c(0.0,0.5,.10,.15,.2,.25,.3,.25,.4,.45,.5,.55,0.6,.65,0.7,.75,0.8,.85,0.9,.95,1.0)) - quantile(cout.obs$c_out.mg_per_L, c(0.0,0.5,.10,.15,.2,.25,.3,.25,.4,.45,.5,.55,0.6,.65,0.7,.75,0.8,.85,0.9,.95,1.0))
}


# Compute RMSE at every 5th percentile
rmse <- function(y) {
     return(sqrt(mean((y)^2)))
     
}
mse <- function(y) {
  return(mean((y)^2))
  
}

# Compute RMSE and mse of every 0.5th percentile
stats$rmse <- apply(stats[,c("d.0","d.5","d.10","d.15","d.20","d.25","d.30","d.35","d.40","d.45","d.50","d.55","d.60","d.65","d.70","d.75","d.80","d.85","d.90","d.95","d.100")], 1, rmse)
stats$mse <- apply(stats[,c("d.0","d.5","d.10","d.15","d.20","d.25","d.30","d.35","d.40","d.45","d.50","d.55","d.60","d.65","d.70","d.75","d.80","d.85","d.90","d.95","d.100")], 1, mse)

# RANK KS D-statistic
stats$ks.test.D.rank <- rank(stats$ks.test.D)


# RANK RMSE
stats$rmse.rank <- rank(stats$rmse, ties.method="first")
pos_r = which(stats$rmse.rank == 1)
best = stats$rmse[pos_r]
stats$K_rmse <- stats$rmse

#Rank MSE
stats$mse.rank <- rank(stats$mse, ties.method="first")
pos_m = which(stats$mse.rank == 1)
best_m = stats$mse[pos_m]
stats$K_rmse_m <- stats$mse


#############################################################
# Write Out Performance Stats and the Simulated for Excel
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Sort each set out Couts by their magnitude (to help making CDFs in terrible Excel)
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# First - Do the Modeled COUT
cout.sort <- apply(cout.emc.mod,1,sort,decreasing=F)

# Create a data frame to write out
if( dim(wqpars)[1] == 1 ) {

     cout.emc.mod.out <- cbind( stats[,c("ParameterSet","k")], data.frame(NoPar = rep(NA, num.sims)) , stats[,c("ks.test.D.rank", "rmse.rank")] )
     cout.emc.mod.out_mse <- cbind( stats[,c("ParameterSet","k")], data.frame(NoPar = rep(NA, num.sims)) , stats[,c("ks.test.D.rank", "mse.rank")] )
     cout.emc.mod.out_mse <- cbind( cout.emc.mod.out_mse, t(cout.sort) )
     cout.emc.mod.out <- cbind( cout.emc.mod.out, t(cout.sort) )
} else {
     cout.emc.mod.out <- stats[,c("ParameterSet","kprime", "Cstar", "ks.test.D.rank", "rmse.rank")]
     cout.emc.mod.out_mse <- stats[,c("ParameterSet","kprime", "Cstar", "ks.test.D.rank", "mse.rank")]
     cout.emc.mod.out_mse <- cbind( cout.emc.mod.out_mse, t(cout.sort) )
     cout.emc.mod.out <- cbind( cout.emc.mod.out, t(cout.sort) )
}

#RMSE
cout.emc.mod.out <- cout.emc.mod.out[order(cout.emc.mod.out$rmse.rank), ]
firstrow <- cout.emc.mod.out[1,]
# This doesn't work if n.outflows =/= the length of firstrow - 5
# The length of firstrow should originally be 5 + number of trials, I believe
# So for this next line to work it must be n.outflows == num.sims, but how is that assured?
# n.outflows <- length(outflow_start_stop$flag)/2 is how it is defined
# num.sims <- as.numeric(as.character(data_params[1,1]))
# need num.sims == n.outflows
# How do these normally end up lining up?
# I think the outflow threshold needs to be high enough that all of the
# separate inflow events count as separate outflow events.
# The problem in this case (Houston wetland) is that some of the inter-event flows are higher
# than the peak flows for other events.
# So then the question is: can we do away with this n.outflows business?  What does it actually do?
# It has something to do with the cumulative probability--I think we may actually want n_sims
# here and not n.outflows.  Let's see what happens if we do that.
# Old version: replace num.sims with n.outflows
firstrow[1,] <- c("CumPr", rep(NA,4), c(1:num.sims)/num.sims )


cout.emc.mod.out <- rbind(firstrow, cout.emc.mod.out)

#MSE
cout.emc.mod.out_mse <- cout.emc.mod.out_mse[order(cout.emc.mod.out_mse$mse.rank), ]
firstrow_m <- cout.emc.mod.out_mse[1,]
firstrow_m[1,] <- c("CumPr", rep(NA,4), c(1:num.sims)/num.sims )
cout.emc.mod.out_mse <- rbind(firstrow_m, cout.emc.mod.out_mse)



# Now, do observed

obs.ecdf <- ecdf(cout.obs$c_out.mg_per_L)
cout.obs$CumPr <- obs.ecdf(cout.obs$c_out.mg_per_L)
cout.obs <- cout.obs[order(cout.obs$c_out.mg_per_L), ]

cout.obs.out <- t(cout.obs)


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Write out data
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

write.table(stats, file=paste(data_save_path, "SimulationPerformanceStats.csv", sep=""), row.names=F, col.names=T, quote=F, sep=",", append=F)

write.table(cout.emc.mod.out, file=paste(data_save_path, "SimulatedCoutEMCs.csv", sep=""), row.names=F, col.names=T, quote=F, sep=",", append=F)
write.table(cout.emc.mod.out_mse, file=paste(data_save_path, "SimulatedCoutEMCs_mse.csv", sep=""), row.names=F, col.names=T, quote=F, sep=",", append=F)

write.table(cout.obs.out, file=paste(data_save_path, "ObservedCoutEMCs.csv", sep=""), row.names=F, col.names=F, quote=F, sep=",", append=F)

save.image(paste(data_save_path, "R_ParameterCal_Workspace.RData", sep=""))

sink(NULL, type="message")
close(sinkfile)
sink(NULL)


