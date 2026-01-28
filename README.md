# bioinformatics-capstone-bailey-jannuzzi: Evaluating Properties of Bacteria Isolated from UVU's Campus

This repository contains the code, data, and documentation for UVU's Spring 2026 Bioinformatics Capstone project..<br>
The project involves the assembly and annotation of an isolated bacteria genome and running comparative analyses.<br> 

### Project Interpretation
Final conclusion can be found in the [insert] directory.

**Key Results:** <br>
To be added.

## Tools & Software

| Tool / Software | Packages / Description | Links |
|-----------------|------------------------|-------|
| **fastp 0.23.4** | Used to perform quality checks and trim reads. | [![Fastp GitHub](https://github.com/OpenGene/fastp.git)
| **[insert]** | [insert] |
| **[insert]** | [insert] |

## Usage

Script files are named: script-##_[description].sh. <br>
Files contained in the **scripts/** directory can be run in order. <br><br>
***MUST download any tools/software listed above before running scripts.*** <br><br>
**Sequencing data cannot be uploaded due to size. If you are wanting to run this pipeline as is, with the original data, you must put the compressed FASTQ files into the _data/raw/compressed_files/_ directory.** <br>
Sequencing data can be retrieved through request as it is not hosted on a public storage site. <br> <br>

### Potential Errors: <br>
Errors may occur if different tool/software versions are used as commands and their flags may be changed across versions. If an error occurs, check your version usage. <br>
Additional possible errors may result from files or directories being renamed. If pulling directly from this repository, do not change directory structure or file names, this will prevent name errors. <br>

## Directory Structure

| Sub-Directory | Content Description |
|---------------|---------|
| **data/** | Contains sub-directories: metadata/; raw/; qc/, as well as all appropriate files. Further descriptions are provided in these sub-directories independent README files. |
| **scripts/** | Contains all scripts needed to get project results. |
