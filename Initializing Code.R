dataset = read.csv("US_Accidents_March23.csv")
head(dataset, 10)

library(dplyr)
library(tidyr)

filtered_df <- dataset %>%
  filter(State == "IL")

View(filtered_df_2)

filtered_df_2 <- dataset %>%
  filter(State == "IL", County == "Champaign")

typeof(filtered_df_2$Start_Time)

library(dplyr)
library(tidyr)

# Assuming your dataset is called df
daily_counts <- filtered_df_2 %>%
  mutate(Start_Date = as.Date(Start_Time)) %>% # Extract the date component
  group_by(Start_Date) %>%                    # Group by date
  summarise(Count = n())                      # Count occurrences for each day

# Create a sequence of all dates from the minimum to the maximum date
complete_dates <- data.frame(Start_Date = seq(min(daily_counts$Start_Date),
                                              max(daily_counts$Start_Date),
                                              by = "day"))

# Join with the daily_counts to ensure every day is represented
complete_daily_counts <- complete_dates %>%
  left_join(daily_counts, by = "Start_Date") %>% # Join on the date column
  replace_na(list(Count = 0))                   # Replace NA counts with 0

View(complete_daily_counts)

# Write complete_daily_counts to a CSV file
write.csv(complete_daily_counts, "complete_daily_counts.csv", row.names = FALSE)
