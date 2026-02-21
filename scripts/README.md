| Script | Description |
| --- | --- |
| `scripts/script-01_busco.sh` | Bash for loop that runs BUSCO v6.0.0 on each `.fna` genome assembly in `data/raw/genomes/`, using the `bacteria_odb10` lineage in genome mode. Outputs one directory per genome to `assembly_evaluation/busco_output/` |
| `scripts/script-02_quast.sh` | Bash for loop that runs QUAST on each `.fna` genome assembly in `data/raw/genomes/`. Outputs one directory per genome to `assembly_evaluation/quast_output/` |
