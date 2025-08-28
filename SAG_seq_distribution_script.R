library(ggplot2)
library(dplyr)

install.packages("cowplot")
library(cowplot)

read_length_df <- read.csv("./Final_SAG_masterfile.csv")

summary_df <- ddply(read_length_df, "Organism.Name", summarise, grp.mean=mean(cps.length))

total.length.plot <- ggplot(read_length_df, aes(x=cps.length, fill=Organism.Name, color=Organism.Name)) +
  geom_histogram(binwidth=50, alpha=0.9, position="dodge") +
  geom_vline(data=summary_df, aes(xintercept=grp.mean, color=Organism.Name), linetype="dashed", linewidth =0.7) +
  scale_x_continuous(breaks = c(2000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000, 45000, 50000), minor_breaks = seq(0, 55000, by = 1000)) +
  scale_y_continuous(limit= c(0, 70), breaks = seq(0, 120, by = 10), minor_breaks = seq(0, 120, by = 5)) +
  labs(x = "Length of cps sequence (bp)", y = "Count") +
  theme_bw()

total.length.plot
