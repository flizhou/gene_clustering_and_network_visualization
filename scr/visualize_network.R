# author: fanlizhou

"Visualizes network data, following the WGCNA tutorial, 

Usage: src/clean_data.R --input_1=<input_file_1> --input_2=<input_file_2> --out_dir=<out_dir>

Options:

--input_1=<input_file_1> Path (including filename) to the microarray data.

--input_2=<input_file_2> Path (including filename) to the network data.

--out_dir=<out_dir>  Path to directory where the results will be saved.

" -> doc

library(WGCNA)
library(tidyverse)
library(docopt)

opt <- docopt(doc)

main <- function(input_1, input_2, out_dir) {
    
    # Load the expression saved in the first part
    lnames <- load(file = input_1)

    #The variable lnames contains the names of loaded variables.
    lnames

    # Load network data saved in the second part.
    lnames <- load(file = input_2)
    lnames

    # Recalculate topological overlap if needed
    TOM <- TOMsimilarityFromExpr(datExpr, power = 6)

    # Read in the annotation file
    annot <- read.csv(file = "gene.csv")

    # Select modules
    modules <- c("grey", "blue","turquoise")

    # Select module probes
    probes <- names(datExpr)
    inModule <- is.finite(match(moduleColors, modules))
    modProbes <- probes[inModule];
    modGenes <- annot$gene_ID[match(modProbes, annot$From)]

    # Select the corresponding Topological Overlap
    modTOM <- TOM[inModule, inModule]
    dimnames(modTOM) <- list(modProbes, modProbes)

    # Export the network into edge and node list files Cytoscape can read
    cyt <- exportNetworkToCytoscape(modTOM,
                                    edgeFile = paste(out_dir, 
                                                    "CytoscapeInput-edges-all-", 
                                                     paste(modules, collapse = "-"), 
                                                     ".txt", 
                                                     sep = ""),
                                    nodeFile = paste(out_dir,
                                                    "CytoscapeInput-nodes-all-", 
                                                    paste(modules, collapse = "-"), 
                                                    ".txt", 
                                                    sep = ""),
                                    weighted = TRUE,
                                    threshold = 0.02,
                                    nodeNames = modProbes,
                                    altNodeNames = modGenes,
                                    nodeAttr = moduleColors[inModule])
}

main(opt[["--input_1"]], opt[["--input_2"]], opt[["--out_dir"]])