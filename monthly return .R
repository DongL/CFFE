# 1 monthly return
# -load the monthly Starbucks return data
data_url = "http://faculty.washington.edu/ezivot/econ424/sbuxPrices.csv"
sbux_df  = read.csv(file=data_url, header=TRUE, stringsAsFactors=FALSE)

# -get a feel for the data
str(sbux_df)
head(sbux_df)
tail(sbux_df)
class(sbux_df$Date)

# -Extract the price data
closing_prices = sbux_df[, "Adj.Close", drop = F]


# -Find indices associated with the dates 3/1/1994 and 3/1/1995
index_1 = which(sbux_df$Date == "3/1/1994")
index_2 = which(sbux_df$Date == "3/1/1995")
# Extract prices between 3/1/1994 and 3/1/1995
some_prices = sbux_df[index_1:index_2, "Adj.Close", drop = F]

# -Subset directly on dates
## Create a new data frame that contains the price data with the dates as the row names
sbux_prices_df = sbux_df[, "Adj.Close", drop=FALSE]
rownames(sbux_prices_df) = sbux_df$Date
head(sbux_prices_df)
## Find indices associated with the dates 3/1/1994 and 3/1/1995.
price_1 = sbux_prices_df["3/1/1994",];
price_2 = sbux_prices_df["3/1/1995",];

# -Plot the price data
plot(sbux_df$Adj.Close, type="l", col="blue", 
     lwd=2, ylab="Adjusted close",
     main="Monthly closing price of SBUX")

# -Calculate simple returns
sbux_prices_df = sbux_df[, "Adj.Close", drop=FALSE]

## Denote n the number of time periods:
n = nrow(sbux_prices_df)
sbux_ret = ((sbux_prices_df[2:n, 1] - sbux_prices_df[1:(n-1), 1])/sbux_prices_df[1:(n-1), 1])

### alternative method 1
diff(sbux_df[, "Adj.Close", drop=T])/lag(sbux_df[, "Adj.Close", drop=T], k = -1)

### alternative method 2
library(dplyr)
((lead(sbux_prices_df[,1]) - sbux_prices_df[,1])/sbux_prices_df[,1])

## Notice that sbux_ret is not a data frame object
class(sbux_ret)

# -Add dates to simple return vector
names(sbux_ret) = sbux_df[2:n,1]
head(sbux_ret)

# -Compute continuously compounded 1-month returns
sbux_ccret = log(sbux_prices_df[2:n,1]) - log(sbux_prices_df[1:(n-1),1])
## Assign names to the continuously compounded 1-month returns
names(sbux_ccret) = sbux_df[2:n,1]
head(sbux_ccret)

# -Compare simple and continuously compounded returns
head(cbind(sbux_ret, sbux_ccret))

# -Graphically compare the simple and continuously compounded returns
plot(sbux_ret, type="l", col="blue", lwd=2, ylab="Return",
     main="Monthly Returns on SBUX")

## Add horizontal line at zero
abline(h=0)

## Add a legend
legend(x="bottomright", legend=c("Simple", "CC"), 
       lty=1, lwd=2, col=c("blue","red"))

## Add the continuously compounded returns
lines(sbux_ccret, col="red", lwd=2)

# -Calculate growth of $1 invested in SBUX
## Compute gross returns
sbux_gret = 1 + sbux_ret

## Compute future values
sbux_fv = cumprod(sbux_gret)

## Plot the evolution of the $1 invested in SBUX as a function of time
plot(sbux_fv, type="l", col="blue", lwd=2, ylab="Dollars", 
     main="FV of $1 invested in SBUX")
