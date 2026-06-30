#Part 1:Advanced Data Visualization
#Que1:Density Plot with Facets

# Loading the required libraries
install.packages("ggplot2")
library(ggplot2)

#Loading the required iris dataset
data(iris)

#Creating a density plot to visualize the distribution of sepal.length
ggplot(iris, aes(x = Sepal.Length, fill = Species, color = Species)) +
  geom_density(alpha = 0.5, size = 1.2) +  # Added line thickness (size)
  facet_wrap(~Species) +  # Creating the separator for each species
  scale_fill_manual(values = c("setosa" = "khaki", "versicolor" = "pink", "virginica" = "powderblue")) +
  scale_color_manual(values = c("setosa" = "goldenrod", "versicolor" = "deeppink", "virginica" = "deepskyblue")) +
  labs(title = "The Density Plot for the distribution of Sepal Length for Each Species",x = "Length of Sepal", y = "Sepal Density",face="bold",hjust=0.5) +  # Adding the labels of X,Y axis
  theme_minimal() + 
  theme(
    legend.position = "none", #Removing the legend
    strip.background = element_rect(fill = "lavender", color = "bisque", size = 0.5 ),  
    strip.text = element_text(face = "bold", size = 12, color = "black"),
    panel.grid.minor = element_line(color = "sandybrown", size = 0.1),  # The minor gridlines  and their color,size
    axis.text = element_text(size = 9, color = "black"),  # The size and color of the Axis text
    axis.title = element_text(size = 11, face = "bold", color = "black"),  
    plot.background = element_rect(fill = "lemonchiffon"),  # Adding Background color in the plot
    panel.background = element_rect( color = "aliceblue"),
    panel.grid.major = element_line(color = "sandybrown", size = 0.5),  # The Major gridlines and their color,siz
)

#Sving the plot in the .png file format
ggsave("Mayuri_MT24302_plot1.png", dpi = 300)




#Que2: Combined Scatter and Smooth Line Plot

# Loading the required library
#library(ggplot2)

# Loading the  required mtcars dataset
data(mtcars)

# Creating the scatter plot with a smooth trend line
ggplot(mtcars, aes(x = hp, y = mpg, color = factor(cyl))) + 
  geom_point(size = 4, alpha = 0.8) +       # Adjusting the transparency for the points
  geom_smooth(method = "lm", se = FALSE, color = "black", size = 1) + 
  scale_color_manual(values = c("4" = "darkslateblue", "6" = "gold", "8" = "tomato")) + 
  labs(title = "The Relation Between Horsepower(hp) and Miles Per Gallon(mpg)", 
       x = "Horsepower(hp)", 
       y = "Miles Per Gallon (mpg)",
       color = "Count of Cylinders"
  ) +
  theme_minimal() + 
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "black", hjust = 0.5, vjust = 3),  # Centered the title by adjusting 
    axis.title = element_text(size = 12, face = "bold", color = "black"),  #For Bold axis titles
    axis.text = element_text(size = 10, color = "black"),  
    legend.position = "top",               # Moving the legend to the top
    legend.title = element_text(size = 10),  #Adding the legent title text size
    legend.text = element_text(size = 10),  # Adjusting the legend text size
    plot.background = element_rect(fill = "navajowhite", color = "white"),  # Adding background for the plot
    panel.background = element_rect(fill = "floralwhite", color = "orange"),
    panel.grid.major = element_line(color = "peachpuff", size = 0.1),  # Subtle major gridlines
)

#Saving the plot in the .png file format
ggsave("Mayuri_MT24302_plot2.png", dpi = 300)





#Que3: Bar Plot with Summary Statistics

# Loading the required library
#library(ggplot2)
library(dplyr)

# Loading the iris dataset
data(iris)

# Calculating the mean and standard deviation of Sepal.Length for each of Species
summary_stats <- iris %>%
  group_by(Species) %>%
  summarise(
    mean_sepal_length = mean(Sepal.Length),
    sd_sepal_length = sd(Sepal.Length)
  )

