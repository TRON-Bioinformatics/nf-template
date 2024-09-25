
process PROCESS_3 {
    label 'process_3'
    publishDir "${params.output}/merged_results", mode: 'copy'

    conda ("${baseDir}/environments/module_b.yml")

    input:
      val(input)

    output:
      path("output.txt"), emit: results

    """
    echo "Process 3: ${input}" > output.txt
    """
}
