# Hierarquical models (mixed-effects models) #
# 
library(lme4)
library(ggplot2)
library(merTools)
library(lmerTest)

y = response_variable
X = predictor0
x1 = predictor1
  x2 = predictor2
  x3 = predictor3
  x4 = predictor4
  x5 = predictor5
  x... = predictorx
  group = within_effect (categorical)
# Random intercept model
# Simplest model
model <- lmer(y ~ x + (1|group), data = data)
# Plotting simple random intercept
data$predicted <- predict(model)
plot1 <- 
  ggplot(data, aes(x=x,y=y)) +
  geom_point(aes(color = group)) +
  theme_minimal()+
  scale_color_manual(values = c("blue", "black", "red")) +
  geom_abline(data, aes(intercept))

plot1 +
  geom_line(data =  data,
            aes(x = x, y = predicted, color = group),
            linetype = 2)
# Random effects slopes
model2 <- lmer( y ~ x + (x|group), data = data)
data$predicted <- predict(model2)
# Plotting random slopes
plot2 <- ggplot( data, aes(x = x, y = response) ) +
  geom_point(aes(color = group))+
  theme_minimal() +
  scale_color_manual(values = c("blue", "black", "red")) +
  geom_abline(data = data,
              aes(intercept = intercept, slope = slope, color = group))

plot2 + 
  geom_line(data, aes(x = x, y = predicted, color = group),
            linetype = 2)
# Building and plotting more complex Mixed-Effects model
# Example 1 - Two random intercepts based on two nesting variables
model3 <- lmer(y ~
                 x + x1 + x2 + # Fixed effects
                 (1|x3) + (1|x4)) # Random effects
# Plotting
# Extract coefficients
modelplot <- tidy(model3, conf.int = TRUE)
# Grab coefficients of interest 
modelplot <- modelplot[ modelplot$effect =="fixed" & # All fixed effects
                          modelOutPlot$term != "(Intercept)", ] # Non-intercept estimations
# Plot the effects with its confidence intervals
ggplot (modelplot, aes(x = term, y = estimate, 
                       ymin = conf.low,
                       ymax = conf.high)) +
  theme_minimal()+
  geom_hline(yintercept = 0.0, color = 'red', size = 2.0) +
  geom_point() +
  geom_linerange() + coord_flip()
# Model with fixed effects and random effects including slope and intercept
birthRateStateModel <- lmer(y ~ (1 | group), data = data)
# This model fits a global intercept as fixed-effect and a random effect of a group intercept



## Output from a linear mixed-effect model
REM

























## Sample size calculation for nested models
### First, simulate a linear mixed-effect model

N = 50 # Number of second-level units (clusters)
n = 3 # number of first-level units per cluster
Cstd = 0.1224 # sigma^2 for the within-cluster variance
Ostd = 0.1870 # observation-level variance
intercept = 0

cluster = rep(1:N, each = n)
observation = 1:(N*n)

# Generate the random-effect for the cluster
clustereff = rep(rnorm(N, 0, Cstd), each = n) # This gives the same cluster effect for the observation inside it
# Generate observartion-effect
obseffect = rnorm(n*N, 0, Ostd)

