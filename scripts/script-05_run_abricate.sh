#!/bin/bash
# run_abricate.sh
# AMR gene screening using ABRicate against CARD and NCBI databases

GENOMES_DIR=~/Desktop/binf_capstone/data/raw/genomes/filtered_genomes
OUTPUT_DIR=~/Desktop/binf_capstone/output/amr-prophage/amr
mkdir -p "$OUTPUT_DIR"

echo "Running ABRicate against CARD database..."
abricate --db card "$GENOMES_DIR"/*.fna > "$OUTPUT_DIR/amr_card.tab"

echo "Running ABRicate against NCBI database..."
abricate --db ncbi "$GENOMES_DIR"/*.fna > "$OUTPUT_DIR/amr_ncbi.tab"

echo "Running ABRicate against ResFinder database..."
abricate --db resfinder "$GENOMES_DIR"/*.fna > "$OUTPUT_DIR/amr_resfinder.tab"

echo "Generating summary matrices..."
abricate --summary "$OUTPUT_DIR/amr_card.tab" > "$OUTPUT_DIR/amr_card_summary.tab"
abricate --summary "$OUTPUT_DIR/amr_ncbi.tab" > "$OUTPUT_DIR/amr_ncbi_summary.tab"
abricate --summary "$OUTPUT_DIR/amr_resfinder.tab" > "$OUTPUT_DIR/amr_resfinder_summary.tab"

echo "All ABRicate runs complete. Results in $OUTPUT_DIR"