# Minimum Wage, Education, and Poverty Rate

## Project Overview

This project examines the relationship between minimum wage levels and poverty rates across U.S. states using 2021 cross-sectional data. The analysis employs Ordinary Least Squares (OLS) regression to investigate how minimum wage is associated with poverty rates while accounting for unemployment, median household income, and educational attainment.

## Methodology

- **Econometric Modeling:** Estimate multivariate OLS regression models with economic and demographic controls.
- **Model Specification:** Compare four specifications, including a full model, a reduced model excluding income, a log-transformed minimum wage model, and a quadratic minimum wage model.
- **Statistical Inference:** Apply heteroskedasticity-robust standard errors (HC1) to evaluate coefficient significance.
- **Data Visualization:** Use ggplot2 to visualize the relationship between minimum wage and poverty rates.

## Tools and Technologies

- R
- readxl
- psych
- stargazer
- ggplot2
- lmtest
- sandwich

## Research Limitations

The analysis uses cross-sectional observational data. Estimated relationships should therefore be interpreted as associations rather than causal effects. The study also recognizes potential omitted-variable bias and other limitations of OLS modeling.

## Reproducibility

To reproduce the analysis:

1. Download the project files.
2. Open the R script in RStudio.
3. Install the required R packages.
4. Set the working directory to the project folder.
5. Run the script to generate regression outputs and visualizations.

## Author

Tianyue Jia  
Purdue University  
Agribusiness — Agricultural Finance Concentration
