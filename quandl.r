# install.packages("Quandl")
library(Quandl)
library(quantmod)
# Quandl - A first date
mydata = Quandl("NSE/OIL")

# Identifying a dataset with its ID
####################################################################
# The Quandl package is able to return data in 4 very usable formats:
# data frame ("raw"),
# ts ("ts"),
# zoo ("zoo") and
# xts ("xts"). The only thing you have to do is give the type you want as an argument to the Quandl function.
####################################################################
AppleStockExchange = Quandl("GOOG/NASDAQ_AAPL",type = "xts")

# Plot the chart with candleChart()
candleChart(AppleStockExchange)

# Searching a Quandl dataset in R
Quandl.search(query = "Apple", silent = F)

# Manipulating data
Apple = Quandl("GOOG/NASDAQ_AAPL",type = "xts", start_date = "2014-08-01", end_date = "2014-09-01")
candleChart(Apple)

# Transforming your Quandl dataset
# Quandl can transform your data before serving it. You can set the transformation argument to:"diff", "rdiff", "cumul", and "normalize". Have a look at the Quandl API documentation to see what these options actually do.
AppleStockExchange = Quandl("GOOG/NASDAQ_AAPL", transformation = "rdiff")
AppleStockExchange = Quandl("GOOG/NASDAQ_AAPL", transformation = "normalize")

# The magic of frequency collapsing
AppleQuarterly = Quandl("GOOG/NASDAQ_AAPL", collapse = "quarterly")

# Truncation and sort
# get the last 5 observations of apple price
apple = Quandl("GOOG/NASDAQ_AAPL", rows = 5, sort = "desc", type = "xts")
candleChart(apple,show.grid = F)

# final
Apple = Quandl("GOOG/NASDAQ_AAPL",type = "xts", start_date = "2014-08-01", end_date = "2014-09-01", sort = "asc", transformation = "rdiff")
candleChart(Apple)

#　使用R语言构造投资组合的有效前沿
# 载入 quatnmod 包
require(quantmod) 

# 下载 QQQ/SPY/YHOO 交易数据
getSymbols(c('QQQ','SPY','YHOO'))

# 计算收益率序列
QQQ_ret=dailyReturn(QQQ)  
SPY_ret=dailyReturn(SPY)
YHOO_ret=dailyReturn(YHOO)
plot(YHOO_ret)
plot(dailyReturn(Apple))

# 合并收益率序列。
dat=merge(QQQ_ret,SPY_ret,YHOO_ret)
