#!/bin/bash

# Navigate to home directory
cd ~

# Create Informatics_573 directory and navigate to it
mkdir Informatics_573
cd Informatics_573

# Download and unzip all human chromosome 1 secondary assemblies
# 1. grab the webpage, and extract all file names in href link
wget -qO- https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/ | \
grep -o 'href="[^"]*"' | sed 's/href="//;s/"//' | \
# 2. select all files containing chr1, and filter out chr1.fa.gz
grep -E '^chr1[._]' | grep -v '^chr1\.fa\.gz$' | \
# 3. Download
awk '{print "https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/" $0}' > download_files.txt

wget -i download_files.txt

gunzip *.gz

# Create data_summary.txt
touch data_summary.txt

# Append detailed information to data_summary.txt
ls -lh *.fa >> data_summary.txt

# Append the first 10 lines of each file
head *.fa >> data_summary.txt

# Append the name of assembly and the total number of lines
echo "Assembly: hg38" >> data_summary.txt
echo "Total number of lines: $(cat *.fa | wc -l)" >> data_summary.txt
