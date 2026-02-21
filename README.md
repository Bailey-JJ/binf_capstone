# bioinformatics-capstone-bailey-jannuzzi: Comparative Genomics of *Salmonella enterica*: Identifying Phage Susceptibility-Associated Genes

## Project Purpose

This project uses comparative genomics to investigate whether there are genes consistently present in phage-susceptible 
*Salmonella enterica* strains that are absent in non-susceptible strains of the same serovar. 
The goal is exploratory: by identifying candidate host-cell receptor genes, we aim to narrow down a more manageable set of 
bacterial clones for downstream phage susceptibility testing.


## Data Source
Genome assemblies were obtained from NCBI based on the following publication:

> Fricke WF, et al. (2011). **Comparative Genomics of 28 Salmonella enterica Isolates: Evidence for CRISPR-Mediated Adaptive Sublineage Evolution.** *Journal of Bacteriology*, 193(14):3556–3568. https://doi.org/10.1128/JB.00297-11
<br>
A total of 28 *Salmonella enterica* genome assemblies were downloaded as `.fna` files using their NCBI accession numbers (GCF format).


## How the Sequences Were Generated
Sequences were originally produced using Sanger sequencing of fosmid libraries, as described in the source publication. Full sequencing methodology details can be found in the original paper. For this project, we are working directly from the published assembled genome files (`.fna`) and are not performing any upstream assembly steps.


## Tools Used

| Tool | Version | Purpose |
|------|---------|---------|
| BUSCO | 6.0.0 | Genome completeness assessment. Checks assembly quality against conserved bacterial gene sets |
| QUAST | - | Assembly statistics. Provides contiguity metrics (N50, contig count, total length, etc.) |

Both tools were run via conda environments for reproducibility.


## Key Parameters and Choices

### BUSCO
- **Mode:** `genome` (prokaryotic genome mode, using Prodigal for gene prediction)
- **Lineage:** `bacteria_odb10` (Creation date: 2024-01-08; 124 BUSCOs across 4,085 reference genomes)
- Each genome was run independently with a separate output directory

### QUAST
- Default parameters
- Each genome was run independently with a separate output directory


## How to Reproduce Results

### 1. Set up conda environments
Separate conda environments for running BUSCO & QUAST

### 2. Run scripts in order found in the scripts folder.
Scripts must be run using their associated conda environment. 