# Creating the bar plot 
ggplot(summary_stats, aes(x = Species, y = mean_sepal_length, fill = Species)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.4) + 
  geom_errorbar(aes(ymin = mean_sepal_length - sd_sepal_length, ymax = mean_sepal_length + sd_sepal_length), width = 0.1, color = "black") +  # Error bars for standard deviation
  scale_fill_brewer(palette = "maroon") + 
  labs(
    title = "Mean of the Sepal Length by Species", 
    x = "Species", 
    y = "Mean of Sepal Length (cm)"
  ) +  # Adding the titles and axis labels
  theme_minimal() +  
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "black", hjust = 0.5),  # Adjusting Centered title with bold font
    axis.title = element_text(size = 12, face = "bold", color = "black"),  
    axis.text = element_text(size = 10, color = "black"),  # The Axis text size
    legend.position = "none",
    plot.background = element_rect(fill = "mistyrose", color = "white"),  
    panel.background = element_rect(fill = "aliceblue", color = "orchid"),  
    panel.grid.major = element_line(color = "darksalmon", size = 0.2),  
    panel.grid.minor = element_line(color = "darksalmon", size = 0.25),  
)
#Saving the plot in the .png file format
ggsave("Mayuri_MT24302_plot3.png",dpi = 300)




#Part2:Non-Parametric Tests
#Que4:Wilcoxon Singed-Rank Test with Visualization
# Loading the required library
#library(ggplot2)
#library(dplyr)

# Loading the required iris dataset
data(iris)

# Extracting the Sepal.Length data for the species 'setosa'
setosa_data <- iris %>% filter(Species == 'setosa') %>% select(Sepal.Length)

# To Perform the Wilcoxon Signed-Rank Test
wilcoxon_test_result <- wilcox.test(setosa_data$Sepal.Length, mu = 5.0)

# Print the Wilcoxon test result
print(wilcoxon_test_result)

# Create a boxplot with advanced visualization and enhanced colors
ggplot(setosa_data, aes(x = "", y = Sepal.Length)) +
  geom_boxplot(fill = "maroon", color = "indianred", width = 0.5, outlier.size = 3, outlier.colour = "#e31a1c") +
  geom_hline(yintercept = 5.0, linetype = "dashed", color = "goldenrod", size = 1.2) +
  labs(
    title = "Distribution of Sepal.Length for Setosa Species",
    subtitle = "Wilcoxon Signed-Rank Test: Testing the Median vs 5.0",
    x = "Setosa Species",
    y = "Sepal Length (cm)",
    caption = paste("p-value:", round(wilcoxon_test_result$p.value, 4))
  ) +
  theme_minimal(base_size = 14) +  # Set base font size for better readability
  theme(
    plot.title = element_text(size = 18, face = "bold", color = "black", hjust=0.5),
    plot.subtitle = element_text(size = 14, color = "darkgreen", hjust=0.5),
    axis.title.x = element_text(size = 12, color = "midnightblue",face="bold"),
    axis.title.y = element_text(size = 12, color = "midnightblue",face = "bold"),
    plot.caption = element_text(size = 12, hjust = 1, color = "maroon",face = "bold"),
    panel.background = element_rect(fill = "navajowhite"),  
    plot.background = element_rect(fill = "lavender"),  
    panel.grid.major = element_line(color = "grey", size = 0.5),  
    panel.grid.minor = element_line(color = "grey", size = 0.25) ,
)

#Saving the plot in the .png file format
ggsave("Mayuri_MT24302_plot4.png", width = 10, height = 8, dpi = 300)




#Que5:Mann-Whitney-Wilcoxon Test with Violin Plots

# Loading the necessary libraries
#library(ggplot2)
#library(dplyr)

# Loading the required iris dataset
data(iris)

# Extracting Sepal.Length data for the species 'setosa' and 'versicolor'
setosa_species_data <- iris %>% filter(Species == 'setosa') %>% select(Sepal.Length)
versicolor_species_data <- iris %>% filter(Species == 'versicolor') %>% select(Sepal.Length)

# Performing the Mann-Whitney-Wilcoxon Test
wilcoxon_test_result <- wilcox.test(setosa_data$Sepal.Length, versicolor_species_data$Sepal.Length)

# Displaying the tets results of wilcoxon_test_result
print(wilcoxon_test_result)

