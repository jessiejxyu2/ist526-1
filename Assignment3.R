install.packages("ggplot2")
install.packages("stats")

library(ggplot2)
library(stats)

C1T1 <- c(13.17, 8.28, 7.42, 12.27, 10.82, 9.58)
C2T1<- c(13.65, 10.48, 6.84, 11.9, 13.16, 11.37)
C1T2 <- c(12.78, 8.09, 8.44, 12.5, 10.92, 10.48)
C2T2 <-c(12.03, 10.55, 7.21, 11.48, 11.82, 8.18)
df <- data.frame(C1T1, C2T1, C1T2, C2T2)
rownames(df) = c( "Andrew", "Jeff", "Lindy", "LAY", "Andy", "Zeyu")

wilcox.test(C1T1, C2T1, paired = TRUE)
wilcox.test(C1T2, C2T2, paired = TRUE)

mean_value = apply(df, 2, mean)
median_value = apply(df, 2, median)
sd_value = apply(df, 2, sd)

###
ggplot(df, aes(x=C1T1)) + 
  geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                 binwidth=1.5,
                 colour="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666")  # Overlay with transparent density plot


boxplot(df)

ggplot(stack(df), aes(x = ind, y = values)) +
  geom_boxplot()