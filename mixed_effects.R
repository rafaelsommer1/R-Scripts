# Hierarquical models (mixed-effects models)

library(lme4)
library(ggplot2)

y = response_variable
X = predictor0
x1 =
  x2 =
  x3 =
  x4 =
  x5 =
  x... =
  group = within_effect

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