# nf-template
Nextflow template for fast pipeline generation


## Installation

### Dependencies

Look at `environment.yml` for the individual dependencies for running nextflow.
The pipeline also supports Slurm (>= 20.11.4) if you want to process larger cohorts.

### Download

`git clone git@github.com:TRON-Bioinformatics/nf-template.git`

### Configure Environment

```
cd nf-template
conda env create -f environment.yml --prefix conda_env/
```

### References

Specify pathes to your references in your `nextflow.config`.

## Usage

### Prepare your input table

The pipeline requires comma-separated, headerless input table of the following format:

|           |        |        |
| --------- | ------ | ------ |
| Sample_01 | fastq1 | fastq2 |
| Sample_02 | fastq1 | fastq2 |


### Start pipeline

```
source /path/to/your/miniconda3/bin/activate /path/to/conda_env
nextflow run main.nf -profile [standard|cluster] --input_table <path_to_input_table> --output <path_to_output>
```