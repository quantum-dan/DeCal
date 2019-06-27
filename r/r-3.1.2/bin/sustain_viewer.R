# Written beginning June 24, 2019 by Daniel Philippus for the i-DST project
# at the Colorado School of Mines.
#
# This tool is intended to parse and provide graphical views of selected attributes
# of SUSTAIN output.  For the moment, it is not intended to be run as a standalone program,
# but instead to provide functions to be called from the R terminal in support of debugging applications.
# Currently, the column headers are hard-coded for ease of use.  However, this should be changed later,
# and the software is designed to make changing it easy.
#
# SUSTAIN output file format:
# The actual data begins on line 243.  The first 6 columns are Number, Year, Month, Day, Hour, Minute,
# followed by the actual data presumably in the order of the column headers listed.
#
# The column headers go from line 18 to 239 (inclusive).
#
# The column headers are separated by spaces, while the actual data are separated by tabs.
# However, the dates are also separated by spaces.  (??????)
#
# The column headers are as follows:
#
#   TT Volume          BMP volume (ft3)
# TT Stage           Water depth (ft)
# TT Inflow_t        Total inflow (cfs)
# TT Outflow_w       Weir outflow (cfs)
# TT Outflow_o       Orifice or channel outflow (cfs)
# TT Outflow_ud      Underdrain outflow (cfs)
# TT Outflow_ut      Untreated (bypass) outflow (cfs)
# TT Outflow_t       Total outflow (cfs)
# TT Infiltration    Infiltration (cfs)
# TT Perc            Percolation to underdrain storage (cfs)
# TT AET             Evapotranspiration (cfs)
# TT Seepage         Seepage to groundwater (cfs)
# TT Mass_in_1       Mass entering the BMP (lbs)
# TT Mass_w_1        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_1        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_1       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_1       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_1      Mass leaving the BMP (lbs)
# TT Conc_1          Total outflow concentration (mg/l)
# TT Mass_in_2       Mass entering the BMP (lbs)
# TT Mass_w_2        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_2        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_2       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_2       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_2      Mass leaving the BMP (lbs)
# TT Conc_2          Total outflow concentration (mg/l)
# TT Mass_in_3       Mass entering the BMP (lbs)
# TT Mass_w_3        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_3        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_3       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_3       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_3      Mass leaving the BMP (lbs)
# TT Conc_3          Total outflow concentration (mg/l)
# TT Mass_in_4       Mass entering the BMP (lbs)
# TT Mass_w_4        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_4        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_4       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_4       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_4      Mass leaving the BMP (lbs)
# TT Conc_4          Total outflow concentration (mg/l)
# TT Mass_in_5       Mass entering the BMP (lbs)
# TT Mass_w_5        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_5        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_5       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_5       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_5      Mass leaving the BMP (lbs)
# TT Conc_5          Total outflow concentration (mg/l)
# TT Mass_in_6       Mass entering the BMP (lbs)
# TT Mass_w_6        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_6        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_6       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_6       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_6      Mass leaving the BMP (lbs)
# TT Conc_6          Total outflow concentration (mg/l)
# TT Mass_in_7       Mass entering the BMP (lbs)
# TT Mass_w_7        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_7        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_7       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_7       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_7      Mass leaving the BMP (lbs)
# TT Conc_7          Total outflow concentration (mg/l)
# TT Mass_in_8       Mass entering the BMP (lbs)
# TT Mass_w_8        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_8        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_8       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_8       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_8      Mass leaving the BMP (lbs)
# TT Conc_8          Total outflow concentration (mg/l)
# TT Mass_in_9       Mass entering the BMP (lbs)
# TT Mass_w_9        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_9        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_9       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_9       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_9      Mass leaving the BMP (lbs)
# TT Conc_9          Total outflow concentration (mg/l)
# TT Mass_in_10       Mass entering the BMP (lbs)
# TT Mass_w_10        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_10        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_10       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_10       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_10      Mass leaving the BMP (lbs)
# TT Conc_10          Total outflow concentration (mg/l)
# TT Mass_in_11       Mass entering the BMP (lbs)
# TT Mass_w_11        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_11        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_11       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_11       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_11      Mass leaving the BMP (lbs)
# TT Conc_11          Total outflow concentration (mg/l)
# TT Mass_in_12       Mass entering the BMP (lbs)
# TT Mass_w_12        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_12        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_12       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_12       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_12      Mass leaving the BMP (lbs)
# TT Conc_12          Total outflow concentration (mg/l)
# TT Mass_in_13       Mass entering the BMP (lbs)
# TT Mass_w_13        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_13        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_13       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_13       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_13      Mass leaving the BMP (lbs)
# TT Conc_13          Total outflow concentration (mg/l)
# TT Mass_in_14       Mass entering the BMP (lbs)
# TT Mass_w_14        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_14        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_14       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_14       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_14      Mass leaving the BMP (lbs)
# TT Conc_14          Total outflow concentration (mg/l)
# TT Mass_in_15       Mass entering the BMP (lbs)
# TT Mass_w_15        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_15        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_15       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_15       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_15      Mass leaving the BMP (lbs)
# TT Conc_15          Total outflow concentration (mg/l)
# TT Mass_in_16       Mass entering the BMP (lbs)
# TT Mass_w_16        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_16        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_16       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_16       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_16      Mass leaving the BMP (lbs)
# TT Conc_16          Total outflow concentration (mg/l)
# TT Mass_in_17       Mass entering the BMP (lbs)
# TT Mass_w_17        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_17        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_17       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_17       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_17      Mass leaving the BMP (lbs)
# TT Conc_17          Total outflow concentration (mg/l)
# TT Mass_in_18       Mass entering the BMP (lbs)
# TT Mass_w_18        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_18        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_18       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_18       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_18      Mass leaving the BMP (lbs)
# TT Conc_18          Total outflow concentration (mg/l)
# TT Mass_in_19       Mass entering the BMP (lbs)
# TT Mass_w_19        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_19        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_19       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_19       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_19      Mass leaving the BMP (lbs)
# TT Conc_19          Total outflow concentration (mg/l)
# TT Mass_in_20       Mass entering the BMP (lbs)
# TT Mass_w_20        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_20        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_20       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_20       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_20      Mass leaving the BMP (lbs)
# TT Conc_20          Total outflow concentration (mg/l)
# TT Mass_in_21       Mass entering the BMP (lbs)
# TT Mass_w_21        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_21        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_21       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_21       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_21      Mass leaving the BMP (lbs)
# TT Conc_21          Total outflow concentration (mg/l)
# TT Mass_in_22       Mass entering the BMP (lbs)
# TT Mass_w_22        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_22        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_22       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_22       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_22      Mass leaving the BMP (lbs)
# TT Conc_22          Total outflow concentration (mg/l)
# TT Mass_in_23       Mass entering the BMP (lbs)
# TT Mass_w_23        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_23        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_23       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_23       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_23      Mass leaving the BMP (lbs)
# TT Conc_23          Total outflow concentration (mg/l)
# TT Mass_in_24       Mass entering the BMP (lbs)
# TT Mass_w_24        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_24        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_24       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_24       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_24      Mass leaving the BMP (lbs)
# TT Conc_24          Total outflow concentration (mg/l)
# TT Mass_in_25       Mass entering the BMP (lbs)
# TT Mass_w_25        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_25        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_25       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_25       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_25      Mass leaving the BMP (lbs)
# TT Conc_25          Total outflow concentration (mg/l)
# TT Mass_in_26       Mass entering the BMP (lbs)
# TT Mass_w_26        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_26        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_26       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_26       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_26      Mass leaving the BMP (lbs)
# TT Conc_26          Total outflow concentration (mg/l)
# TT Mass_in_27       Mass entering the BMP (lbs)
# TT Mass_w_27        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_27        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_27       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_27       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_27      Mass leaving the BMP (lbs)
# TT Conc_27          Total outflow concentration (mg/l)
# TT Mass_in_28       Mass entering the BMP (lbs)
# TT Mass_w_28        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_28        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_28       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_28       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_28      Mass leaving the BMP (lbs)
# TT Conc_28          Total outflow concentration (mg/l)
# TT Mass_in_29       Mass entering the BMP (lbs)
# TT Mass_w_29        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_29        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_29       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_29       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_29      Mass leaving the BMP (lbs)
# TT Conc_29          Total outflow concentration (mg/l)
# TT Mass_in_30       Mass entering the BMP (lbs)
# TT Mass_w_30        Mass leaving (weir outflow) the BMP (lbs)
# TT Mass_o_30        Mass leaving (orifice outflow) the BMP (lbs)
# TT Mass_ud_30       Mass leaving (underdrain outflow) the BMP (lbs)
# TT Mass_ut_30       Mass bypassing (untreated) the BMP (lbs)
# TT Mass_out_30      Mass leaving the BMP (lbs)
# TT Conc_30          Total outflow concentration (mg/l)

