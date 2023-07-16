# SVR Time Series Forecasting

This repository contains an R script that demonstrates how to use Support Vector Regression (SVR) for time series forecasting of the CAD/CHF (Canadian Dollar to Swiss Franc) exchange rate. SVR is a powerful machine learning technique used for regression tasks, and it can be applied to time series data for prediction. This README file provides an overview of the script and explains the steps involved in the forecasting process.

## Table of Contents

- [Dependencies](#dependencies)
- [Usage](#usage)
- [Results](#results)
- [License](#license)

## Dependencies

To run the script, you need to have the following R packages installed:

- forecast
- quantmod
- caret
- ggplot2

You can install these packages using the `install.packages()` function in R.

## Usage

  1 Clone the repository or download the script file.

  2 Open the R environment or an R script editor.

  3 Install the required packages if they are not already installed:

  install.packages(c("forecast", "quantmod", "caret", "ggplot2"))

## Results

The script provides the following functionality:

    Retrieving historical data for the CAD/CHF exchange rate from Yahoo Finance.
    Preprocessing the data and handling missing values using last observation carried forward (LOCF).
    Training a Support Vector Regression (SVR) model to forecast the exchange rate.
    Evaluating the SVR model's performance using Root Mean Square Error (RMSE).
    Visualizing the forecasted exchange rate using ggplot2.

Execute the code step by step or run the entire script:

    The script uses the quantmod package to fetch historical data for the CAD/CHF exchange rate from Yahoo Finance.

    The data is preprocessed by filling missing values using the na.locf() function.

    The input data is prepared for SVR modeling by creating lagged features.

    The data is split into training and testing sets.

    An SVR model is trained on the training data using the train() function from the caret package.

    The SVR model is used to predict the exchange rate on the test data.

    Forecasting is performed on the predicted values using the forecast() function from the forecast package.

    The forecasted exchange rate is visualized using autoplot() from ggplot2.

    The Root Mean Square Error (RMSE) is calculated to evaluate the SVR model's performance.

The script produces various plots and outputs to help analyze and understand the CAD/CHF exchange rate time series data.

## License

This script is released under the MIT License.

Feel free to copy the entire content and use it as a README file in your GitHub repository.
