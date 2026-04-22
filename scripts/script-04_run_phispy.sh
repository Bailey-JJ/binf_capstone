#!/bin/bash
# run_phispy.sh
# Prophage detection using PhiSpy on Bakta-annotated GenBank files

ANNOTATION_DIR=~/Desktop/binf_capstone/output/genome_annotation
OUTPUT_DIR=~/Desktop/binf_capstone/output/amr-prophage/prophage
mkdir -p "$OUTPUT_DIR"

for gbff in "$ANNOTATION_DIR"/*/*_genomic.gbff; do
    sample=$(basename "$gbff" .gbff)
    echo "Running PhiSpy on: $sample"

    phispy "$gbff" \
        -o "$OUTPUT_DIR/$sample" \
        --output_choice 3 \
        --threads 4

    echo "  Finished: $sample"
done

echo "All PhiSpy runs complete. Results in $OUTPUT_DIR"