library("dplyr")
library("tidyr")

# The first number in each column name appears to refer to a count of pollutants
columns <- c(
  "BMP volume (ft3)",
  "Water depth (ft)",
  "Total inflow (cfs)",
  "Weir outflow (cfs)",
  "Orifice or channel outflow (cfs)",
  "Underdrain outflow (cfs)",
  "Untreated (bypass) outflow (cfs)",
  "Total outflow (cfs)",
  "Infiltration (cfs)",
  "Percolation to underdrain storage (cfs)",
  "Evapotranspiration (cfs)",
  "Seepage to groundwater (cfs)",
  "1 Mass entering the BMP (lbs)",
  "1 Mass leaving (weir outflow) the BMP (lbs)",
  "1 Mass leaving (orifice outflow) the BMP (lbs)",
  "1 Mass leaving (underdrain outflow) the BMP (lbs)",
  "1 Mass bypassing (untreated) the BMP (lbs)",
  "1 Mass leaving the BMP (lbs)",
  "1 Total outflow concentration (mg/l)",
  "2 Mass entering the BMP (lbs)",
  "2 Mass leaving (weir outflow) the BMP (lbs)",
  "2 Mass leaving (orifice outflow) the BMP (lbs)",
  "2 Mass leaving (underdrain outflow) the BMP (lbs)",
  "2 Mass bypassing (untreated) the BMP (lbs)",
  "2 Mass leaving the BMP (lbs)",
  "2 Total outflow concentration (mg/l)",
  "3 Mass entering the BMP (lbs)",
  "3 Mass leaving (weir outflow) the BMP (lbs)",
  "3 Mass leaving (orifice outflow) the BMP (lbs)",
  "3 Mass leaving (underdrain outflow) the BMP (lbs)",
  "3 Mass bypassing (untreated) the BMP (lbs)",
  "3 Mass leaving the BMP (lbs)",
  "3 Total outflow concentration (mg/l)",
  "4 Mass entering the BMP (lbs)",
  "4 Mass leaving (weir outflow) the BMP (lbs)",
  "4 Mass leaving (orifice outflow) the BMP (lbs)",
  "4 Mass leaving (underdrain outflow) the BMP (lbs)",
  "4 Mass bypassing (untreated) the BMP (lbs)",
  "4 Mass leaving the BMP (lbs)",
  "4 Total outflow concentration (mg/l)",
  "5 Mass entering the BMP (lbs)",
  "5 Mass leaving (weir outflow) the BMP (lbs)",
  "5 Mass leaving (orifice outflow) the BMP (lbs)",
  "5 Mass leaving (underdrain outflow) the BMP (lbs)",
  "5 Mass bypassing (untreated) the BMP (lbs)",
  "5 Mass leaving the BMP (lbs)",
  "5 Total outflow concentration (mg/l)",
  "6 Mass entering the BMP (lbs)",
  "6 Mass leaving (weir outflow) the BMP (lbs)",
  "6 Mass leaving (orifice outflow) the BMP (lbs)",
  "6 Mass leaving (underdrain outflow) the BMP (lbs)",
  "6 Mass bypassing (untreated) the BMP (lbs)",
  "6 Mass leaving the BMP (lbs)",
  "6 Total outflow concentration (mg/l)",
  "7 Mass entering the BMP (lbs)",
  "7 Mass leaving (weir outflow) the BMP (lbs)",
  "7 Mass leaving (orifice outflow) the BMP (lbs)",
  "7 Mass leaving (underdrain outflow) the BMP (lbs)",
  "7 Mass bypassing (untreated) the BMP (lbs)",
  "7 Mass leaving the BMP (lbs)",
  "7 Total outflow concentration (mg/l)",
  "8 Mass entering the BMP (lbs)",
  "8 Mass leaving (weir outflow) the BMP (lbs)",
  "8 Mass leaving (orifice outflow) the BMP (lbs)",
  "8 Mass leaving (underdrain outflow) the BMP (lbs)",
  "8 Mass bypassing (untreated) the BMP (lbs)",
  "8 Mass leaving the BMP (lbs)",
  "8 Total outflow concentration (mg/l)",
  "9 Mass entering the BMP (lbs)",
  "9 Mass leaving (weir outflow) the BMP (lbs)",
  "9 Mass leaving (orifice outflow) the BMP (lbs)",
  "9 Mass leaving (underdrain outflow) the BMP (lbs)",
  "9 Mass bypassing (untreated) the BMP (lbs)",
  "9 Mass leaving the BMP (lbs)",
  "9 Total outflow concentration (mg/l)",
  "10 Mass entering the BMP (lbs)",
  "10 Mass leaving (weir outflow) the BMP (lbs)",
  "10 Mass leaving (orifice outflow) the BMP (lbs)",
  "10 Mass leaving (underdrain outflow) the BMP (lbs)",
  "10 Mass bypassing (untreated) the BMP (lbs)",
  "10 Mass leaving the BMP (lbs)",
  "10 Total outflow concentration (mg/l)",
  "11 Mass entering the BMP (lbs)",
  "11 Mass leaving (weir outflow) the BMP (lbs)",
  "11 Mass leaving (orifice outflow) the BMP (lbs)",
  "11 Mass leaving (underdrain outflow) the BMP (lbs)",
  "11 Mass bypassing (untreated) the BMP (lbs)",
  "11 Mass leaving the BMP (lbs)",
  "11 Total outflow concentration (mg/l)",
  "12 Mass entering the BMP (lbs)",
  "12 Mass leaving (weir outflow) the BMP (lbs)",
  "12 Mass leaving (orifice outflow) the BMP (lbs)",
  "12 Mass leaving (underdrain outflow) the BMP (lbs)",
  "12 Mass bypassing (untreated) the BMP (lbs)",
  "12 Mass leaving the BMP (lbs)",
  "12 Total outflow concentration (mg/l)",
  "13 Mass entering the BMP (lbs)",
  "13 Mass leaving (weir outflow) the BMP (lbs)",
  "13 Mass leaving (orifice outflow) the BMP (lbs)",
  "13 Mass leaving (underdrain outflow) the BMP (lbs)",
  "13 Mass bypassing (untreated) the BMP (lbs)",
  "13 Mass leaving the BMP (lbs)",
  "13 Total outflow concentration (mg/l)",
  "14 Mass entering the BMP (lbs)",
  "14 Mass leaving (weir outflow) the BMP (lbs)",
  "14 Mass leaving (orifice outflow) the BMP (lbs)",
  "14 Mass leaving (underdrain outflow) the BMP (lbs)",
  "14 Mass bypassing (untreated) the BMP (lbs)",
  "14 Mass leaving the BMP (lbs)",
  "14 Total outflow concentration (mg/l)",
  "15 Mass entering the BMP (lbs)",
  "15 Mass leaving (weir outflow) the BMP (lbs)",
  "15 Mass leaving (orifice outflow) the BMP (lbs)",
  "15 Mass leaving (underdrain outflow) the BMP (lbs)",
  "15 Mass bypassing (untreated) the BMP (lbs)",
  "15 Mass leaving the BMP (lbs)",
  "15 Total outflow concentration (mg/l)",
  "16 Mass entering the BMP (lbs)",
  "16 Mass leaving (weir outflow) the BMP (lbs)",
  "16 Mass leaving (orifice outflow) the BMP (lbs)",
  "16 Mass leaving (underdrain outflow) the BMP (lbs)",
  "16 Mass bypassing (untreated) the BMP (lbs)",
  "16 Mass leaving the BMP (lbs)",
  "16 Total outflow concentration (mg/l)",
  "17 Mass entering the BMP (lbs)",
  "17 Mass leaving (weir outflow) the BMP (lbs)",
  "17 Mass leaving (orifice outflow) the BMP (lbs)",
  "17 Mass leaving (underdrain outflow) the BMP (lbs)",
  "17 Mass bypassing (untreated) the BMP (lbs)",
  "17 Mass leaving the BMP (lbs)",
  "17 Total outflow concentration (mg/l)",
  "18 Mass entering the BMP (lbs)",
  "18 Mass leaving (weir outflow) the BMP (lbs)",
  "18 Mass leaving (orifice outflow) the BMP (lbs)",
  "18 Mass leaving (underdrain outflow) the BMP (lbs)",
  "18 Mass bypassing (untreated) the BMP (lbs)",
  "18 Mass leaving the BMP (lbs)",
  "18 Total outflow concentration (mg/l)",
  "19 Mass entering the BMP (lbs)",
  "19 Mass leaving (weir outflow) the BMP (lbs)",
  "19 Mass leaving (orifice outflow) the BMP (lbs)",
  "19 Mass leaving (underdrain outflow) the BMP (lbs)",
  "19 Mass bypassing (untreated) the BMP (lbs)",
  "19 Mass leaving the BMP (lbs)",
  "19 Total outflow concentration (mg/l)",
  "20 Mass entering the BMP (lbs)",
  "20 Mass leaving (weir outflow) the BMP (lbs)",
  "20 Mass leaving (orifice outflow) the BMP (lbs)",
  "20 Mass leaving (underdrain outflow) the BMP (lbs)",
  "20 Mass bypassing (untreated) the BMP (lbs)",
  "20 Mass leaving the BMP (lbs)",
  "20 Total outflow concentration (mg/l)",
  "21 Mass entering the BMP (lbs)",
  "21 Mass leaving (weir outflow) the BMP (lbs)",
  "21 Mass leaving (orifice outflow) the BMP (lbs)",
  "21 Mass leaving (underdrain outflow) the BMP (lbs)",
  "21 Mass bypassing (untreated) the BMP (lbs)",
  "21 Mass leaving the BMP (lbs)",
  "21 Total outflow concentration (mg/l)",
  "22 Mass entering the BMP (lbs)",
  "22 Mass leaving (weir outflow) the BMP (lbs)",
  "22 Mass leaving (orifice outflow) the BMP (lbs)",
  "22 Mass leaving (underdrain outflow) the BMP (lbs)",
  "22 Mass bypassing (untreated) the BMP (lbs)",
  "22 Mass leaving the BMP (lbs)",
  "22 Total outflow concentration (mg/l)",
  "23 Mass entering the BMP (lbs)",
  "23 Mass leaving (weir outflow) the BMP (lbs)",
  "23 Mass leaving (orifice outflow) the BMP (lbs)",
  "23 Mass leaving (underdrain outflow) the BMP (lbs)",
  "23 Mass bypassing (untreated) the BMP (lbs)",
  "23 Mass leaving the BMP (lbs)",
  "23 Total outflow concentration (mg/l)",
  "24 Mass entering the BMP (lbs)",
  "24 Mass leaving (weir outflow) the BMP (lbs)",
  "24 Mass leaving (orifice outflow) the BMP (lbs)",
  "24 Mass leaving (underdrain outflow) the BMP (lbs)",
  "24 Mass bypassing (untreated) the BMP (lbs)",
  "24 Mass leaving the BMP (lbs)",
  "24 Total outflow concentration (mg/l)",
  "25 Mass entering the BMP (lbs)",
  "25 Mass leaving (weir outflow) the BMP (lbs)",
  "25 Mass leaving (orifice outflow) the BMP (lbs)",
  "25 Mass leaving (underdrain outflow) the BMP (lbs)",
  "25 Mass bypassing (untreated) the BMP (lbs)",
  "25 Mass leaving the BMP (lbs)",
  "25 Total outflow concentration (mg/l)",
  "26 Mass entering the BMP (lbs)",
  "26 Mass leaving (weir outflow) the BMP (lbs)",
  "26 Mass leaving (orifice outflow) the BMP (lbs)",
  "26 Mass leaving (underdrain outflow) the BMP (lbs)",
  "26 Mass bypassing (untreated) the BMP (lbs)",
  "26 Mass leaving the BMP (lbs)",
  "26 Total outflow concentration (mg/l)",
  "27 Mass entering the BMP (lbs)",
  "27 Mass leaving (weir outflow) the BMP (lbs)",
  "27 Mass leaving (orifice outflow) the BMP (lbs)",
  "27 Mass leaving (underdrain outflow) the BMP (lbs)",
  "27 Mass bypassing (untreated) the BMP (lbs)",
  "27 Mass leaving the BMP (lbs)",
  "27 Total outflow concentration (mg/l)",
  "28 Mass entering the BMP (lbs)",
  "28 Mass leaving (weir outflow) the BMP (lbs)",
  "28 Mass leaving (orifice outflow) the BMP (lbs)",
  "28 Mass leaving (underdrain outflow) the BMP (lbs)",
  "28 Mass bypassing (untreated) the BMP (lbs)",
  "28 Mass leaving the BMP (lbs)",
  "28 Total outflow concentration (mg/l)",
  "29 Mass entering the BMP (lbs)",
  "29 Mass leaving (weir outflow) the BMP (lbs)",
  "29 Mass leaving (orifice outflow) the BMP (lbs)",
  "29 Mass leaving (underdrain outflow) the BMP (lbs)",
  "29 Mass bypassing (untreated) the BMP (lbs)",
  "29 Mass leaving the BMP (lbs)",
  "29 Total outflow concentration (mg/l)",
  "30 Mass entering the BMP (lbs)",
  "30 Mass leaving (weir outflow) the BMP (lbs)",
  "30 Mass leaving (orifice outflow) the BMP (lbs)",
  "30 Mass leaving (underdrain outflow) the BMP (lbs)",
  "30 Mass bypassing (untreated) the BMP (lbs)",
  "30 Mass leaving the BMP (lbs)",
  "30 Total outflow concentration (mg/l)"
)

