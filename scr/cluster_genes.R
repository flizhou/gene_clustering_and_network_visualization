# author: fanlizhou

"Identifies gene clustering and visualizes with heatmaps

Usage: src/clean_data.R --input=<input_file> --out_dir=<out_dir>

Options:

--input=<input_file> Path (including filename) to the microarray data.

--out_dir=<out_dir>  Path to directory where the results will be saved.

" -> doc

library(tidyverse)
library(docopt)
library(gplots) 

opt <- docopt(doc)

main <- function(input, out_dir) {

  # load the data saved in data_clean.R
  lnames <- load(file = input)
  datExpr <- tibble(datExpr)

  # Select data set for analyzing
  datExpr <- datExpr[c(-1,-6, -9)]
  datExpr <- tibble(rowMeans(datExpr[c(1,2)]), rowMeans(datExpr[c(3,4)]), 
                    rowMeans(datExpr[c(5,6)]), rowMeans(datExpr[c(7,8,9)]))
  colnames(datExpr) <- c("WTC","WTH","GC","GH")

  # Identify gene clusters with hclust
  hc <- hclust(dist(t(datExpr), method = "manhattan"), method = "complete")
  hr <- hclust(dist(datExpr, method = "manhattan"), method = "complete")

  mycl <- cutree(hr, h = max(hr$height)/3)
  mycolhc <- rainbow(length(unique(mycl)), start = 0.1, end = 0.9)
  mycolhc <- mycolhc[as.vector(mycl)]
  mycol <- colorpanel(40, "green", "black", "red")

  # Plot heatmap
  heatmap.2(as.matrix(datExpr), Rowv = as.dendrogram(hr), Colv = as.dendrogram(hc), 
            col = mycol, scale = "row", density.info = "none", trace = "none", 
            RowSideColors = mycolhc)
  my <- tibble(mycl)
  my$genes <- rownames(my)

  for (i in c(1:5)){
    filename = paste("group", toString(i), ".csv", sep = "")
    write.csv(my[my$mycl == i,]$genes, file = paste(out_dir, filename, sep = "/"))
  }

  legend("topright", legend = levels(as.factor(mycl)), fill = unique(mycolhc), horiz=TRUE)

}        

main(opt[["--input"]], opt[["--out_dir"]])