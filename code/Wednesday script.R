#####################
# Call me something #
#####################

### Setting our working directory

getwd()
?setwd()
setwd("C:/Some/File/You/Chose")

# We can also set our working directory using R Studio's 
# "New Project" function - check it out, it's in the top
# right corner...

# Next, we list the different packages we will require in 
# order to execute the res script. For this script, we will
# only need the tidyverse package, so go ahead and edit
# the call to library().

library(tidyverse)

### Examining our data

# In our analysis, we are going to be working with the 
# *diamonds* dataset, which is a built-in dataset provided
# with the ggplot package. If you managed to successfully
# load the tidyverse package, diamonds should now be
# available to you.

summary(diamonds)
head(diamonds)

#create histogram of values for price with base R
hist(diamonds$price, col = "steelblue", 
     main = "Histogram of Price Values",
     xlab = "Price")

#create histogram of values for price with ggplot2
ggplot(data=diamonds, aes(x=price)) +
  geom_histogram(fill="steelblue", color="black") +
  ggtitle("Histogram of Price Values")

#complete the code below to create scatterplot of price, grouped by cut
# also change the colour to orange

# ggplot(data=diamonds, aes(x=?, y=?)) + 
  # geom_boxplot(?)

### Wrangling our data

# Most data science projects begin by organising our data.
# Below, we are taking three subsets of the diamonds data -
# can you work out what the code is doing? 

an_object <- diamonds[diamonds$cut == "Ideal",]
anotherObject <- diamonds[diamonds$cut == "Premium",]
Object3 <- diamonds[diamonds$cut == "Very Good", ]

# Each new subset becomes an object with a name. The names 
# provided are not very good. Choose your own name in keeping 
# with good data science principles, and edit the code accordingly.

### Analysing our data

# Next, we want to find out the average price for our diamonds
# according to the three types of cut we used to subset
# the data. Edit and complete the code below to find out.

mean(an_object$price)
mean(anotherObject)
mean()

# What would you need to add to the code above if you wanted to
# create 3 new objects each containing the different means?
# What names might you give these objects? Go ahead and
# try it out.

### Visualising our data

# As we might expect, there seems there to be quite a 
# difference between the average price of the 3 cuts of 
# diamond. But is everything as you might expect? 

# Run the code below. What is strange about the box plot? 

diamonds %>%
  filter(cut %in% c("Ideal", "Premium", "Very Good")) %>%
  group_by(cut) %>%
  ggplot(aes(cut, price)) +
    geom_boxplot()

# This could be an important finding. Edit the code above 
# to assign the plot to an object, and give it an appropriate 
# name.

### Investigating further

# The cut variable is what is known in R as an *ordered 
# factor*. A factor is a categorical variable (a variable
# with distinct categories). An ordered factor is a factor
# where the different possible categories have an explicit
# order. 

class(diamonds$cut)

# The levels() function shows us the order for the
# cut variable. Again, looking at the box plot, what is 
# strange?

levels(diamonds$cut)

# The carat of a diamond is the diamond's weight. Let's 
# see if there is any *interaction* with the cut variable. 
# Use the mean() function on the carat variable for your 
# 3 diamonds subsets.

mean(diamonds$carat)
#mean carat, Ideal diamonds object 
#mean carat, Premium diamonds object 
#mean carat, Very Good diamonds object 

### Recycling code

# Recycling code is an important skill. You may not quite
# understand yet everything that's going on in the code
# below (which we used to generate the previous box plot),
# but you should be able to work out how to edit it to 
# produce a new box plot which substitutes the price
# variable for carat. Give it a go, and don't forget to 
# also make an appropriately named object. What do you 
# notice about the plot?


# %>% is the forward pipe operator
# it takes the output of the expression on its left and 
# passes it as the first argument to the function on its right.

diamonds %>%
  filter(cut %in% c("Ideal", "Premium", "Very Good")) %>%
  group_by(cut) %>%
  ggplot(aes(cut, price)) +
  geom_boxplot()

