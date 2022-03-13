# Lichess Data by Mitchell J.  Retrieved from: https://www.kaggle.com/datasnaek/chess
# https://gist.github.com/valentinitnelav/cb7fa490e242d2b1a80a117a8844e44c

# Setup
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("dplyer")

library(tidyverse)
library(ggplot2)
library(dplyr)


# Load in the data set
chess_games = read_csv('games_cleaned.csv')
View(chess_games)


######################################
# Investigating wins by piece colour #
######################################

# Bar Chart displaying outcomes of all games
ggplot(data = chess_games, aes(x=winner)) +
  geom_bar(stat = "count", aes(fill=rated)) +
  scale_y_continuous(expand = c(0, 0), limits=c(0, 10500)) +
  labs(title="Outcome of all games in the data set",
       subtitle = "Number of wins for both and draws in rated and casual games",
       x="Winner/Outcome",
       y="Number of Occurences",
       caption="Lichess Data by Mitchell J.  Retrieved from: https://www.kaggle.com/datasnaek/chess",
       fill = "Rated") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Bar chart of wins for White vs Black (including if games are rated or casual)
chess_games %>% filter(winner != "draw") %>%
  ggplot(aes(x=winner)) +
  geom_bar(stat = "count", aes(fill=rated)) +
  scale_y_continuous(expand = c(0, 0), limits=c(0, 10500)) +
  labs(title="Wins for Black and White pieces",
       subtitle = "Counting the number of wins for both peices in rated and casual games",
       x="Winner",
       y="Number of Occurences",
       caption="Lichess Data by Mitchell J.  Retrieved from: https://www.kaggle.com/datasnaek/chess",
       fill = "Rated") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Bar chart of wins for White vs Black (including type of victory)
chess_games %>% filter(winner != "draw") %>%
  ggplot(aes(x=winner)) +
  geom_bar(stat = "count", aes(fill=victory_status)) +
  scale_y_continuous(expand = c(0, 0), limits=c(0, 10500)) +
  labs(title="Wins for Black and White pieces",
       subtitle = "Counting the number of wins for both peices and the type of victory",
       x="Winner",
       y="Number of Occurences",
       caption="Lichess Data by Mitchell J.  Retrieved from: https://www.kaggle.com/datasnaek/chess",
       fill = "Type of Victory") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())



# Check if there are any differences when we split up the elo
chess_games %>% filter(winner != "draw", white_rating >= 2000) %>%
  ggplot(aes(x=winner)) +
  geom_bar(stat = "count", aes(fill=victory_status)) +
  scale_y_continuous(expand = c(0, 0), limits=c(0, 1500)) +
  labs(title="Wins for Black and White pieces",
       subtitle = "Counting the number of wins for both peices and the type of victory",
       x="Winner",
       y="Number of Occurences",
       caption="Lichess Data by Mitchell J.  Retrieved from: https://www.kaggle.com/datasnaek/chess",
       fill = "Type of Victory") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())


chess_games %>% filter(winner != "draw", white_rating < 2000) %>%
  ggplot(aes(x=winner)) +
  geom_bar(stat = "count", aes(fill=victory_status)) +
  scale_y_continuous(expand = c(0, 0), limits=c(0, 10000)) +
  labs(title="Wins for Black and White pieces",
       subtitle = "Counting the number of wins for both peices and the type of victory",
       x="Winner",
       y="Number of Occurences",
       caption="Lichess Data by Mitchell J.  Retrieved from: https://www.kaggle.com/datasnaek/chess",
       fill = "Type of Victory") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())




#####################################################
# Investigating elo vs average of moves in the game #
#####################################################

chess_games %>% filter(rated == "TRUE") %>%
  ggplot(aes(x=white_rating, y=black_rating)) +
  geom_smooth(method = "lm", se=FALSE) +
  labs(title="ELO vs Number of Turns",
       subtitle = "Lines of best fit for white peices ELO vs number of turns",
       x="White Rating",
       y="Black Rating",
       caption="Lichess Data by Mitchell J.  Retrieved from: https://www.kaggle.com/datasnaek/chess") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Line of best fit for White ELO vs no. of turns (including outcome of game)
chess_games %>% filter(rated == "TRUE") %>%
  ggplot(aes(x=white_rating, y=turns, color=winner)) +
  geom_smooth(method = "lm", se=FALSE) +
  labs(title="ELO vs Number of Turns",
       subtitle = "Lines of best fit for white peices ELO vs number of turns",
       x="ELO of white pieces player",
       y="Number of Turns",
       caption="Lichess Data by Mitchell J.  Retrieved from: https://www.kaggle.com/datasnaek/chess",
       color = "Outcome") +
  theme(legend.position = c(0.9, 0.15)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Line of best fit for Black ELO vs no. of turns (including outcome of game)
chess_games %>% filter(rated == "TRUE") %>%
  ggplot(aes(x=black_rating, y=turns, color=winner)) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title="ELO vs Number of Turns",
       subtitle = "Lines of best fit for black peices ELO vs number of turns",
       x="ELO of black pieces player",
       y="Number of Turns",
       caption="Lichess Data by Mitchell J.  Retrieved from: https://www.kaggle.com/datasnaek/chess",
       color = "Outcome") +
  theme(legend.position = c(0.9, 0.15)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())




