PATH <- file.path("Z:", "adit", "Desktop", "i-DST", "DeCal", "IrisRG8", "SUSTAIN", "Output", "Init_BMP_1.out")

getData <- function(path = PATH, skip=242, headers = columns, times = F) {
  # Read data from the given path.
  timeCols <- c("N - Year - Month - Day - Hour - Minute")
  # The time columns aren't listed with the headers
  headers <- if (!times) c(timeCols, headers) else headers
  data <- as_tibble(read.delim(path, header = FALSE, skip=skip))
  colnames(data) <- headers
  data
}

cleanData <- function(data = getData()) {
  # Rearrange data so that the pollutant number is a column instead of part
  # of the column headers.  Data goes (for example) from 50,000 rows and 223 variables to
  # 1.5 million rows and 21 variables.
  data %>%
    gather(
      pollutant, quantity,
      -(1:`Seepage to groundwater (cfs)`)
    ) %>%
    separate(
      pollutant, c("Pollutant #", "Characteristic"),
      sep = " ", extra="merge"
    ) %>%
    spread(
      Characteristic, quantity
    )
}

ratioRemaining <- function(data, output, input) {
  # Plot the CDF of a ratio of output to input
  # enquo and !! allow passing in different column headers
  output <- enquo(output)
  input <- enquo(input)
  ratio <- data %>%
    mutate(ratio = (!! output) / (!! input)) %>%
    filter(is.finite(ratio)) # 0-input isn't terribly useful here, so just ignore it.
  ecdf(ratio$ratio) %>% plot
}

pollutantRatio <- function(data = cleanData()) {
  ratioRemaining(
    data,
    `Mass leaving the BMP (lbs)`,
    `Mass entering the BMP (lbs)`
  )
}

pollutantRemaining <- function(data = cleanData(), specific = T, pollutant = "1") {
  # CDF of concentration of pollutant remaining.  If specific, just one pollutant.
  data <- if (!specific) data else filter(data, `Pollutant #` == pollutant)
  ecdf(data$`Total outflow concentration (mg/l)`) %>% plot
}

volumeRatio <- function(data = cleanData()) {
  ratioRemaining(
    data,
    `Total outflow (cfs)`,
    `Total inflow (cfs)`
  )
}