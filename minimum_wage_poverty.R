
# ==========================================
# Minimum Wage, Education, and Poverty Rate
# AGEC 451 Research Project
# ==========================================

# 1. Load data
setwd("C:/Users/jty88/Desktop/Class Project/美国各州贫困率和最低薪资的回归分析")

library(readxl)
library(psych)
library(stargazer)
library(ggplot2)
library(lmtest)
library(sandwich)

df <- read_excel("Project Data.xlsx")

# Descriptive statistics
describe(df)

# 2. Define variables
df$MinimumWage <- df$`Minimum Wage($/h)`
df$Income <- df$`Income(thousand USD)`

# 3. Model 1: Full OLS model
model1 <- lm(
  Poverty ~ MinimumWage + Unemployment + Income + Education,
  data = df
)
summary(model1)

stargazer(model1, type = "html", out = "table1.html")

# 4. Model 2: Without income control
model2 <- lm(
  Poverty ~ MinimumWage + Unemployment + Education,
  data = df
)
summary(model2)

stargazer(model2, type = "html", out = "table2.html")

# 5. Model 3: Log-transformation
model3 <- lm(
  Poverty ~ log(MinimumWage) + Unemployment + Income + Education,
  data = df
)
summary(model3)

# 6. Model 4: Quadratic specification
model4 <- lm(
  Poverty ~ MinimumWage + I(MinimumWage^2) +
    Unemployment + Income + Education,
  data = df
)
summary(model4)

# 7. Heteroskedasticity-robust standard errors
models <- list(model1, model2, model3, model4)

robust_results <- lapply(models, function(m) {
  coeftest(m, vcov. = vcovHC(m, type = "HC1"))
})

# Print robust inference for each model
for (i in seq_along(robust_results)) {
  cat("\n===== Model", i, "Robust Results =====\n")
  print(robust_results[[i]])
}

# Extract robust standard errors and p-values
robust_se <- lapply(robust_results, function(x) {
  x[, 2]
})

robust_p <- lapply(robust_results, function(x) {
  x[, 4]
})

# 8. Compare four model specifications
stargazer(
  model1, model2, model3, model4,
  type = "html",
  out = "model_comparison.html",
  title = "Minimum Wage and Poverty: Regression Comparison",
  column.labels = c(
    "Full Controls",
    "Without Income",
    "Log Wage",
    "Quadratic Wage"
  ),
  se = robust_se,
  p = robust_p,
  digits = 3
)

# 9. Compare model explanatory power
model_comparison <- data.frame(
  Model = c("Model 1", "Model 2", "Model 3", "Model 4"),
  R_squared = sapply(models, function(m) summary(m)$r.squared),
  Adjusted_R_squared = sapply(models, function(m) {
    summary(m)$adj.r.squared
  }),
  N = sapply(models, nobs)
)

print(model_comparison)

# 10. Visualization
ggplot(df, aes(x = MinimumWage, y = Poverty)) +
  geom_point(size = 2, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Relationship Between Minimum Wage and Poverty Rate (2021)",
    x = "Minimum Wage (USD per hour)",
    y = "Poverty Rate (%)"
  ) +
  theme_minimal()
