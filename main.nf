#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// the modules that you want to use from your ./modules subfolder
include { PROCESS_1 ; PROCESS_2 } from './modules/module_a'
include { PROCESS_3 } from './modules/module_b'
	    

def helpMessage() {
    log.info params.help_message
}

if (params.help) {
    helpMessage()
    exit 0
}

// Checks if output is specified on command line
if (!params.output) {
    log.error "--output is required"
    exit 1
}

// checks required inputs
// and creates an input channel for processes
if (params.input_table) {
  Channel
    .fromPath(params.input_table)
    .splitCsv(header: ['name', 'fastq1', 'fastq2'], sep: ";")
    .map{ row-> tuple(row.name, row.fastq1, row.fastq2) }
    .set { input_files }
} else {
  exit 1, "Input table not specified!"
}


workflow {
    // Your first process is run here
    // only dependent on your input table
    PROCESS_1(input_files)

    // Your second process depends on the results of the first process
    PROCESS_2(PROCESS_1.out.results)

    // Your third process collects the results of the second process for all samples
    PROCESS_3(PROCESS_2.out.results.collect())


    // ---- PROCESS_1 (sample 1) ---- PROCESS_1 (sample 2) ----
    // ----------    |    ------------------- | ---------------
    // ---- PROCESS_2 (sample 1) ---- PROCESS_2 (sample 2) ----
    // -------------- \ --------------------- / ---------------
    // -------------- PROCESS_3 (sample 1, sample 2) ----------
}
