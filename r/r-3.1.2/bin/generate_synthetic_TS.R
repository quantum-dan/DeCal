#############################################################
# INTRO
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# This R Script generates synthetic time series of:
#    1 - Inflow Water Volume to a BMP
#    2 - Inflow Polluntant Mass io a BMP
# Inputs are:
#    1 - Observed, composite inflow volumes [L]
#    2 - Observed, composite inflow concentrations [mg/L] 
#    3 - Observed sub-houlry precipitation:
#         3.1 - Date/Times
#         3.2 - Precip Depth [mm]
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---




#############################################################
# PARSE WORKING DIRECTORY [FOR PCs] AND MODEL PARAMETERS
# FROM INPUT ARG 
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
wd = getwd()
args <- commandArgs(TRUE)
#wd = '/Users/cross/Desktop/Water_modeling_copy/R/R-3.1.2/bin'
csv_path = file.path(args[1],"/params.csv")
data_params_wdir = read.csv(csv_path,header = F)
wdir = as.character(data_params_wdir[1,1])
wdir <- gsub("\\\\","\\/", wdir)
data_params = read.csv(csv_path,header = T)
save_folder<-as.character(data_params_wdir[7,1])
main_save_path<-file.path(wdir,save_folder)
plot_save_path<-paste(main_save_path,"/plots/",sep="")
data_save_path<-paste(main_save_path,"/data/",sep="")
#wdir <- as.character(commandArgs(trailingOnly=T)[1])


# Why are these defined separately from above?  No idea.
Rdir <- paste(wdir, "/R/", sep="") 
Rinput_dir <- data_save_path
Routput_dir <- plot_save_path

SUSTAIN_dir <- paste(wdir, "/SUSTAIN/", sep="")
SUSTAINinput_dir <- paste(main_save_path, "/SUSTAIN/InputTSFiles/", sep="") 


sinkfile <- file(paste(main_save_path, "/R_TSGeneration_Errors.txt"), open="wt")
sink(sinkfile, type="message")    # This will also redirect error output to the file, making things easier to debug
sink(paste(main_save_path, "/R_TSGeneration_Messages.txt", sep=""), append=F,type="output")

num = as.numeric(as.character(data_params[3,1]))
n_sims = as.numeric(as.character(data_params[1,1]))
min.p = as.numeric(as.character(data_params[2,1]))
# THIS IS IN HERE NOW FOR DEVELOPMENT
# Rdir <- "/Users/colinbell/Dropbox/Documents/EPA i-DST/WQ_Utility/R/"
# Rinput_dir <- paste(Rdir, "R_GeneratedInputFiles/", sep="") 
# Routput_dir <- paste(Rdir, "R_OutputFiles/", sep="") 
#SUSTAIN_dir <- "/Users/colinbell/Dropbox/Documents/EPA i-DST/WQ_Utility/SUSTAIN/"
#SUSTAINinput_dir <- paste(SUSTAIN_dir, "TSInputFiles/", sep="") 

# Time before "new" event starts [hr]
#time.new <- as.numeric(commandArgs(trailingOnly=T)[4]) # default = 6 based of Driscoll et. al, 1989

time.new <- as.numeric(data_params[5,1]) # default = 6 based of Driscoll et. al, 1989
time.new <- time.new*60

# Minimum precip total to consider [in]
#min.p <- as.numeric(commandArgs(trailingOnly=T)[3]) # 0.1 based on Bell et al 2016

# Number of events
#num <- as.numeric(commandArgs(trailingOnly=T)[2])


# Number of simulations
#n_sims <- as.numeric(commandArgs(trailingOnly=T)[5])


#############################################################
# Load necessary functions/packages
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---


