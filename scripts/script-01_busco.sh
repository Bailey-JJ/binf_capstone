#!/bin/bash

# Running a for loop for getting busco scores for each genome
DIR="/home/bailey/Desktop/binf_capstone"
GEN="data/raw/genomes"
OUTPUT="output/assembly_evaluation/busco_output"

for file in $DIR/$GEN/*.fna; do
    sample=$(basename "$file" .fna)
    echo "Running $file"
    busco -i "$file" -o "$DIR/$OUTPUT/${sample}_busco" -m genome -l bacteria_odb10
done
