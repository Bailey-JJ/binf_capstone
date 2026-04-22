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

| Tool | Version | Purpose | Version Link |
|------|---------|---------|--------------|
| BUSCO | 6.0.0 | Genome completeness assessment. Checks assembly quality against conserved bacterial gene sets | https://gitlab.com/ezlab/busco/-/releases/6.0.0 |
| QUAST | v5.3.0 | Assembly statistics. Provides contiguity metrics (N50, contig count, total length, etc.) | https://sourceforge.net/projects/quast/files/quast-5.3.0.tar.gz/ |
| Bakta | 1.12.0 | Genome annotation | https://zenodo.org/records/14916843/files/db.tar.xz?download=1 |
| ROARY | 3.13.0 | Pan-genome pipeline and core genome identification | https://github.com/sanger-pathogens/Roary/releases/tag/v3.13.0 |
| PEPPAN | 1.0.6 | Pan-genome analysis and core genome identification | https://github.com/zheminzhou/PEPPAN |
| PhiSpy | 5.0.6 | Prophage detection in annotated bacterial genomes | https://github.com/linsalrob/PhiSpy |
| ABRicate | 1.4.0 | AMR gene screening against curated databases | https://github.com/tseemann/abricate |

BUSCO, QUAST, and Bakta tools were run via conda environments for reproducibility.


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
Separate conda environments for running BUSCO & QUAST. <br>
Run scripts in order found in the scripts folder. <br>
Scripts must be run using their associated conda environment. <br>

```bash
conda create -n busco_env -c conda-forge -c bioconda busco=5
conda create -n quast_env -c bioconda -c conda-forge quast
conda create -n bakta_env -c conda-forge -c bioconda bakta
conda create -n phispy_env -c conda-forge -c bioconda phispy
conda create -n abricate_env -c conda-forge -c bioconda abricate
```

#### 2. Run BUSCO
```bash
conda activate busco_env
bash scripts/script-01_busco.sh
```

### 3. Run QUAST

```bash
conda activate quast_env
bash scripts/script-02_quast.sh
```

### 4. Run Bakta

```bash
conda activate bakta_env
bash scripts/script-03_bakta.sh
```

### 4. Run Phispy and ABRicate

```bash
conda activate phispy_env
bash scripts/script-04_run_phispy.sh

conda activate bakta_env
bash scripts/script-05_run_abricate.sh

bash scripts/scripts-06.sh
```

# Project Structure

| Directory | Contents |
|-----------|----------|
| `data/clean/` | Cleaned and processed data files |
| `data/metadata/` | Sample metadata files |
| `data/raw/genomes/` | Input `.fna` genome assemblies, named by GCF accession |
| `output/assembly_evaluation/` | Per-genome BUSCO & QUAST output directories (one per GCF accession) |
| `output/genome_annotation/` | Output files for genome annotations. |
| `output/amr-prophage/amr/` | ABRicate results (CARD, NCBI, ResFinder) |
| `output/amr-prophage/prophage/` | PhySpy results per genome |
| `output/amr-prophage/figures/` | Visualizations for analyses |
| `scripts/` | All analysis scripts in order of use | 

## Notes

- This project starts from pre-assembled genomes; no read trimming, assembly, or polishing steps were performed.
- Quality control (BUSCO, QUAST) is a checkpoint before proceeding to comparative genomics analyses.
