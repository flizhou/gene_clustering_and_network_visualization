'''

@fanlizhou

Identify gene clustering and visualize with heatmaps

'''

library(gplots) 

# load the data saved in data_clean.R
lnames <- load(file = "GCN2-TLS-1000-dataInput.RData")
datExpr <- data.frame(datExpr)

# Select data set for analyzing
datExpr <- datExpr[c(-1,-6, -9)]
datExpr <- data.frame(rowMeans(datExpr[c(1,2)]),rowMeans(datExpr[c(3,4)]),rowMeans(datExpr[c(5,6)]),rowMeans(datExpr[c(7,8,9)]))
colnames(datExpr) <- c("WTC","WTH","GC","GH")

# Identify gene clusters with hclust
hc <- hclust(dist(t(datExpr), method = "manhattan"), method = "complete")
hr <- hclust(dist(datExpr, method = "manhattan"), method = "complete")

mycl <- cutree(hr, h=max(hr$height)/3)
mycolhc <- rainbow(length(unique(mycl)), start=0.1, end=0.9)
mycolhc <- mycolhc[as.vector(mycl)]
mycol <- colorpanel(40, "green", "black", "red")

# Plot heatmap
heatmap.2(as.matrix(datExpr), Rowv=as.dendrogram(hr), Colv=as.dendrogram(hc), col=mycol, scale="row", 
          density.info="none", trace="none", RowSideColors=mycolhc)
my <- data.frame(mycl)
my$genes <- rownames(my)

for (i in c(1:5)){
  filename = paste("group",toString(i),".csv",sep="")
  write.csv(my[my$mycl ==i,]$genes, file = filename)
}

legend("topright", legend = levels(as.factor(mycl)), fill = unique(mycolhc), horiz=TRUE)

       
