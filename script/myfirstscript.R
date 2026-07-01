# My First Script in this project
library(ggplot2)
library(ratdat)

ggplot(data = complete_old, aes(x = hindfoot_length, y = weight))+
  geom_point()

# Make a comment
ggplot(data = complete_old, aes(x = hindfoot_length, y = weight, color = species))+
  geom_point()