# Our final plot gives us a good idea of the interaction:
# can you describe what is happening here?

diamonds %>%
  filter(cut %in% c("Ideal", "Premium", "Very Good")) %>%
  group_by(cut) %>%
  ggplot(aes(carat, price, color = cut)) +
  geom_point(alpha = 0.2) +
  geom_smooth() 

### Saving our work

# We decide that the scatter plot is a bit busy, and the
# line plot with error bars does a good job of showing 
# the interaction effect on its own. We add a clean theme
# and a title to the plot, and decide to save a pdf of
# the plot as a record of our analysis. 

diamonds %>%
  filter(cut %in% c("Ideal", "Premium", "Very Good")) %>%
  group_by(cut) %>%
  ggplot(aes(carat, price, color = cut)) +
  geom_smooth() +
  theme_classic() +
  labs(title = "Pick a good title for this plot")

# Choose a name for the file below, and then call the 
# function to save it to disk. 

ggsave("Name this plot.pdf")

# We also decide it would be a good idea to have a record 
# of the data in the same location, so we use the write_csv() 
# function to store a *comma-separated values* copy of the dataset. 

write_csv(diamonds, "Name this data.csv")

# We also decide to rename our script file and save it in 
# the same place. Now try closing R. Can you find the 
# files in the working directory?


###########################
#  Reading external data  #
###########################


# Read CSV file
# CSV file is a common way to share tabular data,
# you can have a file downloaded with the rest of your docs
# or read in from a repository like this one. For .csv we can use base R.

# COVID-policy-tracker: https://github.com/OxCGRT/covid-policy-tracker/tree/master/data/timeseries


chi_df <- read.csv("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/containment_health_index_avg.csv")
str(chi_df) #overall structure
dim(chi_df) #dimensions


# What could we fix here so the dataset looks better?
# Just think for now, what would be useful here


# How could we read the diamonds csv file we saved?


# Another way of storing data is json format.
# For this one we'll install a package.

# install.packages("rjson")
library(rjson)

#Let's read in the Monthly Weather (Climate and Agmet Data) 
# of a few regions of Ireland and compare where rained more.

# Dublin Airport, Co Dublin
# https://data.gov.ie/dataset/monthly-weather-dublin-airport?package_type=dataset

#Function from the package that works here (quick google search will tell)
dublin <- fromJSON(file = "https://prodapi.metweb.ie/monthly-data/Dublin%20Airport")
str(dublin) # What format is here?


#To access the element that contains the monthly average we can 
# use a dolar sign as if it was a column, as save as a dataframe
dublin_df <- as.data.frame(dublin$total_rainfall)
str(dublin_df)
View(dublin_df)
colnames(dublin_df)

# Now let's get two more (not randomly selected)
# regions doing the same as above


# Roches Point, Co Cork
# https://data.gov.ie/dataset/monthly-weather-roches-point?package_type=dataset
cork <- fromJSON(file = "https://prodapi.metweb.ie/monthly-data/Roches%20point")
cork_df <- as.data.frame(cork$total_rainfall)

# Comparing if the dataframes have the same dimensions
dim(dublin_df) == dim(cork_df) 


# Malin head, Co Donegal
# https://data.gov.ie/dataset/monthly-weather-malin-head?package_type=dataset
donegal <- fromJSON (file = "https://prodapi.metweb.ie/monthly-data/Malin%20Head")
donegal_df <- as.data.frame(donegal$total_rainfall)

# Now let's merge these three rows in the same dataframe
rain_df <- do.call("rbind", list(dublin = dublin_df,
                                 cork = cork_df,
                                 donegal = donegal_df))
str(rain_df)

#Drop columns that contain annual averages
rain_df <- rain_df[,!endsWith(colnames(rain_df),"annual")]

#Drop columns that contain report.LTA.
rain_df <- rain_df[,!startsWith(colnames(rain_df),"report.LTA.")]

