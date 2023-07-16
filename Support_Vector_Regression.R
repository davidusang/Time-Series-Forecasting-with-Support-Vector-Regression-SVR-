# Load the required packages for the analysis
library(forecast)    # For time series forecasting
library(quantmod)    # For financial data retrieval
library(caret)       # For model training and evaluation
library(ggplot2)     # For data visualization

# Set the start and end dates for the data
# start_date <- as.Date("2020-01-01")
# end_date <- Sys.Date()

# Retrieve the CAD/CHF exchange rate data using getSymbols
getSymbols("CADCHF=X", 
           #from = start_date, 
           #to = end_date, 
           src = "yahoo",
           periodicity = "daily")

# Extract the "CADCHF=X" data from the environment
data <- `CADCHF=X`
head(data)

# Check for missing values in the data
sum(is.na(data))

# Fill missing values using the na.locf function
data <- na.locf(data, fromLast = TRUE)

# Confirm the absence of missing values in the data
sum(is.na(data))

# Preprocess the data by selecting relevant columns
df <- data[, c("CADCHF=X.Open", "CADCHF=X.High", "CADCHF=X.Low", "CADCHF=X.Close", "CADCHF=X.Volume")]
colnames(df) <- c("Open", "High", "Low", "Close", "Volume")

# Check for missing values in the preprocessed data
sum(is.na(df))

# Remove rows with missing values
df <- na.omit(df)

# Confirm the absence of missing values in the preprocessed data
sum(is.na(df))

# Prepare input data for the Artificial Neural Network (ANN) model
df$CloseL1 <- Lag(df$Close, 1)
df <- df[, c("Close", "CloseL1")]

# Use the dim function to check the dimensions of the data
dim(df)

# Split the data into training and testing sets
train_idx <- 1:3000
test_idx <- 3001:nrow(df)
data.train <- df[train_idx, ]
data.test <- df[test_idx, ]

# Handle missing values in the training set
data.train <- na.locf(data.train, fromLast = TRUE)

# Train a Support Vector Regression (SVR) model
trainControl <- trainControl(method = "repeatedcv", number = 10, repeats = 10)
svm.price.model <- train(Close ~ CloseL1, data = data.train, method = "svmLinear", 
                         preProcess = c("range"), trControl = trainControl)

# Predict the Close Price on the test data using the trained SVR model
data.test$CloseL1 <- as.numeric(data.test$CloseL1)
data.testSVM_Prediction <- predict(svm.price.model, newdata = data.test)
data.testSVM_Prediction <- na.locf(data.testSVM_Prediction, fromLast = TRUE)

# Convert the predicted values to a time series object
data.testSVM_Prediction <- ts(data.testSVM_Prediction, frequency = 365)

# Perform forecasting on the predicted values
data.testSVM_Forecast <- forecast(data.testSVM_Prediction, h = 90)

# Plot the forecasted data
autoplot(data.testSVM_Forecast) +
  labs(title = "Asset_Forecast",
       x = "Time",
       y = "Closing Price") +
  theme_minimal()

# Calculate the Root Mean Square Error (RMSE)
data.test$Close <- na.locf(data.test$Close, fromLast = TRUE)
rmse <- sqrt(mean((data.testSVM_Prediction - data.test$Close)^2))
rmse
