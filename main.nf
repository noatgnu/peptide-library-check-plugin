#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { PEPTIDE_LIBRARY_CHECK } from './modules/local/peptide-library-check/main'

workflow PIPELINE {
    main:
    PEPTIDE_LIBRARY_CHECK (
        params.file_path ? Channel.fromPath(params.file_path).collect() : Channel.of([]),
        Channel.value(params.peptide_column ?: ''),
        params.fasta_file ? Channel.fromPath(params.fasta_file).collect() : Channel.of([]),
        Channel.value(params.miss_cleavage ?: ''),
        Channel.value(params.min_length ?: ''),
    )
}

workflow {
    PIPELINE ()
}
