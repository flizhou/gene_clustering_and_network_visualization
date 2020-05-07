# author: fanlizhou

"Cleans the microarray data, following the WGCNA tutorial

Usage: src/clean_data.R --input=<input_file> --out_dir=<out_dir>

Options:

--input=<input_file> Path (including filename) to the microarray data (a csv file).

--out_dir=<out_dir>  Path to directory where the results will be saved.

" -> doc

library(WGCNA)
library(tidyverse)
library(docopt)

opt <- docopt(doc)

main <- function(input, out_dir) {
  # Read in microarray data set
  rawData <- read_csv(input)
  dim(rawData)
  names(rawData)
  datExpr0 <- as.data.frame(rawData)
  rownames(datExpr0) <- datExpr0$X
  datExpr0$X <- NULL
  geneData <- read.delim("geneNames")
  geneName <- geneData$x
  datExpr0 <- datExpr0[geneName,]

  # Transpose data set
  datExpr0 <- t(datExpr0)
  dim(rawData)
  names(rawData)

  # Reset row names
  rownames(datExpr0) <- c("WTC_1","WTC_2","WTC_3","WTH_1","WTH_2",
                          "WTH_3","GC_1","GC_2","GC_3","GH_1","GH_2","GH_3")
  dim(datExpr0)
  names(datExpr0)

  # Check for genes and samples with too many missing values
  gsg <- goodSamplesGenes(datExpr0, verbose = 3)
  if (!gsg$allOK)
  {
    if (sum(!gsg$goodGenes)>0)
      printFlush(paste("Removing genes:", paste(names(datExpr0)[!gsg$goodGenes], sep = ", ")))
    if (sum(!gsg$goodSamples)>0)
      printFlush(paste("Removing samples:", paste(rownames(datExpr0)[!gsg$goodSamples], sep = ", ")))
    # Remove the offending genes and samples from the data
    datExpr0 <- datExpr0[gsg$goodSamples, gsg$goodGenes]
  }

  sampleTree <- hclust(dist(datExpr0), method <- "average")

  # Plot the sample tree
  sizeGrWindow(12, 9)
  par(cex <- 0.6)
  par(mar <- c(0,4,2,0))
  plot(sampleTree, main = "Sample clustering to detect outliers", 
  sub = "", xlab = "", cex.lab = 1.5, cex.axis = 1.5, cex.main =2)

  # Plot a line to show the cut
  abline(h = 5, col = "red")

  # Determine cluster under the line
  clust <- cutreeStatic(sampleTree, cutHeight = 5, minSize = 3)
  table(clust)

  # Clust 0 contains the samples to keep
  keepSamples <- (clust == 0)
  datExpr <- datExpr0[keepSamples,]
  datExpr <- datExpr0[-c(1,6),]
  nSamples <- ncol(datExpr)
  nGenes <- nrow(datExpr)

  colname <- colnames(datExpr)
  datExpr <- t(datExpr)

  # calculate mean values
  datExpr <- tibble(WTC = as.vector(rowMeans(datExpr[,c(1:2)])), 
                    WTH = as.vector(rowMeans(datExpr[,c(3:4)])), 
                    GC = as.vector(rowMeans(datExpr[,c(5:7)])), 
                    GH = as.vector(rowMeans(datExpr[,c(8:10)])))

  datExpr <- t(datExpr)
  colnames(datExpr) <- colname

  save(datExpr, file = paste(out_dir, "GCN2-TLS-1000-dataInput.RData", sep = "/")
}

main(opt[["--input"]], opt[["--out_dir"]])