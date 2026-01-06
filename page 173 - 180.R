# ========================================
# COMPLETE ANALYSIS: AI Dehumanization vs Economic Crisis
# Testing Significant Differences Between Two Variables
# Columns: "I" (AI Dehumanization) and "N" (Economic Crisis)
# ========================================

# Load necessary libraries
library(dplyr)      # For data manipulation
library(ggplot2)    # For advanced plotting
library(psych)      # For descriptive statistics
library(tidyr)      # For data tidying
library(vioplot)    # For violin plots
library(car)        # For QQ plot and Levene's test
library(BSDA)       # For t-test and sign test
library(nortest)    # For normality tests

# ========================================
# STEP 1: LOAD YOUR DATA
# ========================================

# CORRECTED: Set working directory with forward slashes
setwd("C:/Users/Constantien/OneDrive/ドキュメント/Chapter 2 - R/COMPLETE GPA ANALYSIS")

# CORRECTED: Load the dataset with the correct filename
data <- read.csv("Survey_AI-Survey_AI.csv", header = TRUE)

cat("Your current column names are:\n")
print(names(data))
cat("\n")

# ========================================
# EXPLORATORY DATA ANALYSIS
# ========================================

cat("=======================================================\n")
cat("EXPLORATORY DATA ANALYSIS\n")
cat("=======================================================\n\n")

# EDA
cat("Structure of the dataset:\n")
str(data)

cat("Structure of the dataset:\n")
print('Q12.Gender')

cat("\nSummary of the dataset:\n")
summary(data)

cat("\nFirst few rows:\n")
print(head(data))

# Sort AI Dehumanization in decreasing order
AI <- sort(data$Q3.1.AI_dehumanization, decreasing = TRUE)
cat("\nSorted AI Dehumanization values:\n")
print(AI)

cat("\nSummary statistics (min, Q1, median, mean, Q3, max):\n")
summary(AI)

# ========================================
# TASK 1: Test Normality Using Histogram - AI dehumanization
# ========================================

cat("\n=======================================================\n")
cat("TASK 1: TEST NORMALITY USING HISTOGRAM - AI_dehumanization\n")
cat("=======================================================\n\n")


# Enhanced histogram with ggplot2
p1 <- ggplot(data, aes(x = Q3.1.AI_dehumanization)) +
  geom_histogram(fill = "lightblue", color = "black", bins = 8) +
  labs(title = "AI Dehumanization",
       x = "AI Dehumanization Score",
       y = "Count") +
  theme_minimal()
print(p1)

# ========================================
# TASK 2: Test Normality Using Boxplot - AI Dehumanization
# ========================================

cat("\n=======================================================\n")
cat("TASK 2: TEST NORMALITY USING BOXPLOT - AI Dehumanization\n")
cat("=======================================================\n\n")


p2 <- ggplot(data, aes(x = factor(Q12.Gender), y = Q3.1.AI_dehumanization)) +
  geom_boxplot(aes(fill = factor(Q12.Gender))) +
  scale_x_discrete(labels = c("1" = "Female", "2" = "Male")) +
  scale_fill_manual(values = c("1" = "lightcoral", "2" = "cyan3")) +
  labs(title = "AI Dehumanization by Gender",
       x = "Gender",
       y = "AI Dehumanization Score",
       fill = "Gender") +
  theme_minimal()
print(p2)

# ========================================
# TASK 3: Show Mean AI Dehumanization by Gender
# ========================================

cat("\n=======================================================\n")
cat("TASK 3: Show Mean AI Dehumanization by Gender\n")
cat("=======================================================\n\n")

# Calculate group means for AI Dehumanization by Gender
group_means <- data %>%
  group_by(Q12.Gender) %>%
  summarise(Mean_AI_dehumanization = mean(Q3.1.AI_dehumanization, na.rm = TRUE))

# Bar plot of mean AI Dehumanization by Gender
p3 <- ggplot(group_means, aes(x = factor(Q12.Gender), y = Mean_AI_dehumanization)) +
  geom_bar(stat = "identity", fill = "lightgreen", color = "black") +
  geom_text(aes(label = round(Mean_AI_dehumanization, 2)), vjust = -0.5) +
  scale_x_discrete(labels = c("1" = "Female", "2" = "Male")) +
  labs(title = "Mean AI Dehumanization by Gender",
       x = "Gender",
       y = "Mean AI Dehumanization Score") +
  ylim(0, max(group_means$Mean_AI_dehumanization) * 1.1) +
  theme_minimal()
print(p3)

# Calculate detailed group statistics for AI Dehumanization
group_stats <- data %>%
  group_by(Q12.Gender) %>%
  summarise(
    Mean_AI = mean(Q3.1.AI_dehumanization, na.rm = TRUE),
    SD = sd(Q3.1.AI_dehumanization, na.rm = TRUE),
    N = n(),
    SE = SD / sqrt(N)
  )

cat("\nDetailed Statistics by Gender:\n")
print(group_stats)

# ANOVA model - Testing if AI Dehumanization differs by Gender
anova_model <- aov(Q3.1.AI_dehumanization ~ Q12.Gender, data = data)
cat("\nANOVA Results:\n")
summary(anova_model)

# ========================================
# MANN-WHITNEY U TEST ADDED HERE
# ========================================

cat("\n=======================================================\n")
cat("MANN-WHITNEY U TEST - AI DEHUMANIZATION vs GENDER\n")
cat("=======================================================\n\n")

# Prepare data for Mann-Whitney test
cat("Preparing data for Mann-Whitney U test...\n")

# Create gender labels
data_for_test <- data %>%
  mutate(
    Gender_label = case_when(
      Q12.Gender == 1 ~ "Female",
      Q12.Gender == 2 ~ "Male",
      TRUE ~ "Other"
    )
  ) %>%
  filter(Gender_label %in% c("Female", "Male"))

# Check sample sizes
cat("Sample sizes:\n")
print(table(data_for_test$Gender_label))

# Perform Mann-Whitney U test
cat("\nPerforming Mann-Whitney U test...\n")
mann_whitney_result <- wilcox.test(Q3.1.AI_dehumanization ~ Gender_label, 
                                   data = data_for_test)

# Display results
cat("\nMann-Whitney U Test Results:\n")
cat("Test statistic (W):", mann_whitney_result$statistic, "\n")
cat("P-value:", mann_whitney_result$p.value, "\n")

# Calculate U statistic
n_female <- sum(data_for_test$Gender_label == "Female")
n_male <- sum(data_for_test$Gender_label == "Male")
U_statistic <- min(mann_whitney_result$statistic, 
                   n_female * n_male - mann_whitney_result$statistic)
cat("Mann-Whitney U statistic:", U_statistic, "\n")

# Interpretation
cat("\nInterpretation:\n")
if(mann_whitney_result$p.value < 0.05) {
  cat("There is a statistically significant difference in AI dehumanization\n")
  cat("perceptions between males and females (p < 0.05).\n")
} else {
  cat("There is NO statistically significant difference in AI dehumanization\n")
  cat("perceptions between males and females (p > 0.05).\n")
}

# ========================================
# END OF ANALYSIS
# ========================================