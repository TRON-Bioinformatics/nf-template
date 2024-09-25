process PROCESS_1 {
    label 'process_1'
    tag "${name}"
    publishDir "${params.output}/${name}", mode: 'copy'

    conda ("${baseDir}/environments/module_a.yml")

    input:
      tuple val(name), path(fastq1), path(fastq2)

    output:
      val("${name}"),
      emit: results

    """
    echo "Process 1: ${name} -> ${fastq1}, ${fastq2}"
    """
}

process PROCESS_2 {
    label 'process_2'
    tag "${name}"
    publishDir "${params.output}/${name}", mode: 'copy'

    conda ("${baseDir}/environments/module_a.yml")

    input:
      val(name)

    output:
      val("${name}"),
      emit: results

    """
    echo "Process 2: ${name}"
    """
}
