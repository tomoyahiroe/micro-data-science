successP <- function(error_probability, number) {
  return (1 - (error_probability ^ number))
}
P1 <- 0.05
P2 <- 0.05
N2 <- 5000
N1 <- 5

successP(P1, N1)
successP(P2, N2)