if(!require("fitdistrplus")){
  install.packages("fitdistrplus",repos = "http://cran.us.r-project.org")  
}
library("fitdistrplus")

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Function to fit distribution
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
fit_and_pick_dist <- function (dat) {
  
  #fg  <- try(fitdist(dat, "gamma", lower=c(0.01,0.01), start = list(scale = 1, shape = 1)))
  #if(class(fg)=="try-error"){
  #  next
  #}
  #else{
  #  fg<-fitdist(dat, "gamma", lower=c(0.01,0.01), start = list(scale = 1, shape = 1))
  #}
  fln <- fitdist(dat, "lnorm", method="mme")
 # fw  <- try(fitdist(dat, "weibull", lower=c(0.01,0.01), start = list(scale = 1, shape = 1)))
  #if(class(fw)=="try-error"){
   # next
 # }
 # else{
  #  fw<-fitdist(dat, "weibull", lower=c(0.01,0.01), start = list(scale = 1, shape = 1))
 # }
  fe  <- fitdist(dat, "exp", method="mme")
  fn  <- fitdist(dat, "norm", method="mme")
  #"weibull", fw$aic,"gamma",fg$aic,
  aics <- data.frame(model = c("lnorm","exp","norm"), aic=c( fln$aic, fe$aic,fn$aic))
  chosen.model <- aics$model[which.min(aics$aic)]
  
  if(chosen.model == "gamma"){
    return(fg)
  } else if (chosen.model == "lnorm"){
    return(fln)
  } else if (chosen.model == "weibull"){
    return(fw)
  } else if (chosen.model == "exp"){
    return(fe)
  } else if (chosen.model == "norm"){
    return(fn)
  }
  
}

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Function to generate value from any distribution
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
generate_from_dist <- function (dist, num) {
  
  if (dist$distname == "gamma") {
    values <- rgamma(num, shape=dist$estimate[2], scale=dist$estimate[1])
  } else if( dist$distname == "lnorm") {
    values <- rlnorm(num, meanlog=dist$estimate[1], sdlog=dist$estimate[2])
  } else if (dist$distname == "weibull") {
    values <- rweibull(num, shape=dist$estimate[2], scale=dist$estimate[1])
  } else if(dist$distname == "exp") {
    values <- rexp(num, rate=dist$estimate[1])
  } else if(dist$distname == "norm") {
    values <- rnorm(num, mean=dist$estimate[1], sd=dist$estimate[2])
  }
  
  return(values)
  
}


#############################################################
# ANALYZE RAINFALL FOR INTERARRIVAL TIME 
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# READ IN TIME SERIES RAINFALL DATA
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
p.sub.long <- data.frame(ppt.dt = read.csv(file=paste(Rinput_dir, "ppt_dt.csv", sep=""), header=T), ppt.in = read.csv(file=paste(Rinput_dir, "ppt.csv", sep=""), header=T))
p.sub.long$ppt.in <- as.numeric(as.character(p.sub.long$ppt.in))
p.sub.long$ppt.dt <- as.POSIXct(p.sub.long$ppt.dt, format="%m/%d/%Y %H:%M:%S")
p.sub <- subset(p.sub.long, ppt.in>0)



# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Find number, size, length, interarrival period of events
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# Find time bvetween each observed rainfall
p.sub$deltat <- c(as.vector(diff(p.sub$ppt.dt)) ,NA)

# If the "time.new" has ellpased without rain, then flag this as the start of an event
p.sub$start.fl<-ifelse(p.sub$deltat<=time.new, 0, 1 )
p.sub$start.fl <- c(1,p.sub$start.fl[-length(p.sub$start.fl)])
p.sub$eventno <- cumsum(p.sub$start.fl)

# initialize independent event data frame
p.sub.events <- subset(p.sub, start.fl==1)[,c(1,2,4)]
colnames(p.sub.events) <- c("start", "end","totalp_in")

# Compute total rainfall for each individual event
for(i in seq(1:length(p.sub.events$totalp_in))) {
  p.tmp <- subset(p.sub, eventno==i)
  p.sub.events$end[i] <- max(p.tmp$ppt.dt)
  p.sub.events$totalp_in[i] <- sum(p.tmp$ppt.in)
}
p.sub.events$end <- as.POSIXct(p.sub.events$end, origin="1970-01-01")
p.sub.events.all <- p.sub.events

# Filter out event only > specified depth (min.p)
p.sub.events <- subset(p.sub.events,totalp_in>=min.p)

# Compute length of each event
p.sub.events$duration_min <- as.numeric((p.sub.events$end-p.sub.events$start)) # must add five minutes for first sampling window

