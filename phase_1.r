# %%
# Loading the  required libraries
library(tidyverse)
library(caret)
library(randomForest)
library(corrplot)
library(ggplot2)
library(gridExtra)

# Create charts directory if it doesn't exist
dir.create("charts", showWarnings = FALSE)

# %%
# Step 1: Data Collection and Initial Analysis
df <- read.csv("Social Meida Dataset.csv")
print("=== Initial Dataset Info ===")
str(df)
summary(df)

# %%
# Exploratory Data Analysis (EDA)
print("=== Basic Statistics ===")
summary(df)

# %%
# Check for missing values
print("=== Missing Values Analysis ===")
missing_data <- colSums(is.na(df))
missing_percentage <- (missing_data / nrow(df)) * 100
missing_info <- data.frame(
  Missing_Values = missing_data,
  Percentage = missing_percentage
)
print(missing_info)

# %%
# Distribution of numerical variables
numerical_cols <- c("Age", "Income..USD.", "Social.Media.Usage..Hours.Day.")
plots <- list()

for (col in numerical_cols) {
  p <- ggplot(df, aes(x = !!sym(col))) +
    geom_histogram(bins = 30, fill = "steelblue", alpha = 0.7) +
    geom_density(aes(y = after_stat(count) * 2), color = "red") +
    labs(title = paste("Distribution of", col))
  plots[[col]] <- p
}

# Save the combined plot
png("charts/numerical_distributions.png", width = 1200, height = 400)
grid.arrange(grobs = plots, ncol = 3)
dev.off()

# %%
# Box plots for numerical variables by gender
plots <- list()
for (col in numerical_cols) {
  p <- ggplot(df, aes(x = Gender, y = !!sym(col))) +
    geom_boxplot(fill = "steelblue", alpha = 0.7) +
    labs(title = paste(col, "by Gender"))
  plots[[col]] <- p
}

# Save the combined plot
png("charts/numerical_by_gender.png", width = 1200, height = 400)
grid.arrange(grobs = plots, ncol = 3)
dev.off()

# %%
# Categorical variables analysis
categorical_cols <- c("Gender", "Education.Level", "Influence.Level", "City", "Product.Category")
plots <- list()

for (col in categorical_cols) {
  if (col == "City") {
    # For cities, show top 10
    top_values <- df %>%
      count(!!sym(col)) %>%
      top_n(10, n) %>%
      pull(!!sym(col))
    
    data <- df %>%
      filter(!!sym(col) %in% top_values)
  } else {
    data <- df
  }
  
  p <- ggplot(data, aes(x = !!sym(col))) +
    geom_bar(fill = "steelblue", alpha = 0.7) +
    labs(title = paste("Distribution of", col)) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  plots[[col]] <- p
}

# Save the combined plot
png("charts/categorical_distributions.png", width = 1200, height = 800)
grid.arrange(grobs = plots, ncol = 2)
dev.off()

# %%
# Correlation analysis
correlation_matrix <- cor(df[, numerical_cols], use = "complete.obs")
png("charts/correlation_matrix.png", width = 800, height = 800)
corrplot(correlation_matrix, method = "color", type = "upper", 
         addCoef.col = "black", tl.col = "black", tl.srt = 45)
dev.off()
