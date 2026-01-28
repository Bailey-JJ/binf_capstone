#!/bin/bash

# Changing directory to make sure script runs in the correct folder.
cd ../data/raw/compressed_files

# Creating output directories:
mkdir -p ../../qc/{raw_reports,trimmed_reads,logs}

# Making the log file:
LOG_FILE="../../qc/logs/fastp_processing.log"

# Looping through the R1 files:

for FWD in *_R1_001.fastq.gz; do

SAMPLE_NAME=${FWD/_R1_001.fastq.gz/}

REV=${FWD/_R1_001.fastq.gz/_R2_001.fastq.gz}

# Ooutput filenames
FWD_OUT="../../qc/trimmed_reads/trimmed_${SAMPLE_NAME}_R1_001_QC.fastq.gz"
REV_OUT="../../qc/trimmed_reads/trimmed_${SAMPLE_NAME}_R2_001_QC.fastq.gz"
HTML_REPORT="../../qc/raw_reports/${SAMPLE_NAME}_fastp.html"
JSON_REPORT="../../qc/raw_reports/${SAMPLE_NAME}_fastp.json"


# run fastp

if fastp --in1 "$FWD" --in2 "$REV" --out1 "$FWD_OUT" --out2 "$REV_OUT" --html "$HTML_REPORT" --json "$JSON_REPORT" --detect_adapter_for_pe \
--trim_front1 20 --trim_tail1 20 --trim_front2 20 --trim_tail2 20 --cut_front --cut_tail --length_required 100 --thread 12 \
--qualified_quality_phred 20 --correction 

2>> "$LOG_FILE"; then
echo "Completed processing: ${SAMPLE_NAME}"

else
echo "Failed to process: ${SAMPLE_NAME}"

fi
echo ""

done
