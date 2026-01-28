#!/bin/bash

######################################

# Script for running quality control and trimming reads.
# Description and reasoning for each flag command are included at the end of this file.

######################################

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


######################################

# Here is a description of each of the flags used in the fastp command. These were chosen based on standard parameters for handling Illumina PE reads.
# Some flag descriptions are taken from the fastp -h description file.

# --in1 ~ Read1 input file name
# --in2 ~ Read2 input file name
# --out1 ~ Read1 output file name
# --out2 ~ Read2 output file name
# --html ~ Output html file name
# --json ~ Output json file name
# --detect_adapter_for_pe ~ Takes a bit longer than other options, but this flag detects PE data to get more clean data.
# --trim_front1 20 ~ Trimming 20 bases infront of read1, best for trimming adaptors from Illumina
# --trim_tail1 20 ~ Trimming 20 bases after read1, best for trimming adaptors from Illumina
# --trim_front2 20 ~ Trimming 20 bases infront of read2, best for trimming adaptors from Illumina
# --trim_tail2 20 ~ Trimming 20 bases after read2, best for trimming adaptors from Illumina
# --cut_front ~ Move a sliding window from front \(5'\) to tail, drop the bases in the window if its mean quality < threshold, stop otherwise.
# --cut_tail ~ Move a sliding window from tail \(3'\) to front, drop the bases in the window if its mean quality < threshold, stop otherwise.
# --length_required 100 ~ Discard reads shorter than 100bp.
# --thread 12 ~ Increasing thread number to run faster.
# --qualified_quality_phred 20 ~ Using a Q20 for quality checking, though a Q20-Q30 tends to be standard. Fastp report will detail both a Q20 and Q30 percentage.
# --correction ~ Enables base correction in overlapped regions (only for PE data).

######################################