# Creating the Violin Plot with advanced visualization of the plot
ggplot(iris %>% filter(Species %in% c('setosa', 'versicolor')), aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_violin(trim = FALSE, color = "orange", alpha = 0.7) +  # To visualize violin plot
  geom_boxplot(width = 0.1, color = "darkslateblue", alpha = 0.7, outlier.size = 3, outlier.colour = "#e31a1c") +  # Adding boxplot on top
  labs(
    title = "The Comparison Distribution of Sepal Length : Setosa vs Versicolor Species",
    subtitle = paste("Mann-Whitney-Wilcoxon Test with the p-value: ", round(wilcoxon_test_result$p.value, 4)),
    x = "Species",
    y = "Sepal Length (cm)",
    caption = "Combining Violin Plots and Boxplots with Significance Markers",hjust=0.8
  ) +
  theme_minimal(base_size = 15) +  # Cleaned theme with larger base font
  theme(                         #Adding the extra colors and grid to make advance visualization of plot
    plot.title = element_text(size = 18, face = "bold", color = "black", hjust = 0.5),
    plot.subtitle = element_text(size = 12, color = "darkgreen", face= "bold", hjust = 0.4),
    axis.title.x = element_text(size = 12, color = "black", face ="bold"),
    axis.title.y = element_text(size = 11, color = "black", face="bold"),
    plot.caption = element_text(size = 12, hjust = 0.15, color = "navy", face = "bold"),
    panel.background = element_rect(fill = "white"),
    plot.background = element_rect(fill = "navajowhite"), 
    panel.grid.major = element_line(color = "bisque", size = 0.5),  
    panel.grid.minor = element_line(color = "bisque", size = 0.25),  
  ) +
  scale_fill_manual(values = c("setosa" = "slateblue", "versicolor" = "lightcoral"))  # Color scheming for the violins


#Saving the plot in the .png file format
ggsave("Mayuri_MT24302_plot5.png", dpi = 300)



#Part3:Linear Regression with Diagnostic plots
#Que6:LLinear Regression and residual analysis

# Loading the reqired libraries
#library(ggplot2)
#library(dplyr)

# Loading the mtcars dataset
data(mtcars)

#Performing the linear regression with mpg as the dependent variable and hp as the independent variable
model <- lm(mpg ~ hp, data = mtcars)
summary(model)               #Summarizing the model

# Creating the diagnostic plots

# To plot Residuals plot vs Fitted Plot
residuals_vs_fitted_plot <- ggplot(model, aes(x = .fitted, y = .resid)) +
  geom_point(color = "sandybrown", size = 3) +
  geom_smooth(method = "loess", color = "maroon", linetype = "dashed") +
  labs(
    title = "The Residuals vs Fitted Plot Generated",
    subtitle = "To Check for the patterns in residuals",
    x = "Fited  Values",
    y = "Residuals"
  ) +
  theme_minimal(base_size = 12) +
  theme(                         #Adding he extra colours and background to make advance visualization
    plot.title = element_text(size = 18, face = "bold", color = "black",hjust = 0.5),
    plot.subtitle = element_text(size = 14, color = "darkgreen",face="bold",hjust= 0.5),
    plot.background = element_rect(fill = "mistyrose"),
    panel.grid.major = element_line(color = "lightpink", size = 0.5), 
    axis.title.x = element_text(size = 13, color = "midnightblue",face="bold"),
    axis.title.y = element_text(size = 13, color = "midnightblue",face="bold")
  )

# Creating the Normal Q-Q Plot
normal_qq_plot <- ggplot(model, aes(sample = .resid)) +
  geom_qq(color = "deeppink") +
  geom_qq_line(color = "goldenrod", size = 1.2) +
  labs(
    title = "The Normal Q-Q Plot",
    subtitle = "The Normality of a residuals",
    x = "Theoretical Quantiles",
    y = "Standardize Residuals"
  ) +
  theme_minimal(base_size = 12) +
  theme(                        #Adding he extra colours and background to make advance visualization
    plot.title = element_text(size = 18, face = "bold", color = "black",hjust = 0.5),
    plot.subtitle = element_text(size = 14, color = "darkred",face="bold",hjust = 0.5),
    plot.background = element_rect(fill = "papayawhip"),
    panel.grid.major = element_line(color = "lavenderblush", size = 0.8), 
    axis.title.x = element_text(size = 12, color = "darkslategrey",face="bold"),
    axis.title.y = element_text(size = 12, color = "darkslategrey",face="bold")
  )

# Displaying the results of the diagnostic plots
print(residuals_vs_fitted_plot)
ggsave("Mayuri_MT24302_plot6.png",dpi = 300)
print(normal_qq_plot)
ggsave("Mayuri_MT24302_plot7.png",dpi = 300)



