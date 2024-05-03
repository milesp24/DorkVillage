library(dplyr)
library(tibble)
library(stats)
library(tidyr)
library(readr)
library(readxl)
library(ggplot2)
#Loading various packages I may need at some point

# When getting tables from Sports Reference, export to Excel then save as .csv
pads_history <- readr::read_csv(file = "Padres_History.csv")

#Cleaning imported table with piped functions
colnames(pads_history)
pads_history <- rename(.data = pads_history, 
       Division = Lg, 
       PlayoffResult = Playoffs, 
       Runs = R,
       RunsAgainst = RA,
       TotAttendance = Attendance
       ) %>%
 select(-Tm, -Division) 

#Very Basic plot for regular season wins by season
ggplot() +
  geom_line(data = pads_history, aes(x = Year, y = W))+
  xlab("Year")+
  ylab("Wins in Regular Season")+
  ylim(c(0,162))+
  theme_bw()
  
