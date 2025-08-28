#!/usr/bin/env nextflow


// Make db out of seqeunces
process makeCustomDatabase {

    container 'community.wave.seqera.io/library/blast:2.16.0--540f4b669b0a0ddd'
    publishDir "${params.database_outdir}", mode: 'copy'

    input:
    // All fasta seqs must be in ONE txt file
    path "${params.fasta_sequences}"

    output:
    path "${params.database_name}.*"


    script:
    """
    
    makeblastdb -in "${params.fasta_sequences}" -parse_seqids -dbtype 'nucl' -title "${params.database_outdir}" -out "${params.database_name}" 

    """

}

workflow {
    Channel
        .fromPath(params.fasta_sequences)
        .set { db_sequences_ch }
    makeCustomDatabase(db_sequences_ch)
}
