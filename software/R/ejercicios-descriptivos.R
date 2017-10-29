
library(foreign)

# descriptivos de paises. Ejercicio 2.1
paises.csv <- read.csv('paises.csv', sep=';', na.strings=999)
media <- mean(paises.csv$Porcentaje)
mediana <- median(paises.csv$Porcentaje)
desviacionTipica <- sd(paises.csv$Porcentaje)
varianza <- var(paises.csv$Porcentaje)
cuantil <- quantile(paises.csv$Porcentaje)
todos <- summary(paises.csv$Porcentaje)

# Ejercicio 2.4

