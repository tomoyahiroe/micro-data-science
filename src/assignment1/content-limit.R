library("formatR")  # R言語のフォーマッター
library("ggplot2")
library("tidyverse")
library("knitr")

main <- function() {
  preambles()
  
  set_parameters() -> param
  define_simulator(param) -> simulate_distribution
  define_figures() -> plot_averages
  
  define_unemployment(param) -> quantile_unemployment
  simulate_distribution(quantile_unemployment) -> data_unemployment
  plot_averages(data_unemployment, figure_title = "Unemployment Insurance Payment Simulation",
                save_title = "Unemployment_Insurance.png")
  
  define_earthquake(param) -> quantile_earthquake
  simulate_distribution(quantile_earthquake) -> data_earthquake
  plot_averages(data_earthquake, figure_title = "Earthquake Insurance Payment Simulation",
                save_title = "Earthquake_Insurance.pdf")
  
}

## 以下3つの関数の誤りを修正
define_unemployment <- function(param) {
  
  quantile_unemployment <- function(q) {
    if (q < param$unemployment_risk) {
      Y <- -param$insurance_premium
    } else {
      Y <- param$insurance_provision
    }
    return(Y)
  }
  return(quantile_unemployment)
  
}


define_earthquake <- function(param) {
  quantile_earthquake <- function(q) {
    Y <- param$payment_fraction * (1 - q)^(-1/param$alpha)
    return(Y)
  }
  return(quantile_earthquake)
}

define_simulator <- function(param) {
  simulate_distribution <- function(quantile) {
    set.seed(param$num.seed)
    q.unif <- runif(param$N.simulate)
    data_simulated <- matrix(0, 1, param$N.simulate)
    
    for (i in 1:param$N.simulate) {
      q <- q.unif[i]
      data_simulated[i] <- quantile(q)
    }
    return(data_simulated)
  }
  return(simulate_distribution)
}


## 以下は修正の必要のない関数
preambles <- function() {
  rm(list = ls())
  Sys.setenv(LANG = "en")  # error message in English
  # install.packages('tidyverse') #install this at first library(tidyverse)
  # library(knitr)
  
}

set_parameters <- function() {
  
  N.simulate <- 10^3  # change here arbitrarily
  num.seed <- 77777  # set any number for record
  
  unemployment_risk <- 0.05
  insurance_premium <- 5000
  insurance_provision <- 1e+05
  
  alpha <- 1.0001
  payment_fraction <- 0.3
  
  param <- data.frame(N.simulate, num.seed, unemployment_risk, insurance_premium, insurance_provision,
                      alpha, payment_fraction)
  return(param)
}


define_figures <- function() {
  
  
  plot_averages <- function(data_simulated, figure_title, save_title) {
    
    N.simulate <- length(data_simulated)
    average_store <- matrix(0, nrow = N.simulate, ncol = 2)
    for (i in 1:N.simulate) {
      average_store[i, 1] <- mean(data_simulated[1:i])
      average_store[i, 2] <- i
    }
    
    average_data <- as.data.frame(average_store)
    figure_made <- ggplot(average_data, aes(x = V2, y = V1)) + geom_line(colour = "blue",
                                                                         size = 2) + labs(x = "sample size", y = "averages") + ggtitle(figure_title) +
      theme_bw() # + ggsave(save_title, width = 5, height = 5) エラーはいたのでコメントアウトしました。
    print(figure_made)
    
  }
  return(plot_averages)
  
}

# 実行部分
main()