# Compute interarrival time of each event
p.sub.events$iet_hr <- c(NA, p.sub.events$start[-1]-p.sub.events$end[-length(p.sub.events$end)])


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Fit a distribution through the interarrival times
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# Pull out interarrival times
iets <- data.frame(iet_hr=sort(p.sub.events$iet_hr[-1]), rank=c(1:length(p.sub.events$iet_hr[-1])))
iets$iet_hr <- iets$iet_hr - (time.new/60) # remove built-in minmum time
iets <- iets[iets$iet_hr > 0, ] # Sometimes there are 0 gaps for some reason, which breaks the fit function
iets$p <- iets$rank/max(iets$rank)

# Identify and fit the best distribution
plot(iets$iet_hr)

iet.dist <- fit_and_pick_dist(iets$iet_hr)

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Make a simple plot for user
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --
graphics.off()
pdf(file=paste(plot_save_path,"InterArrivalTimeDistributionFit.pdf", sep=""), height=6, width=6)
dev.set(2)
par(mfrow = c(2, 2))
plot.legend <- c(iet.dist$distname)
denscomp(list(iet.dist), legendtext = plot.legend)
qqcomp(list(iet.dist), legendtext = plot.legend)
cdfcomp(list(iet.dist), legendtext = plot.legend)
ppcomp(list(iet.dist), legendtext = plot.legend)
graphics.off()



#############################################################
# INFLOW VOLUME
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# READ IN VOLUME
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
vol.obs <- read.csv(file=paste(Rinput_dir, "v_in.csv", sep=""), header=T)

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Fit a distribution through the inflow volumes
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
vol.dist <- fit_and_pick_dist(vol.obs$v_in.cf)


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Make a simple plot for user
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
graphics.off()
pdf(file=paste(plot_save_path,"VolumeDistributionFit.pdf", sep=""), height=6, width=6)
dev.set(2)
par(mfrow = c(2, 2))
plot.legend <- c(vol.dist$distname)
denscomp(list(vol.dist), legendtext = plot.legend)
qqcomp(list(vol.dist), legendtext = plot.legend)
cdfcomp(list(vol.dist), legendtext = plot.legend)
ppcomp(list(vol.dist), legendtext = plot.legend)
graphics.off()




#############################################################
# INFLOW DURATION
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# READ IN DURATIONS
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
dur <- read.csv(file=paste(Rinput_dir, "dur.csv", sep=""), header=T)


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Fit a distribution through the interarrival times
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
dur.dist <- fit_and_pick_dist(dur$dur.min)


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Make a simple plot for user
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
graphics.off()
pdf(file=paste(plot_save_path,"DurationDistributionFit.pdf", sep=""), height=6, width=6)
dev.set(2)
par(mfrow = c(2, 2))
plot.legend <- c(dur.dist$distname)
denscomp(list(dur.dist), legendtext = plot.legend)
qqcomp(list(dur.dist), legendtext = plot.legend)
cdfcomp(list(dur.dist), legendtext = plot.legend)
ppcomp(list(dur.dist), legendtext = plot.legend)
graphics.off()






#############################################################
# INFLOW Cin
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# READ IN Cin
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
cin <- read.csv(file=paste(Rinput_dir, "c_in.csv", sep=""), header=T)


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Fit a distribution through the Cin
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
cin.dist <- fit_and_pick_dist(cin$c_in.mg_per_L)


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Make a simple plot for user
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
graphics.off()
pdf(file=paste(plot_save_path,"CinDistributionFit.pdf", sep=""), height=6, width=6)
dev.set(2)
par(mfrow = c(2, 2))
plot.legend <- c(cin.dist$distname)
denscomp(list(cin.dist), legendtext = plot.legend)
qqcomp(list(cin.dist), legendtext = plot.legend)
cdfcomp(list(cin.dist), legendtext = plot.legend)
ppcomp(list(cin.dist), legendtext = plot.legend)
graphics.off()





