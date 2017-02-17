# load MASS and Boston
library(MASS)
data('Boston')

s_boston <- scale(Boston)
# euclidean distance matrix
dist_eu <- dist(s_boston)

# look at the summary of the distances
summary(dist_eu)


# k-means clustering
km <-kmeans(dist_eu, centers = 15)

# plot the Boston dataset with clusters
pairs(Boston, col = km$clusters)
# MASS, ggplot2 and Boston dataset are available
set.seed(123)


# determine the number of clusters
k_max <- 10

# calculate the total within sum of squares
twcss <- sapply(1:k_max, function(k){kmeans(dist_eu, k)$tot.withinss})

# visualize the results
plot(1:k_max, twcss, type='b')

# k-means clustering
km <-kmeans(dist_eu, centers = 2)

# plot the Boston dataset with clusters
pairs(s_boston, col = km$cluster)