# We selected the data we want but it is still not in the right format.
# Making all variables into numeric. 
# 'lapply' (and variations) is a useful way of
# vectorised operations without looping

#Transforming in numeric
rain_df <- data.frame(lapply(rain_df, function(x) as.numeric(x)))

#Drop columns where all values are missing (August-December 2023)
rain_df <- rain_df[,colSums(is.na(rain_df))<nrow(rain_df)]

#New column with county names
rownames(rain_df)<- c("Dublin", "Cork", "Donegal")

#transposing so we have the dates on the rows and counties on columns 
rain_df <- data.frame(t(rain_df[-1]))

#Now let's plot using only base R
#(never mind the order of months it's not correct )

# Specify par parameters
par(mar = c(5, 4, 4, 8),  
    xpd = TRUE)

# Create a blank plot with custom axis labels and a legend
plot(1, type = "n", xlim = c(1, length(rain_df$Dublin)), ylim = c(0, max(rain_df$Dublin, rain_df$Cork, rain_df$Donegal)), 
     ylab = "Rainfall (mm)", xlab = "Month", main = "Monthly Rainfall Comparison")

# Add lines for each dataset with different colors and labels
lines(rain_df$Dublin, type = "l", col = "blue", lwd = 1, lty = 1, xaxt = "n", yaxt = "n", ann = FALSE)
lines(rain_df$Cork, type = "l", col = "red", lwd = 1, lty = 2)
lines(rain_df$Donegal, type = "l", col = "green", lwd = 1, lty = 3)

# Add a legend
legend("topright",inset = c(- 0.5, 0), legend = c("Dublin", "Cork", "Donegal"), col = c("blue", "red", "green"), 
       lty = c(1, 2, 3), lwd = 1, bg = "white", xpd = TRUE, y.intersp = ,2, title = "Locations")

#dev.off function to reset par to default setting
dev.off()    


########################################

# More on styling plots using ggplot
# Example from  Royal Statistical Society
# (https://royal-statistical-society.github.io/datavisguide/RSS-data-vis-guide.pdf)

# install.packages("ggtext")
library(ggtext)
# we are also using ggplot2 and dplyr but 
# we have them already with tidyverse

View(ToothGrowth)

plot_data <- ToothGrowth %>%
  mutate(dose = factor(dose)) %>%
  group_by(dose, supp) %>%
  summarise(len = mean(len)) %>%
  ungroup()

# Unstyled plot
ggplot(
  data = plot_data,
  mapping = aes(x = len, y = dose, fill = supp)
) +
  geom_col(position = "dodge")

# Styled plot
ggplot(
  data = plot_data,
  mapping = aes(x = len, y = dose, fill = supp)
) +
  geom_col(
    position = position_dodge(width = 0.7),
    width = 0.7
  ) +
  scale_x_continuous(
    limits = c(0, 30),
    name = "Tooth length"
  ) +
  geom_text(
    mapping = aes(label = round(len, 0)),
    position = position_dodge(width = 0.7),
    hjust = 1.5,
    size = 6,
    fontface = "bold",
    colour = "white"
  ) +
  scale_fill_manual(values = c("#9B1D20", "#3D5A80")) +
  labs(title = "Tooth Growth",
       subtitle = "Each of 60 guinea pigs received one of three dose levels of
vitamin C (0.5, 1, and 2 mg/day) by one of two delivery methods:
<span style='color: #9B1D20'>**orange juice**</span> or
<span style='color: #3D5A80'>**ascorbic acid**</span>.",
       y = "Dosage (mg/day)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    plot.title = element_textbox_simple(face = "bold"),
    plot.subtitle = element_textbox_simple(
      margin = margin(t = 10),
      lineheight = 1.5
    ),
    plot.title.position = "plot",
    plot.margin = margin(15, 10, 10, 15),
    panel.grid = element_blank(),
    axis.text.x = element_blank()
  )
    

## Good resource to know what is possible to do:
# https://posit.cloud/learn/cheat-sheets