#############################################################
# GENERATE INFLOW TIMES SERIES
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Generate Synthetic Events
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Volume rounded to nearest cubic found
# Interperiod rounded to nearest hour
# Duration rounded to nearest 5 minutes
# Concentration not rounded (may be sensitive to the units used)
syn.events <- data.frame(volume=round(generate_from_dist(vol.dist, num)), interperiod=round( generate_from_dist(iet.dist, num) + time.new/60), duration=5*round(generate_from_dist(dur.dist, num)/5), c.in=generate_from_dist(cin.dist, num))

syn.events$hrly.cumsum <- c(0,cumsum(syn.events$interperiod)[-length(syn.events$interperiod)])+1

total_time_min <- sum(syn.events$interperiod)*60 + tail(syn.events$duration, 1) + 5*24*60 # add 5 days at the end

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Write Table of Synthetic Events to .csv File
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
events.out <- syn.events[,c("volume","interperiod","duration","c.in")]
colnames(events.out) <- c("v_in.cf", "inter_arrival_time.hr", "dur.min", "c_in.mg_per_L")
write.table(events.out, file=paste(data_save_path, "SyntheticEventsSummary.csv", sep=""), row.names=F, sep=",")




fivemin_flag = 1
onehr_flag = 1





if(fivemin_flag == 1) {
  
  
  
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  # Generate Time Series
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  # Starts on 10/1/2000 [which doesn't really matter - its synthetic after all]
  syn.ts.in <- data.frame(datetime=seq(from=as.POSIXct("2000-10-01 0:00"), to=as.POSIXct("2000-10-01 0:00")+total_time_min*60, by="5 min"))
  
  
  for(i in seq(1:num)) {
    # Somehow n_5mins is sometimes ending up negative, which obviously doesn't work.
    # It looks like generate_from_dist occasionally produces negative values?
    # Should there ever legitimately be negative values?
    n_5mins <- syn.events$duration[i]/5
    print(n_5mins)
    # This should work if negative values are never legitimate.
    n_5mins <- if (n_5mins > 0) n_5mins else 0
    event.tmp <- rep(NA, n_5mins)
    # IF EVEN 
    if( floor(n_5mins/2) - (n_5mins/2) ==  0){
      n.fragments <- n_5mins/2 * (n_5mins/2 + 1)
      q.fragment <- syn.events$volume[i]/n.fragments
      for(ii in seq(1:(n_5mins/2))){
        event.tmp[ii] <- ii * q.fragment
        event.tmp[n_5mins-ii+1] <-  ii * q.fragment
      }
      #IF ODD
    } else {
      n_5mins.ceil <- ceiling(n_5mins/2)
      n_5mins.floor <- floor(n_5mins/2)
      n.frag.left <-  (n_5mins.ceil * (n_5mins.ceil + 1) )/2
      n.frag.right <-  (n_5mins.floor * (n_5mins.floor + 1) )/2
      n.fragments <- n.frag.left + n.frag.right
      q.fragment <- syn.events$volume[i]/n.fragments
      for(ii in seq(1:n_5mins.ceil)){
        event.tmp[ii] <- ii * q.fragment
        event.tmp[n_5mins-ii+1] <-  ii * q.fragment
      }
    }
    
    
    syn.ts.in[,(2+(i+-1)*2) ] <- rep(0,length(syn.ts.in$datetime))
    syn.ts.in[,(3+(i+-1)*2) ] <- rep(0,length(syn.ts.in$datetime))
    
    
    ts.range <- c(syn.events$hrly.cumsum[i]*60/5, syn.events$hrly.cumsum[i]*(60/5)+n_5mins-1) 
    syn.ts.in[ ts.range[1]:ts.range[2] , 2+(i-1)*2] <- event.tmp
    syn.ts.in[ ts.range[1]:ts.range[2] , 3+(i-1)*2] <- syn.events$c.in[i]
    
    
    colnames(syn.ts.in)[(2+(i+-1)*2)] <- c(paste("event",i,"vol_cf",sep="_"))
    colnames(syn.ts.in)[(3+(i+-1)*2)] <- c(paste("event",i,"cin_mg.per.L",sep="_"))
    
  }
  
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  # Combine all individual events into a single time series
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  
  # In the event that two events over lap: sum the flow, take the average of the concentration
  syn.ts.in$v_in.cf <- rowSums(syn.ts.in[,seq(from=2,to=(dim(syn.ts.in)[2]-1),by=2)])
  multiple_cin_flag <- apply(syn.ts.in[,seq(from=3,to=(dim(syn.ts.in)[2]),by=2)], 1, function(x) length( which(x  != 0 ) ) )
  syn.ts.in$c_in.mg_per_L <- rowSums(syn.ts.in[,seq(from=3,to=(dim(syn.ts.in)[2]),by=2)]) / multiple_cin_flag
  syn.ts.in$c_in.mg_per_L[is.na(syn.ts.in$c_in.mg_per_L)] <- 0
  syn.ts.in$datetime = seq(from=syn.ts.in$datetime[1], length=length(syn.ts.in$datetime), by="5 min")
  
  syn.ts <- syn.ts.in[,c(1,dim(syn.ts.in)[2]-1,dim(syn.ts.in)[2])]
  
  
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  # Make a simple plot for the user [limit to first 3 months]
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  syn.ts.plot <- subset(syn.ts, syn.ts$datetime < as.POSIXct("2001-01-01 0:00"))
  syn.ts.plot$c_in.mg_per_L <- ifelse(syn.ts.plot$c_in.mg_per_L == 0, NA, syn.ts.plot$c_in.mg_per_L)
  graphics.off()
  pdf(file=paste(plot_save_path,"SyntheticTS_First3months.pdf", sep=""), height=3, width=6)
  dev.set(2)
  par(mar=c(2,3,0.5,3))
  plot(y=(syn.ts.plot$v_in.cf+0.1)/5/60, x=syn.ts.plot$datetime, type="l", log='y', xaxt='n', ylab="", xlab="")
  axis(side=1, at = c(as.POSIXct("2000-10-01 0:00"), as.POSIXct("2000-10-15 0:00"), as.POSIXct("2000-11-01 0:00"), as.POSIXct("2000-11-15 0:00"), as.POSIXct("2000-12-01 0:00"), as.POSIXct("2000-12-15 0:00") , as.POSIXct("2000-12-31 0:00") ), labels = c("10/1", "10/15", "11/1", "11/15", "12/1", "12/15", "12/31"))
  mtext(side=2, line=2, "Inflow [cfs]")
  par(new=T)
  plot(y=(syn.ts.plot$c_in.mg_per_L), x=syn.ts.plot$datetime, col='red', pch=16, cex=0.55, xaxt='n', yaxt='n', ylab="", xlab="")
  axis(side=4)
  mtext(side=4, line=2, "Cin [mg/L]")
  graphics.off()
  
  
  
  
  #############################################################
  # CREATE SUSTAIN TIME SERIES FILE
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    sustain_out <- data.frame(TT=rep(1,length(syn.ts$datetime)), year = format(syn.ts$datetime, format="%Y"), month = format(syn.ts$datetime, format="%m"), day = format(syn.ts$datetime, format="%d"), hour = format(syn.ts$datetime, format="%H"), minute = format(syn.ts$datetime, format="%M"), flow = formatC( (syn.ts$v_in.cf*0.00027548), format="e", digits=3), recharge=rep(0,length(syn.ts$v_in.cf)), mass.lb = formatC( (syn.ts$c_in.mg_per_L * 28.3168 * 2.20462e-6 * syn.ts$v_in.cf), format="e", digits=3) )
  if(n_sims > 1){
    sustain_out[,(10:(n_sims+8))] <- sustain_out$mass.lb
  }
  
  
  write.table(c("TT"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=F)
  write.table(c("TT Column Headers:"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT WATERSHED ID (default is 1)"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT YEAR"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT MONTH"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT DAY"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT HOUR"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT MINUTE"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT SURO     surface outflow volume (acre*in/timestep)"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT AGWI     groundwater recharge volume (acre*in/timestep)"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  #write.table(c("TT SOSED    sediments load from land (tons/timestep)"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT SOQUAL   surface flux of QUAL (lb/timestep) - repeats for the number of Monte Carlo simulations specified"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(data.frame(TT="TT", DT="Date/Time"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT"), file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(sustain_out, file=paste(SUSTAINinput_dir, "LU_Input_TS_5min.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  
  #############################################################
  # CREATE A TEXT FILE WITH THE LAST SIMULATION DAY
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  cat(paste(format(tail(syn.ts$datetime,1), format="%Y"), format(tail(syn.ts$datetime,1), format="%m"), format(tail(syn.ts$datetime,1), format="%d"), sep='\t'), file=paste(SUSTAINinput_dir, "SimulationEndDate_5min.txt", sep=""))
  
  
}






if( onehr_flag == 1) {
  
  
  
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  # Generate Time Series
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  # Starts on 10/1/2000 [which doesn't really matter - its synthetic after all]
  syn.ts.in <- data.frame(datetime=seq(from=as.POSIXct("2000-10-01 0:00"), to=as.POSIXct("2000-10-01 0:00")+total_time_min*60, by="1 hour"))
  
  
  for(i in seq(1:num)) {
    nhrs <- max(round(syn.events$duration[i]/60),1)
    event.tmp <- rep(NA, nhrs)
    
    #IF EVEN
    if( floor(nhrs/2) - (nhrs/2) ==  0){
      n.fragments <- nhrs/2 * (nhrs/2 + 1)
      q.fragment <- syn.events$volume[i]/n.fragments
      for(ii in seq(1:(nhrs/2))){
        event.tmp[ii] <- ii * q.fragment
        event.tmp[nhrs-ii+1] <-  ii * q.fragment
      }
      #IF ODD
    } else {
      nhrs.ceil <- ceiling(nhrs/2)
      nhrs.floor <- floor(nhrs/2)
      n.frag.left <-  (nhrs.ceil * (nhrs.ceil + 1) )/2
      n.frag.right <-  (nhrs.floor * (nhrs.floor + 1) )/2
      n.fragments <- n.frag.left + n.frag.right
      q.fragment <- syn.events$volume[i]/n.fragments
      for(ii in seq(1:nhrs.ceil)){
        event.tmp[ii] <- ii * q.fragment
        event.tmp[nhrs-ii+1] <-  ii * q.fragment
      }
    }
    
    
    
    syn.ts.in[,(2+(i+-1)*2) ] <- rep(0,length(syn.ts.in$datetime))
    syn.ts.in[,(3+(i+-1)*2) ] <- rep(0,length(syn.ts.in$datetime))
    
    
    ts.range <- c(syn.events$hrly.cumsum[i], syn.events$hrly.cumsum[i]+nhrs-1) 
    syn.ts.in[ ts.range[1]:ts.range[2] , 2+(i-1)*2] <- event.tmp
    syn.ts.in[ ts.range[1]:ts.range[2] , 3+(i-1)*2] <- syn.events$c.in[i]
    
    
    colnames(syn.ts.in)[(2+(i+-1)*2)] <- c(paste("event",i,"vol_cf",sep="_"))
    colnames(syn.ts.in)[(3+(i+-1)*2)] <- c(paste("event",i,"cin_mg.per.L",sep="_"))
    
  }
  
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  # Combine all individual events into a single time series
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  
  # In the event that two events over lap: sum the flow, take the average of the concentration
  syn.ts.in$v_in.cf <- rowSums(syn.ts.in[,seq(from=2,to=(dim(syn.ts.in)[2]-1),by=2)])
  multiple_cin_flag <- apply(syn.ts.in[,seq(from=3,to=(dim(syn.ts.in)[2]),by=2)], 1, function(x) length( which(x  != 0 ) ) )
  syn.ts.in$c_in.mg_per_L <- rowSums(syn.ts.in[,seq(from=3,to=(dim(syn.ts.in)[2]),by=2)]) / multiple_cin_flag
  syn.ts.in$c_in.mg_per_L[is.na(syn.ts.in$c_in.mg_per_L)] <- 0
  syn.ts.in$datetime = seq(from=syn.ts.in$datetime[1], length=length(syn.ts.in$datetime), by="1 hour")
  
  syn.ts <- syn.ts.in[,c(1,dim(syn.ts.in)[2]-1,dim(syn.ts.in)[2])]
  
  
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  # Make a simple plot for the user [limit to first 3 months]
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  syn.ts.plot <- subset(syn.ts, syn.ts$datetime < as.POSIXct("2001-01-01 0:00"))
  syn.ts.plot$c_in.mg_per_L <- ifelse(syn.ts.plot$c_in.mg_per_L == 0, NA, syn.ts.plot$c_in.mg_per_L)
  graphics.off()
  pdf(file=paste(plot_save_path,"SyntheticTS_First3months_hrly.pdf", sep=""), height=3, width=6)
  dev.set(2)
  par(mar=c(2,3,0.5,3))
  plot(y=(syn.ts.plot$v_in.cf+0.1)/5/60, x=syn.ts.plot$datetime, type="l", log='y', xaxt='n', ylab="", xlab="")
  axis(side=1, at = c(as.POSIXct("2000-10-01 0:00"), as.POSIXct("2000-10-15 0:00"), as.POSIXct("2000-11-01 0:00"), as.POSIXct("2000-11-15 0:00"), as.POSIXct("2000-12-01 0:00"), as.POSIXct("2000-12-15 0:00") , as.POSIXct("2000-12-31 0:00") ), labels = c("10/1", "10/15", "11/1", "11/15", "12/1", "12/15", "12/31"))
  mtext(side=2, line=2, "Inflow [cfs]")
  par(new=T)
  plot(y=(syn.ts.plot$c_in.mg_per_L), x=syn.ts.plot$datetime, col='red', pch=16, cex=0.55, xaxt='n', yaxt='n', ylab="", xlab="")
  axis(side=4)
  mtext(side=4, line=2, "Cin [mg/L]")
  graphics.off()
  
  
  
  
  #############################################################
  # CREATE SUSTAIN TIME SERIES FILE
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  
  
  sustain_out <- data.frame(TT=rep(1,length(syn.ts$datetime)), year = format(syn.ts$datetime, format="%Y"), month = format(syn.ts$datetime, format="%m"), day = format(syn.ts$datetime, format="%d"), hour = format(syn.ts$datetime, format="%H"), minute = format(syn.ts$datetime, format="%M"), flow = formatC( (syn.ts$v_in.cf*0.00027548), format="e", digits=3), recharge=rep(0,length(syn.ts$v_in.cf), format="e", digits=3), mass.lb = formatC( (syn.ts$c_in.mg_per_L * 28.3168 * 2.20462e-6 * syn.ts$v_in.cf), format="e", digits=3) )
  if(n_sims > 1){
    sustain_out[,(10:(n_sims+8))] <- sustain_out$mass.lb
  }
  
  
  write.table(c("TT"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=F)
  write.table(c("TT Column Headers:"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT WATERSHED ID (default is 1)"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT YEAR"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT MONTH"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT DAY"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT HOUR"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT MINUTE"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT SURO     surface outflow volume (acre*in/timestep)"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT AGWI     groundwater recharge volume (acre*in/timestep)"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  #write.table(c("TT SOSED    sediments load from land (tons/timestep)"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT SOQUAL   surface flux of QUAL (lb/timestep) - repeats for the number of Monte Carlo simulations specified"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(data.frame(TT="TT", DT="Date/Time"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  write.table(c("TT"), file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  #for(i in seq(1:nrow(sustain_out))) {
  #  write.table(sustain_out[i,], file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  #}
  write.table(sustain_out, file=paste(SUSTAINinput_dir, "LU_Input_TS.prn", sep=""), row.names=F, col.names=F, quote=F, sep="\t", append=T)
  
  #############################################################
  # CREATE A TEXT FILE WITH THE LAST SIMULATION DAY
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  cat(paste(format(tail(syn.ts$datetime,1), format="%Y"), format(tail(syn.ts$datetime,1), format="%m"), format(tail(syn.ts$datetime,1), format="%d"), sep='\t'), file=paste(SUSTAINinput_dir, "SimulationEndDate.txt", sep=""))
  
  
}
save.image(paste(data_save_path, "generate_synthetic_TS_RWorkspace.RData", sep=""))

close(sinkfile)
sink(NULL)

