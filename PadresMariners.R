# Load Packages
library(tibble)
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)

# Importing Data - Team history pages for San Diego Padres and Seattle 
# Mariners from Baseball Reference
pads_history <- readr::read_csv(file = "Padres_History.csv")
ms_history <- readr::read_csv(file = "Mariners_History.csv")

# Combining team history data frames + Data Cleaning
combined_history <- dplyr::bind_rows(pads_history, ms_history)

combined_history <- rename(.data = combined_history,
                           Division = Lg,
                           Runs = R,
                           RunsAllowed = RA)

# Univariate Data Plots

# Single Season W-L%
ggplot(data = combined_history,
       mapping = aes(x = WLpct, 
                     y = Tm, 
                     fill = Tm)) +
  geom_boxplot() +
  geom_jitter(height = 0.25,
              alpha = 0.2,
              shape = "circle filled",
              color = "black") +
  labs(y = "Team",
       x = "W-L%") +
  theme_bw() 

ggplot(data = combined_history, 
       mapping = aes(x = WLpct, fill = Tm))+
  geom_histogram(bins = 60) +
  labs(x = "Single Season W-L%") +
  theme_bw()

# Runs Scored + Runs Allowed
ggplot(data = combined_history,
       mapping = aes(x = Runs, 
                     y = Tm, 
                     fill = Tm)) +
  geom_boxplot() +
  geom_jitter(height = 0.25,
              alpha = 0.2,
              shape = "circle filled",
              color = "black") +
  labs(y = "Team",
       x = "Runs Scored") +
  theme_bw() 

ggplot(data = combined_history,
       mapping = aes(x = RunsAllowed, 
                     y = Tm, 
                     fill = Tm)) +
  geom_boxplot() +
  geom_jitter(height = 0.25,
              alpha = 0.2,
              shape = "circle filled",
              color = "black") +
  labs(y = "Team",
       x = "Runs Allowed") +
  theme_bw() 


# Comparing Pythagorean W-L% vs Actual W-L%
ggplot(data = combined_history, 
       mapping = aes(x = WLpct, y = pythWLpct, color = Tm, shape = Tm)) +
  geom_point(size = 2) +
  geom_abline(intercept = 0,
              slope = 1, 
              color = "grey",
              linetype = "dashed") +
  ylab("Pythagorean W-L%") +
  xlab("Actual W-L%") +
  theme_bw() 
  
cor(x = pads_history$WLpct, y = pads_history$pythWLpct)
cor(x = ms_history$WLpct, y = ms_history$pythWLpct)