#!/bin/bash

# Running a for loop for getting QUAST scores for each genome

DIR="/home/bailey/Desktop/binf_capstone"
GEN="data/raw/genomes"
OUTPUT="output/assembly_evaluation/quast_output"

for file in $DIR/$GEN/*.fna; do
    sample=$(basename "$file" .fna)
    echo "Running $file"
    quast.py "$file" -o "$DIR/$OUTPUT/${sample}_quast"
done
