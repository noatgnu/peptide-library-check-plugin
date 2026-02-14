process PEPTIDE_LIBRARY_CHECK {
    label 'process_medium'

    container "${ workflow.containerEngine == 'singularity' ?
        'docker://cauldron/peptide-library-check:1.0.0' :
        'cauldron/peptide-library-check:1.0.0' }"

    input:
    path file_path
    val peptide_column
    path fasta_file
    val miss_cleavage
    val min_length

    output:
    
    path "peptide_in_library.txt", emit: peptide_in_library_txt, optional: true
    path "versions.yml", emit: versions

    script:
    def args = task.ext.args ?: ''
    """
    # Build arguments dynamically to match CauldronGO PluginExecutor logic
    ARG_LIST=()

    
    # Mapping for miss_cleavage
    VAL="$miss_cleavage"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--miss-cleavage" "\$VAL")
    fi
    
    # Mapping for min_length
    VAL="$min_length"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--min-length" "\$VAL")
    fi
    
    # Mapping for file_path
    VAL="$file_path"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--input" "\$VAL")
    fi
    
    # Mapping for peptide_column
    VAL="$peptide_column"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--peptide-col" "\$VAL")
    fi
    
    # Mapping for fasta_file
    VAL="$fasta_file"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--fasta" "\$VAL")
    fi
    
    python /app/library_check_peptide.py \
        "\${ARG_LIST[@]}" \
        --output-dir . \
        \${args:-}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Peptide Library Check: 1.0.0
    END_VERSIONS
    """
}
