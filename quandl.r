install.packages("Quandl")
library(Quandl)
# Quandl - A first date
mydata = Quandl("NSE/OIL")

# Identifying a dataset with its ID
PragueStockExchange = Quandl("GOOG/NYSE_TWTR")
