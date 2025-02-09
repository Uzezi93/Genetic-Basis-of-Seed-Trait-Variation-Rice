# Boxplots for data with the presence of awns to check if its a problem

# V600001
a <- ggplot(data = filter(metrics.noOut, measurementlabel == "V600001"), aes(y = Major.Axis)) + xlab("V600001") + geom_boxplot()

# V600039
b <- ggplot(data = filter(metrics.noOut, measurementlabel == "V600039"), aes(y = Major.Axis)) + xlab("V600039") + geom_boxplot()

# V600181
c <- ggplot(data = filter(metrics.noOut, measurementlabel == "V600181"), aes(y = Major.Axis)) + xlab("V600181") + geom_boxplot()

# V600017
d <- ggplot(data = filter(metrics.noOut, measurementlabel == "V600017"), aes(y = Major.Axis)) + xlab("V600017") + geom_boxplot()

# V600019
e <- ggplot(data = filter(metrics.noOut, measurementlabel == "V600019"), aes(y = Major.Axis)) + xlab("V600019") + geom_boxplot()

# V600021
f <- ggplot(data = filter(metrics.noOut, measurementlabel == "V600021"), aes(y = Major.Axis)) + xlab("V600021") + geom_boxplot()

grid.arrange(a,b,c,d,e,f, ncol= 3)