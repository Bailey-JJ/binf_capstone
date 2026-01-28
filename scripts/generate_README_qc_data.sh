#!/bin/bash

# Make sure to be working in the correct directory
cd ../data/qc/raw_reports/

OUTPUT_FILE="../README.md"

# Clear output file
> "$OUTPUT_FILE"

# Add title to README
echo "# Quality Control Reports" > "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Process each JSON file
for json_file in *.json; do
    
    # Skip if no files
    [ -e "$json_file" ] || continue
    
    # Extract sample name
    SAMPLE=$(basename "$json_file" .json | sed 's/_fastp//')
    
    echo "Processing: $SAMPLE"
    
    # Extract metrics using grep and awk
    FASTP_VERSION=$(grep -o '"fastp_version":"[^"]*"' "$json_file" | cut -d'"' -f4)
    SEQUENCING=$(grep -o '"sequencing":"[^"]*"' "$json_file" | cut -d'"' -f4)
    
    # Before filtering
    TOTAL_READS_BEFORE=$(grep -m1 -o '"total_reads":[0-9]*' "$json_file" | cut -d':' -f2)
    TOTAL_BASES_BEFORE=$(grep -m1 -o '"total_bases":[0-9]*' "$json_file" | cut -d':' -f2)
    Q20_BASES_BEFORE=$(grep -m1 -o '"q20_bases":[0-9]*' "$json_file" | cut -d':' -f2)
    Q20_RATE_BEFORE=$(grep -m1 -o '"q20_rate":[0-9.]*' "$json_file" | cut -d':' -f2)
    Q30_BASES_BEFORE=$(grep -m1 -o '"q30_bases":[0-9]*' "$json_file" | cut -d':' -f2)
    Q30_RATE_BEFORE=$(grep -m1 -o '"q30_rate":[0-9.]*' "$json_file" | cut -d':' -f2)
    GC_BEFORE=$(grep -m1 -o '"gc_content":[0-9.]*' "$json_file" | cut -d':' -f2)
    READ1_LEN_BEFORE=$(grep -m1 -o '"read1_mean_length":[0-9.]*' "$json_file" | cut -d':' -f2)
    READ2_LEN_BEFORE=$(grep -m1 -o '"read2_mean_length":[0-9.]*' "$json_file" | cut -d':' -f2)
    
    # After filtering (use tail to get second occurrence)
    TOTAL_READS_AFTER=$(grep -o '"total_reads":[0-9]*' "$json_file" | tail -1 | cut -d':' -f2)
    TOTAL_BASES_AFTER=$(grep -o '"total_bases":[0-9]*' "$json_file" | tail -1 | cut -d':' -f2)
    Q20_BASES_AFTER=$(grep -o '"q20_bases":[0-9]*' "$json_file" | tail -1 | cut -d':' -f2)
    Q20_RATE_AFTER=$(grep -o '"q20_rate":[0-9.]*' "$json_file" | tail -1 | cut -d':' -f2)
    Q30_BASES_AFTER=$(grep -o '"q30_bases":[0-9]*' "$json_file" | tail -1 | cut -d':' -f2)
    Q30_RATE_AFTER=$(grep -o '"q30_rate":[0-9.]*' "$json_file" | tail -1 | cut -d':' -f2)
    GC_AFTER=$(grep -o '"gc_content":[0-9.]*' "$json_file" | tail -1 | cut -d':' -f2)
    READ1_LEN_AFTER=$(grep -o '"read1_mean_length":[0-9.]*' "$json_file" | tail -1 | cut -d':' -f2)
    READ2_LEN_AFTER=$(grep -o '"read2_mean_length":[0-9.]*' "$json_file" | tail -1 | cut -d':' -f2)
    
    # Filtering results
    PASSED_READS=$(grep -o '"passed_filter_reads":[0-9]*' "$json_file" | cut -d':' -f2)
    LOW_QUALITY=$(grep -o '"low_quality_reads":[0-9]*' "$json_file" | cut -d':' -f2)
    TOO_MANY_N=$(grep -o '"too_many_N_reads":[0-9]*' "$json_file" | cut -d':' -f2)
    TOO_SHORT=$(grep -o '"too_short_reads":[0-9]*' "$json_file" | cut -d':' -f2)
    
    # Duplication and insert size
    DUP_RATE=$(grep -o '"dup_rate":[0-9.]*' "$json_file" | cut -d':' -f2)
    INSERT_PEAK=$(grep -o '"peak":[0-9]*' "$json_file" | cut -d':' -f2)
    
    # Convert numbers to M/K format
    reads_before_m=$(echo "scale=6; $TOTAL_READS_BEFORE / 1000000" | bc)
    bases_before_m=$(echo "scale=6; $TOTAL_BASES_BEFORE / 1000000" | bc)
    q20_before_m=$(echo "scale=6; $Q20_BASES_BEFORE / 1000000" | bc)
    q30_before_m=$(echo "scale=6; $Q30_BASES_BEFORE / 1000000" | bc)
    
    reads_after_m=$(echo "scale=6; $TOTAL_READS_AFTER / 1000000" | bc)
    bases_after_m=$(echo "scale=6; $TOTAL_BASES_AFTER / 1000000" | bc)
    q20_after_m=$(echo "scale=6; $Q20_BASES_AFTER / 1000000" | bc)
    q30_after_m=$(echo "scale=6; $Q30_BASES_AFTER / 1000000" | bc)
    
    low_quality_k=$(echo "scale=6; $LOW_QUALITY / 1000" | bc)
    too_short_k=$(echo "scale=6; $TOO_SHORT / 1000" | bc)
    
    # Calculate percentages
    q20_pct_before=$(echo "scale=6; $Q20_RATE_BEFORE * 100" | bc)
    q30_pct_before=$(echo "scale=6; $Q30_RATE_BEFORE * 100" | bc)
    gc_pct_before=$(echo "scale=6; $GC_BEFORE * 100" | bc)
    
    q20_pct_after=$(echo "scale=6; $Q20_RATE_AFTER * 100" | bc)
    q30_pct_after=$(echo "scale=6; $Q30_RATE_AFTER * 100" | bc)
    gc_pct_after=$(echo "scale=6; $GC_AFTER * 100" | bc)
    
    dup_pct=$(echo "scale=6; $DUP_RATE * 100" | bc)
    passed_pct=$(echo "scale=6; $TOTAL_READS_AFTER * 100 / $TOTAL_READS_BEFORE" | bc)
    low_qual_pct=$(echo "scale=6; $LOW_QUALITY * 100 / $TOTAL_READS_BEFORE" | bc)
    too_many_n_pct=$(echo "scale=6; $TOO_MANY_N * 100 / $TOTAL_READS_BEFORE" | bc)
    too_short_pct=$(echo "scale=6; $TOO_SHORT * 100 / $TOTAL_READS_BEFORE" | bc)
    
    # Round mean lengths
    len1_before=$(printf "%.0f" "$READ1_LEN_BEFORE")
    len2_before=$(printf "%.0f" "$READ2_LEN_BEFORE")
    len1_after=$(printf "%.0f" "$READ1_LEN_AFTER")
    len2_after=$(printf "%.0f" "$READ2_LEN_AFTER")
    
    # Write to output file
    cat >> "$OUTPUT_FILE" << EOF
---

EOF
done
