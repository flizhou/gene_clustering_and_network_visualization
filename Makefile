# Driver script
# Fanli Zhou
# 
# This driver script completes the analysis of gene clustering.
# This script takes no arguments.
# 
# usage: make all

# run all analysis
all: results/group1.csv results/group2.csv results/group3.csv results/group4.csv results/group5.csv results/CytoscapeInput-edges-all-grey-blue-turquoise.txt results/CytoscapeInput-nodes-all-grey-blue-turquoise.txt

# pre-processing/clean data 
data/clean_data/GCN2-TLS-1000-dataInput.RData: data/raw_data/TLS_gcrma.csv
	Rscript src/clean_data.R --input="data/raw_data/TLS_gcrma.csv" --output="data/clean_data"

# data analysis
: src/clean_data.R data/clean_data/GCN2-TLS-1000-dataInput.RData
	Rscript src/analyze_outliers.R --input="data/clean_data/GCN2-TLS-1000-dataInput.RData"

# cluster genes
results/group1.csv results/group2.csv results/group3.csv results/group4.csv results/group5.csv: src/clean_data.R data/clean_data/GCN2-TLS-1000-dataInput.RData
	Rscript src/cluster_genes.R --input="data/clean_data/GCN2-TLS-1000-dataInput.RData" --output="results"

# construct network
data/clean_data/GCN2-TLS-1000-networkConstruction-auto.RData: src/clean_data.R data/clean_data/GCN2-TLS-1000-dataInput.RData
	Rscript src/construct_network.R --input="data/clean_data/GCN2-TLS-1000-dataInput.RData" --output="data/clean_data"

# visualize network
results/CytoscapeInput-edges-all-grey-blue-turquoise.txt results/CytoscapeInput-nodes-all-grey-blue-turquoise.txt: src/clean_data.R data/clean_data/GCN2-TLS-1000-dataInput.RData src/construct_network.R data/clean_data/GCN2-TLS-1000-networkConstruction-auto.RData
	Rscript src/visualize_network.R --input_1="data/clean_data/GCN2-TLS-1000-dataInput.RData" --input_2="data/clean_data/GCN2-TLS-1000-dataInput.RData" --output="results"

# Clean up intermediate and results files
clean: 
	rm -rf data/clean_data/*csv data/clean_data/*RData
			