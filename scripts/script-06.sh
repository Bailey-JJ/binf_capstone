#!/bin/bash

# ── PHISPY SUMMARY ─────────────────────────────────────────────
# See how many prophages were found per genome
echo "=== PROPHAGE COUNTS PER GENOME ==="
for dir in ~/Desktop/binf_capstone/output/amr-prophage/prophage/*/; do
    sample=$(basename "$dir")
    count=$(grep -c "^PROPHAGE" "$dir/phispy.log" 2>/dev/null || echo 0)
    echo "$sample: $count prophages"
done

# Preview the coordinates file from one genome
echo ""
echo "=== EXAMPLE PROPHAGE COORDINATES (first genome) ==="
head -20 ~/Desktop/binf_capstone/output/amr-prophage/prophage/GCF_000007545.1_ASM754v1_genomic/prophage_coordinates.tsv

# ── ABRICATE SUMMARY ───────────────────────────────────────────
echo ""
echo "=== AMR CARD SUMMARY (first 5 cols) ==="
cut -f1-6 ~/Desktop/binf_capstone/output/amr-prophage/amr/amr_card_summary.tab

echo ""
echo "=== CARD GENE COUNTS PER GENOME ==="
grep -v "^#" ~/Desktop/binf_capstone/output/amr-prophage/amr/amr_card.tab | \
    awk '{print $1}' | sort | uniq -c | sort -rn



# Correct prophage counts from coordinates files
echo "=== REAL PROPHAGE COUNTS ==="
for dir in ~/Desktop/binf_capstone/output/amr-prophage/prophage/*/; do
    sample=$(basename "$dir")
    coords="$dir/prophage_coordinates.tsv"
    if [ -f "$coords" ]; then
        count=$(grep -c "^pp" "$coords" 2>/dev/null || echo 0)
    else
        count=0
    fi
    echo "$sample: $count"
done

# What drug classes are represented in CARD results?
echo ""
echo "=== AMR DRUG CLASSES (CARD) ==="
grep -v "^#" ~/Desktop/binf_capstone/output/amr-prophage/amr/amr_card.tab | \
    awk -F'\t' '{print $15}' | sort | uniq -c | sort -rn | head -20

# What resistance mechanisms?
echo ""
echo "=== RESISTANCE MECHANISMS ==="
grep -v "^#" ~/Desktop/binf_capstone/output/amr-prophage/amr/amr_card.tab | \
    awk -F'\t' '{print $14}' | sort | uniq -c | sort -rn | head -20