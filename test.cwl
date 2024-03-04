{
    "class": "Workflow",
    "cwlVersion": "v1.2",
    "label": "test",
    "$namespaces": {
        "sbg": "https://sevenbridges.com"
    },
    "inputs": [
        {
            "id": "in_reads",
            "sbg:fileTypes": "FASTQ, FQ, FQ.GZ, FASTQ.GZ",
            "type": "File[]",
            "label": "Input FASTQ files",
            "doc": "Input FASTQ files. For paired-end data, please supply both files and ensure that paired_end metadata field is populated with 1 and 2. For single-end data, this metadata field is optional. If filled, please use the value 1.",
            "sbg:x": -173.50526428222656,
            "sbg:y": 27
        },
        {
            "id": "reference_index_tar",
            "sbg:fileTypes": "TAR",
            "type": "File",
            "label": "Reference Index TAR",
            "doc": "Reference fasta file with BWA index files packed in TAR.",
            "sbg:x": -174.4906463623047,
            "sbg:y": -229.2501220703125
        },
        {
            "id": "reference",
            "sbg:fileTypes": "FASTA, FA, FA.GZ, FASTA.GZ",
            "type": "File",
            "label": "FASTA file",
            "doc": "FASTA file to be indexed",
            "sbg:x": -160.28289794921875,
            "sbg:y": -405.20355224609375
        }
    ],
    "outputs": [],
    "steps": [
        {
            "id": "fastp_0_23_1",
            "in": [
                {
                    "id": "in_reads",
                    "source": [
                        "in_reads"
                    ]
                }
            ],
            "out": [
                {
                    "id": "out_html_report"
                },
                {
                    "id": "out_json_report"
                },
                {
                    "id": "out_trimmed_reads"
                }
            ],
            "run": {
                "class": "CommandLineTool",
                "cwlVersion": "v1.1",
                "$namespaces": {
                    "sbg": "https://sevenbridges.com"
                },
                "id": "admin/sbg-public-data/fastp-0-20-1/15",
                "baseCommand": [
                    "fastp"
                ],
                "inputs": [
                    {
                        "sbg:category": "Inputs",
                        "id": "in_reads",
                        "type": "File[]",
                        "label": "Input FASTQ files",
                        "doc": "Input FASTQ files. For paired-end data, please supply both files and ensure that paired_end metadata field is populated with 1 and 2. For single-end data, this metadata field is optional. If filled, please use the value 1.",
                        "sbg:fileTypes": "FASTQ, FQ, FQ.GZ, FASTQ.GZ"
                    },
                    {
                        "sbg:category": "Inputs",
                        "id": "unpaired1",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--unpaired1",
                            "shellQuote": false,
                            "position": 3
                        },
                        "label": "Output file name for unpaired reads (PE 1)",
                        "doc": "For paired-end (PE) data, if read1 passed QC but read2 not, it will be written to this file. Default is to discard it."
                    },
                    {
                        "sbg:category": "Inputs",
                        "id": "unpaired2",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--unpaired2",
                            "shellQuote": false,
                            "position": 2
                        },
                        "label": "Output file name for separate unpaired reads (PE 2)",
                        "doc": "For paired-end (PE) data, if read2 passed QC but read1 not, it will be written to unpaired2. If --unpaired2 is same as --unpaired1 (default mode), both unpaired reads will be written to this same file."
                    },
                    {
                        "sbg:category": "Inputs",
                        "id": "failed_out",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--failed_out",
                            "shellQuote": false,
                            "position": 3
                        },
                        "label": "Output file name for reads that failed filters",
                        "doc": "Specify the file to store reads not passing filters."
                    },
                    {
                        "sbg:altPrefix": "-m",
                        "sbg:category": "Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "merge",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--merge",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Merge overlapping paired-end reads",
                        "doc": "For paired-end input, merge each pair of reads into a single read if they are overlapped. The merged reads will be written to the file given by --merged_out, the unmerged reads will be written to the files specified by --out1 and --out2. The merging mode is disabled by default."
                    },
                    {
                        "sbg:category": "Inputs",
                        "id": "merged_out",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--merged_out",
                            "shellQuote": false,
                            "position": 5
                        },
                        "label": "Output file name for merged reads",
                        "doc": "In merging mode, specify the file name to store merged output."
                    },
                    {
                        "sbg:category": "Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "include_unmerged",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--include_unmerged",
                            "shellQuote": false,
                            "position": 5
                        },
                        "label": "Include unmerged reads in merged mode output",
                        "doc": "In merging mode, write the unmerged or unpaired reads to the file specified by --merge."
                    },
                    {
                        "sbg:altPrefix": "-6",
                        "sbg:category": "Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "phred64",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--phred64",
                            "shellQuote": false,
                            "position": 5
                        },
                        "label": "Input uses phred64 scoring",
                        "doc": "Indicate that the input is using phred64 scoring (it will be converted to phred33 and the output will be phred33)."
                    },
                    {
                        "sbg:altPrefix": "-z",
                        "sbg:category": "Inputs",
                        "sbg:toolDefaultValue": "4",
                        "id": "compression",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--compression",
                            "shellQuote": false,
                            "position": 6
                        },
                        "label": "Compression level for GZIP output",
                        "doc": "Compression level for gzip output (1 - 9). 1 is fastest, 9 is smallest, default is 4."
                    },
                    {
                        "sbg:category": "Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "interleaved_in",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--interleaved_in",
                            "shellQuote": false,
                            "position": 6
                        },
                        "label": "Interleaved FASTQ file input",
                        "doc": "Indicate that input is an interleaved FASTQ which contains both reads 1 and 2. Disabled by default."
                    },
                    {
                        "sbg:category": "Inputs",
                        "sbg:toolDefaultValue": "0",
                        "id": "reads_to_process",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--reads_to_process",
                            "shellQuote": false,
                            "position": 6
                        },
                        "label": "Number of reads/pairs to process",
                        "doc": "Specify how many reads/pairs should be processed. Default 0 means process all reads."
                    },
                    {
                        "sbg:altPrefix": "-V",
                        "sbg:category": "Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "verbose",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--verbose",
                            "shellQuote": false,
                            "position": 6
                        },
                        "label": "Output verbose log information",
                        "doc": "Output verbose log information (i.e. when every 1M reads are processed)."
                    },
                    {
                        "sbg:altPrefix": "-A",
                        "sbg:category": "Adapter trimming",
                        "sbg:toolDefaultValue": "False",
                        "id": "disable_adapter_trimming",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable_adapter_trimming",
                            "shellQuote": false,
                            "position": 7
                        },
                        "label": "Disable adapter trimming",
                        "doc": "Adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled."
                    },
                    {
                        "sbg:altPrefix": "-a",
                        "sbg:category": "Adapter trimming",
                        "id": "adapter_sequence",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--adapter_sequence",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Adapter sequence",
                        "doc": "The adapter sequence for read 1 data. For SE data, if not specified, the adapter will be auto-detected. For PE data, this is used if R1/R2 are found not overlapped. Default is auto-detect."
                    },
                    {
                        "sbg:category": "Adapter trimming",
                        "id": "adapter_sequence_r2",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--adapter_sequence_r2",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Adapter sequence for R2 data",
                        "doc": "The adapter for read2 (PE data only). This is used if R1/R2 are found not overlapped. If not specified, it will be the same as --adapter_sequence. Default is auto-detect."
                    },
                    {
                        "sbg:category": "Adapter trimming",
                        "id": "in_adapter_fasta",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--adapter_fasta",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Adapter FASTA file",
                        "doc": "Specify a FASTA file to trim both read1 and read2 (if PE) by all the sequences in this FASTA file.",
                        "sbg:fileTypes": "FASTA, FA, FASTA.GZ, FA.GZ"
                    },
                    {
                        "sbg:toolDefaultValue": "False",
                        "sbg:category": "Adapter trimming",
                        "id": "detect_adapter_for_pe_via_tail_end",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--detect_adapter_for_pe",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Detect adapter for paired-end data via tail end analysis",
                        "doc": "By default for paired end data, adapter detection is performed via read overlap analysis. Setting this option to 'True' will instead perform adapter detection via tail end analysis (much the same way as for single end data)."
                    },
                    {
                        "sbg:altPrefix": "-f",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "0",
                        "id": "trim_front1",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--trim_front1",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Number of bases to trim from start of R1 reads",
                        "doc": "Number of bases to trim from start of R1 reads. Default: 0."
                    },
                    {
                        "sbg:altPrefix": "-t",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "0",
                        "id": "trim_tail1",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--trim_tail1",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Number of bases to trim from end of R1 reads",
                        "doc": "Number of bases to trim from end of R1 reads. Default: 0."
                    },
                    {
                        "sbg:altPrefix": "-b",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "0",
                        "id": "max_len1",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max_len1",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Maximum length of R1 reads",
                        "doc": "If read1 is longer than max_len1, then trim read1 at its tail to make it as long as max_len1. Default 0 means no limitation."
                    },
                    {
                        "sbg:altPrefix": "-F",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "0",
                        "id": "trim_front2",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--trim_front2",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Number of bases to trim from start of R2 reads",
                        "doc": "Number of bases to trim from start of R2 reads. If unspecified, --trim_front1 value is applied. Default: 0."
                    },
                    {
                        "sbg:altPrefix": "-T",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "0",
                        "id": "trim_tail2",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--trim_tail2",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Number of bases to trim from end of R2 reads",
                        "doc": "Number of bases to trim from end of R2 reads. If unspecified, --trim_tail1 value is applied. Default: 0."
                    },
                    {
                        "sbg:altPrefix": "-B",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "0",
                        "id": "max_len2",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max_len2",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Maximum length of R2 reads",
                        "doc": "If read2 is longer than max_len2, then trim read2 at its tail to make it as long as max_len2. Default 0 means no limitation. If unspecified, --max_len1 value is applied."
                    },
                    {
                        "sbg:altPrefix": "-g",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "False",
                        "id": "trim_poly_g",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--trim_poly_g",
                            "shellQuote": false,
                            "position": 9
                        },
                        "label": "Force polyG tail trimming",
                        "doc": "Force polyG tail trimming, by default trimming is automatically enabled for Illumina NextSeq/NovaSeq data."
                    },
                    {
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "10",
                        "id": "poly_g_min_len",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--poly_g_min_len",
                            "shellQuote": false,
                            "position": 9
                        },
                        "label": "Minimum length to detect polyG read tail",
                        "doc": "Minimum length to detect polyG in the read tail. 10 by default."
                    },
                    {
                        "sbg:altPrefix": "-G",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "False",
                        "id": "disable_trim_poly_g",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable_trim_poly_g",
                            "shellQuote": false,
                            "position": 9
                        },
                        "label": "Disable polyG tail trimming",
                        "doc": "Disable polyG tail trimming, by default trimming is automatically enabled for Illumina NextSeq/NovaSeq data."
                    },
                    {
                        "sbg:altPrefix": "-x",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "False",
                        "id": "trim_poly_x",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--trim_poly_x",
                            "shellQuote": false,
                            "position": 9
                        },
                        "label": "Enable polyX trimming in 3' reads",
                        "doc": "Enable polyX trimming in 3' reads."
                    },
                    {
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "10",
                        "id": "poly_x_min_len",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--poly_x_min_len",
                            "shellQuote": false,
                            "position": 9
                        },
                        "label": "Minimum length to detect polyX in read tail",
                        "doc": "Minimum length to detect polyX in read tail, Default: 10."
                    },
                    {
                        "sbg:altPrefix": "-5",
                        "sbg:category": "Read trimming",
                        "id": "cut_front",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--cut_front",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Cut front",
                        "doc": "Move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise."
                    },
                    {
                        "sbg:altPrefix": "-3",
                        "sbg:category": "Read trimming",
                        "id": "cut_tail",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--cut_tail",
                            "shellQuote": false,
                            "position": 9
                        },
                        "label": "Cut tail",
                        "doc": "Move a sliding window from tail (3') to front, drop the bases in the window if its mean quality < threshold, stop otherwise."
                    },
                    {
                        "sbg:altPrefix": "-r",
                        "sbg:category": "Read trimming",
                        "id": "cut_right",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--cut_right",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Cut right",
                        "doc": "Move a sliding window from front to tail, if meet one window with mean quality < threshold, drop the bases in the window and the right part, and then stop."
                    },
                    {
                        "sbg:altPrefix": "-W",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "4",
                        "id": "cut_window_size",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--cut_window_size",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Cut window size",
                        "doc": "The window size shared by cut_front, cut_tail or cut_sliding. Range: 1~1000, default: 4."
                    },
                    {
                        "sbg:altPrefix": "-M",
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "20",
                        "id": "cut_mean_quality",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--cut_mean_quality",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Cut mean quality",
                        "doc": "The mean quality requirement option shared by cut_front, cut_tail or cut_sliding. Range: 1~36 default: 20 (Q20)."
                    },
                    {
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "4",
                        "id": "cut_front_window_size",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--cut_front_window_size",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Cut front window size",
                        "doc": "The window size option of cut_front, default to cut_window_size if not specified."
                    },
                    {
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "20",
                        "id": "cut_front_mean_quality",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--cut_front_mean_quality",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Cut front mean quality",
                        "doc": "The mean quality requirement option for cut_front, default to cut_mean_quality if not specified."
                    },
                    {
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "4",
                        "id": "cut_tail_window_size",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--cut_tail_window_size",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Cut tail window size",
                        "doc": "The window size option of cut_tail, default to cut_window_size if not specified."
                    },
                    {
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "20",
                        "id": "cut_tail_mean_quality",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--cut_tail_mean_quality",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Cut tail mean quality",
                        "doc": "The mean quality requirement option for cut_tail, default to cut_mean_quality if not specified."
                    },
                    {
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "4",
                        "id": "cut_right_window_size",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--cut_right_window_size",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Cut right window size",
                        "doc": "The window size option of cut_right, default to cut_window_size if not specified."
                    },
                    {
                        "sbg:category": "Read trimming",
                        "sbg:toolDefaultValue": "20",
                        "id": "cut_right_mean_quality",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--cut_right_mean_quality",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Cut right mean quality",
                        "doc": "The mean quality requirement option for cut_right, default to cut_mean_quality if not specified."
                    },
                    {
                        "sbg:altPrefix": "-Q",
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "False",
                        "id": "disable_quality_filtering",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable_quality_filtering",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Disable quality filtering",
                        "doc": "Disable quality filtering.",
                        "default": false
                    },
                    {
                        "sbg:altPrefix": "-q",
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "15",
                        "id": "qualified_quality_phred",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--qualified_quality_phred",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Qualified quality (phred) score",
                        "doc": "Quality value that a base is qualified. Default 15 means phred quality >=Q15 is qualified."
                    },
                    {
                        "sbg:altPrefix": "-u",
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "40",
                        "id": "unqualified_percent_limit",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--unqualified_percent_limit",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Unqualified limit [%]",
                        "doc": "Maximum percent of bases allowed to be unqualified."
                    },
                    {
                        "sbg:altPrefix": "-n",
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "5",
                        "id": "n_base_limit",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--n_base_limit",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Maximum allowed number of N bases",
                        "doc": "If number of N bases in a read/pair exceeds this value, the read/pair is discarded."
                    },
                    {
                        "sbg:altPrefix": "-e",
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "0",
                        "id": "average_qual",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--average_qual",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Minimum average read quality score",
                        "doc": "Reads/pairs with average quality score lower than this threshold are discarded. Default 0 means no reads are discarded."
                    },
                    {
                        "sbg:altPrefix": "-L",
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "False",
                        "id": "disable_length_filtering",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable_length_filtering",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Disable read length filtering",
                        "doc": "Disable read length filtering.",
                        "default": false
                    },
                    {
                        "sbg:altPrefix": "-l",
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "15",
                        "id": "length_required",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--length_required",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Minimum read length allowed",
                        "doc": "Reads shorter than this threshold will be discarded."
                    },
                    {
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "0",
                        "id": "length_limit",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--length_limit",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Maximum read length allowed",
                        "doc": "Reads longer than this threshold will be discarded. Default 0 means no reads are discarded."
                    },
                    {
                        "sbg:altPrefix": "-y",
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "False",
                        "id": "low_complexity_filter",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--low_complexity_filter",
                            "shellQuote": false,
                            "position": 12
                        },
                        "label": "Enable low complexity read filtering",
                        "doc": "Enable low complexity filtering. The complexity is defined as the percentage of bases different from the next base (base[i] != base[i+1])."
                    },
                    {
                        "sbg:altPrefix": "-Y",
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "30",
                        "id": "complexity_threshold",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--complexity_threshold",
                            "shellQuote": false,
                            "position": 12
                        },
                        "label": "Read complexity threshold",
                        "doc": "Threshold for low complexity read filtering (range 0-100). Default is 30, indicating that at least 30% read complexity is required."
                    },
                    {
                        "sbg:category": "Read filtering",
                        "id": "in_filter_by_index1",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--filter_by_index1",
                            "shellQuote": false,
                            "position": 13
                        },
                        "label": "File with index1 barcodes for filtering",
                        "doc": "File with index1 barcodes for filtering, one barcode per line."
                    },
                    {
                        "sbg:category": "Read filtering",
                        "id": "in_filter_by_index2",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--filter_by_index2",
                            "shellQuote": false,
                            "position": 12
                        },
                        "label": "File with index2 barcodes for filtering",
                        "doc": "File with index2 barcodes for filtering, one barcode per line."
                    },
                    {
                        "sbg:category": "Read filtering",
                        "sbg:toolDefaultValue": "0",
                        "id": "filter_by_index_threshold",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--filter_by_index_threshold",
                            "shellQuote": false,
                            "position": 12
                        },
                        "label": "Filter by index threshold",
                        "doc": "The allowed difference of index barcodes for index filtering. Default 0 means completely identical."
                    },
                    {
                        "sbg:altPrefix": "-c",
                        "sbg:category": "Base correction",
                        "sbg:toolDefaultValue": "False",
                        "id": "correction",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--correction",
                            "shellQuote": false,
                            "position": 13
                        },
                        "label": "Enable base correction in overlapped regions",
                        "doc": "Enable base correction in overlapped regions of PE data. Default: disabled."
                    },
                    {
                        "sbg:category": "Paired-end overlapping regions",
                        "sbg:toolDefaultValue": "30",
                        "id": "overlap_len_require",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--overlap_len_require",
                            "shellQuote": false,
                            "position": 13
                        },
                        "label": "Minimum length for detecting overlapped regions",
                        "doc": "The minimum length to detect overlapped region of PE reads. This will affect overlap analysis based PE merge, adapter trimming and correction."
                    },
                    {
                        "sbg:category": "Paired-end overlapping regions",
                        "sbg:toolDefaultValue": "5",
                        "id": "overlap_diff_limit",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--overlap_diff_limit",
                            "shellQuote": false,
                            "position": 13
                        },
                        "label": "Maximum number of mismatched bases for detecting PE overlaps",
                        "doc": "The maximum number of mismatched bases to detect overlapped region of PE reads. This will affect overlap analysis based PE merge, adapter trimming and correction."
                    },
                    {
                        "sbg:category": "Paired-end overlapping regions",
                        "sbg:toolDefaultValue": "20",
                        "id": "overlap_diff_percent_limit",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--overlap_diff_percent_limit",
                            "shellQuote": false,
                            "position": 13
                        },
                        "label": "Maximum % of mismatched bases for detecting PE overlaps",
                        "doc": "The maximum percentage of mismatched bases to detect overlapped region of PE reads. This will affect overlap analysis based PE merge, adapter trimming and correction. Default 20 means 20%."
                    },
                    {
                        "sbg:altPrefix": "-U",
                        "sbg:category": "UMI",
                        "sbg:toolDefaultValue": "False",
                        "id": "umi",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--umi",
                            "shellQuote": false,
                            "position": 14
                        },
                        "label": "Enable UMI preprocessing",
                        "doc": "Enable unique molecular identifier (UMI) preprocessing."
                    },
                    {
                        "sbg:category": "UMI",
                        "sbg:toolDefaultValue": "none",
                        "id": "umi_loc",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "index1",
                                    "index2",
                                    "read1",
                                    "read2",
                                    "per_index",
                                    "per_read"
                                ],
                                "name": "umi_loc"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--umi_loc",
                            "shellQuote": false,
                            "position": 14
                        },
                        "label": "UMI location",
                        "doc": "Specify the location of UMI. Default: none."
                    },
                    {
                        "sbg:category": "UMI",
                        "sbg:toolDefaultValue": "0",
                        "id": "umi_len",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--umi_len",
                            "shellQuote": false,
                            "position": 14
                        },
                        "label": "Length of UMI in read1/read2",
                        "doc": "If the UMI is in read1/read2, the length should be provided."
                    },
                    {
                        "sbg:category": "UMI",
                        "id": "umi_prefix",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--umi_prefix",
                            "shellQuote": false,
                            "position": 14
                        },
                        "label": "UMI prefix",
                        "doc": "If specified, the prefix will be joined to UMI with an underscore (i.e. prefix=UMI, UMI=AATTCG, final=UMI_AATTCG). No prefix by default."
                    },
                    {
                        "sbg:category": "UMI",
                        "sbg:toolDefaultValue": "0",
                        "id": "umi_skip",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--umi_skip",
                            "shellQuote": false,
                            "position": 14
                        },
                        "label": "Number of bases to skip following UMI",
                        "doc": "If the UMI is in read1/read2, fastp can skip several bases following UMI."
                    },
                    {
                        "sbg:altPrefix": "-p",
                        "sbg:category": "Overrepresented sequence analysis",
                        "sbg:toolDefaultValue": "False",
                        "id": "overrepresentation_analysis",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--overrepresentation_analysis",
                            "shellQuote": false,
                            "position": 15
                        },
                        "label": "Enable overrepresented sequence analysis",
                        "doc": "Enable overrepresented sequence analysis."
                    },
                    {
                        "sbg:altPrefix": "-P",
                        "sbg:category": "Overrepresented sequence analysis",
                        "sbg:toolDefaultValue": "20",
                        "id": "overrepresentation_sampling",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--overrepresentation_sampling",
                            "shellQuote": false,
                            "position": 15
                        },
                        "label": "Read sampling for overrepresentation analysis",
                        "doc": "One in (--overrepresentation_sampling) reads will be computed for overrepresentation analysis (1~10000), smaller is slower."
                    },
                    {
                        "sbg:altPrefix": "-R",
                        "sbg:category": "Outputs",
                        "sbg:toolDefaultValue": "\"fastp report\"",
                        "id": "report_title",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--report_title",
                            "shellQuote": false,
                            "position": 16
                        },
                        "label": "Report title (with quotes)",
                        "doc": "Report title (with quotes). It should be quoted with ' or \"."
                    },
                    {
                        "sbg:altPrefix": "-w",
                        "sbg:category": "Execution and Platform",
                        "sbg:toolDefaultValue": "2",
                        "id": "thread",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--thread",
                            "shellQuote": false,
                            "position": 16
                        },
                        "label": "Number of worker threads",
                        "doc": "Number of worker threads."
                    },
                    {
                        "sbg:altPrefix": "-s",
                        "sbg:category": "Outputs",
                        "sbg:toolDefaultValue": "0",
                        "id": "split",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--split",
                            "shellQuote": false,
                            "position": 17
                        },
                        "label": "Number of files to split output FASTQ to",
                        "doc": "Number of files to split output FASTQ to (2-999). If this option is used a sequential number prefix is added to output name (0001.out.fq, 0002.out.fq...). Disabled by default."
                    },
                    {
                        "sbg:altPrefix": "-S",
                        "sbg:category": "Outputs",
                        "sbg:toolDefaultValue": "0",
                        "id": "split_by_lines",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--split_by_lines",
                            "shellQuote": false,
                            "position": 16
                        },
                        "label": "Number of lines in split output FASTQ files",
                        "doc": "Number of lines to split output FASTQ files to (>=1000). If this option is used, a sequential number prefix is added to output names. Disabled by default."
                    },
                    {
                        "sbg:altPrefix": "-d",
                        "sbg:category": "Outputs",
                        "sbg:toolDefaultValue": "4",
                        "id": "split_prefix_digits",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--split_prefix_digits",
                            "shellQuote": false,
                            "position": 16
                        },
                        "label": "Number of digits in output number prefixes",
                        "doc": "Number of digits to use when creating sequential number prefixes to split output FQ file names (1-10). Default is 4, resulting in 0001.xxx filename format."
                    },
                    {
                        "sbg:toolDefaultValue": "1000",
                        "sbg:category": "Platform Options",
                        "id": "mem_per_job",
                        "type": "int?",
                        "label": "Memory per job",
                        "doc": "Memory per job (MB)."
                    },
                    {
                        "sbg:category": "Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "interleaved_out",
                        "type": "boolean?",
                        "label": "Interleaved FASTQ file output",
                        "doc": "Indicates that output is an interleaved FASTQ which contains both reads 1 and 2. Should be set if the input FASTQ file is an interleaved file and the output FASTQ is expected to be interleaved. Disabled by default.",
                        "default": null
                    }
                ],
                "outputs": [
                    {
                        "id": "out_html_report",
                        "doc": "Output HTML report.",
                        "label": "HTML report",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "*.fastp.html",
                            "outputEval": "$(inheritMetadata(self, inputs.in_reads))"
                        },
                        "sbg:fileTypes": "HTML"
                    },
                    {
                        "id": "out_json_report",
                        "doc": "Output JSON report.",
                        "label": "JSON report",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "*.fastp.json",
                            "outputEval": "$(inheritMetadata(self, inputs.in_reads))"
                        },
                        "sbg:fileTypes": "JSON"
                    },
                    {
                        "id": "out_trimmed_reads",
                        "doc": "Output trimmed files.",
                        "label": "Trimmed reads",
                        "type": "File[]?",
                        "outputBinding": {
                            "glob": "${\n  var file = [].concat(inputs.in_reads);\n\n  if (file[0].path.slice(-3) == '.gz'){\n      return '*.fq.gz';\n        \n  }\n  else{\n      return '*.fq';\n  }\n}\n",
                            "outputEval": "${\n    self = inheritMetadata(self, inputs.in_reads);\n\n    if (self) {\n        var arr = [].concat(self);\n        var out_arr = [];\n        for (var i = 0; i < arr.length; i++) {\n            if (arr[i].size != 0) {\n                if (!arr[i].metadata) {\n                    arr[i].metadata = {};\n                }\n                    \n                // paired_end\n                var paired_end = \"\";\n                if (arr[i].basename.includes('_1')) {\n                    paired_end = \"1\";\n                } else if (arr[i].basename.includes('_2')) {\n                    paired_end = \"2\";\n                }\n                arr[i].metadata['paired_end'] = paired_end;\n                    \n            }  \n            out_arr.push(arr[i]);\n        }\n                \n    }\n\n        \n        \n    return out_arr\n             \n   \n}       \n    \n               "
                        },
                        "sbg:fileTypes": "FQ, FQ.GZ"
                    }
                ],
                "doc": "**Fastp** is an ultra-fast FASTQ preprocessor with useful quality control and data-filtering features. It can perform quality control, adapter trimming, quality filtering, per-read quality pruning and many other operations with a single scan of the FASTQ data [1]. \nThe authors claim that **Fastp** is faster than other FASTQ pre-processing tools, such as **Trimmomatic** or **Cutadapt** .\n\n\n*The list of  **all inputs and parameters** with corresponding descriptions can be found at the bottom of the page.*\n\n***Please note that any cloud infrastructure costs resulting from app and pipeline executions, including the use of public apps, are the sole responsibility of you as a user. To avoid excessive costs, please read the app description carefully and set the app parameters and execution settings accordingly***\n\n###Common Use Cases\n\n1. **Fastp** can apply multiple filters: \n\n+ Quality filtering is enabled by default, but you can disable it by `-Q` or `disable_quality_filtering`. Currently it supports filtering by limiting the N base number (`-n`, `--n_base_limit`), and the percentage of unqualified bases. \nTo filter reads by its percentage of unqualified bases, the following options should be provided:\n\n    + **Qualified quality (phred) score** (`-q`, `--qualified_quality_phred`) - Default 15 means phred quality >=Q15 is qualified.\n    + **Unqualified limit [%]** (`-u`, `--unqualified_percent_limit`) - How many percent of bases are allowed to be unqualified (0~100). Default value is 40%.\n\n    You can also filter reads by their average quality score with:\n\n    + **Minimum average read quality score** (`-e`, `--average_qual`) -  If one read's average quality score < avg_qual, then this read/pair is discarded. Default value 0 means no requirement.\n\n+ Length filtering is enabled by default, but you can disable it by `-L` or `--disable_length_filtering`. The minimum length requirement is specified with `-l` or `--length_required`. For some applications like small RNA sequencing, you may want to discard the long reads. You can specify `--length_limit` to discard the reads longer than length_limit. The default value 0 means no limitation.\n\n+ Low complexity filter is disabled by default, and you can enable it by `-y` or `--low_complexity_filter`. The complexity is defined as the percentage of a base that is different from its next base (base[i] != base[i+1]). The threshold for the low complexity filter can be specified by `-Y` or `--complexity_threshold`. Its range should be 0~100, and its default value is 30, which means 30% complexity is required.\n\n2. **Fastp** can apply adapter trimming, enabled by default, but you can disable it by `-A` or `--disable_adapter_trimming`. Adapter sequences can be automatically detected for both PE/SE data.\n\n+ For SE data, the adapters are evaluated by analyzing the tails of first ~1M reads. This evaluation may be inaccurate, and you can specify the **Adapter sequence** by `-a` or `--adapter_sequence` option. If **Adapter sequence** is specified, the auto detection for SE data will be disabled.\n\n+ For PE data, the adapters can be detected by per-read overlap analysis, which seeks for the overlap of each pair of reads. This method is robust and fast, so normally you don't have to input the adapter sequence even if you know it. But you can still specify the **Adapter sequence** for read1 by `--adapter_sequence`, and for read2 by `--adapter_sequence_r2`. If **Fastp** fails to find an overlap (e.g. due to low quality bases), it will use these sequences to trim adapters for read1 and read2 respectively.\n\n+ For PE data, the adapter sequence auto-detection is disabled by default since the adapters can be trimmed by the overlap analysis. However, you can specify **Detect adapter for paired-end data via tail end analysis** (`--detect_adapter_for_pe`) to enable it.\n\n+ For PE data, **Fastp** will run a little slower if you specify the sequence adapters or enable adapter auto-detection, but usually result in a slightly cleaner output, since the overlap analysis may fail due to sequencing errors or adapter dimers.\n\n+ The most widely used adapter is the Illumina TruSeq adapter. If your data is from the TruSeq library, you can add `--adapter_sequence`=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA, `--adapter_sequence_r2`=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT to your command lines, or enable auto detection for PE data by specifying `--detect_adapter_for_pe`.\n\n+ **Fastp** contains some built-in known adapter sequences for better auto-detection. You can also specify `--adapter_fasta` to provide a FASTA file to tell **Fastp** to trim multiple adapters in this FASTA file. The adapter sequence in this file should be at least 6bp long, otherwise it will be skipped. And you can provide whatever you want to trim, rather than regular sequencing adapters (i.e. polyA). **Fastp** first trims the auto-detected adapter or the adapter sequences given by `--adapter_sequence` | `--adapter_sequence_r2`, then trims the adapters given by `--adapter_fasta` one by one. The sequence distribution of trimmed adapters can be found at the **HTML/JSON reports**.\n\n3. **Fastp** supports per read sliding window cutting by evaluating the mean quality scores in the sliding window. From v0.19.6, **Fastp** supports 3 different operations, and you can enable one or all of them:\n\n+ **Cut front** (`-5`, `--cut_front`)-  Move a sliding window from front (5') to tail, drop the bases in the window if their mean quality is below cut_mean_quality, stop otherwise. Default is disabled. The leading N bases are also trimmed. Use **Cut front window size** (`--cut_front_window_size`) to set the window size, and **Cut front mean quality** ( `--cut_front_mean_quality`) to set the mean quality threshold. If the window size is 1, this is similar to the **Trimmomatic** LEADING method.\n\n+ **Cut tail** (`-3`, `--cut_tail`) -  Move a sliding window from tail (3') to front, drop the bases in the window if their mean quality is below cut_mean_quality, stop otherwise. Default is disabled. The trailing N bases are also trimmed. Use **Cut tail window size** (`--cut_tail_window_size`) to set the window size, and **Cut tail mean quality** (`--cut_tail_mean_quality`) to set the mean quality threshold. If the window size is 1, this is similar to the **Trimmomatic** TRAILING method.\n\n+ **Cut right** (`-r`, `--cut_right`) - Move a sliding window from front to tail, if meet one window with mean quality < threshold, drop the bases in the window and the right part, and then stop. Use **Cut right window size** (`--cut_right_window_size`) to set the window size, and **Cut right mean quality** (`--cut_right_mean_quality)` to set the mean quality threshold. This is similar to the **Trimmomatic** SLIDINGWINDOW method\n\nWARNING:  All these three operations will interfere with deduplication for SE data, and `--cut_front` or -`-cut_right` may also interfere with deduplication for PE data. The deduplication algorithms rely on the exact match of coordination regions of the grouped reads/pairs.\n\n\nIf `--cut_right` is enabled, then there is no need to enable `--cut_tail`, since the former is more aggressive. If `--cut_right` is enabled together with `--cut_front`, `--cut_front` will be performed before `--cut_right` to avoid dropping whole reads due to the low quality starting bases.\n\nPlease note that `--cut_front` will interfere with deduplication for both PE/SE data, and `--cut_tail` will interfere with deduplication for SE data, since the deduplication algorithms rely on the exact match of coordination regions of the grouped reads/pairs.\n\nIf you don't set window size and mean quality threshold for these functions respectively, **Fastp** will use the values from `-W`, `--cut_window_size` and `-M`, `--cut_mean_quality`.\n\n4. **Fastp** performs overlap analysis for PE data, which tries to find an overlap of each pair of reads. If a proper overlap is found, it can correct mismatched base pairs in overlapped regions of paired end reads, if one base has high quality while the other one has ultra low quality. If a base is corrected, the quality of its paired base will be assigned to it so that they will share the same quality. This function is not enabled by default, specify **Enable base correction in overlapped regions** ( `-c`, `--correction`) to enable it. This function is based on overlapping detection, which has adjustable parameters `--overlap_len_require` (default 30), `--overlap_diff_limit` (default 5) and `--overlap_diff_limit_percent` (default 20%). Please note that the reads should meet these three conditions simultaneously.\n\n5. **Fastp** supports global trimming, which means trim all reads at the front or the tail. This function is useful since sometimes you want to drop some cycles of a sequencing run. For example, the last cycle of Illumina sequencing usually has low quality, and it can be dropped using the **Number of bases to trim from end of R1 reads** ( `-t 1` , `--trim_tail1=1`) option.\n\n+ For read1 or SE data, the front/tail trimming settings are provided using `-f`, `--trim_front1` and `-t`, `--trim_tail1`.\n\n+ For read2 of PE data, the front/tail trimming settings are provided using `-F`, `--trim_front2` and `-T`, `--trim_tail2`. But if these options are not specified, they will be the same as read1 options, which means `trim_front2 = trim_front1` and `trim_tail2 = trim_tail1`.\n\n+ If you want to trim the reads to maximum length, you can specify `-b`, `--max_len1` for read1, and `-B`, `--max_len2` for read2. If `--max_len1` is specified but `--max_len2` is not, `--max_len2` will be the same as `--max_len1`. For example, if `--max_len1` is specified and read1 is longer than `--max_len1`, **Fastp** will trim read1 at its tail to make it as long as `--max_len1`.\n\nPlease note that the trimming for `--max_len` limitation will be applied at the last step. Here are **Fastp**'s processing steps that may affect the read lengths, in this order:\n\na. UMI preprocessing (`--umi`)\n\nb. Global trimming at front (`--trim_front`)\n\nc. Global trimming at tail (`--trim_tail`)\n\nd. Quality pruning at 5' (`--cut_front`)\n\ne. Quality pruning by sliding window (`--cut_right`)\n\nf. Quality pruning at 3' (`--cut_tail`)\n\ng. Trim polyG (`--trim_poly_g`, enabled by default for NovaSeq/NextSeq data)\n\nh. Trim adapter by overlap analysis (enabled by default for PE data)\n\ni. Trim adapter by adapter sequence (`--adapter_sequence`, `--adapter_sequence_r2`. For PE data, this step is skipped if previous step succeeded)\n\nj. Trim polyX (`--trim_poly_x`)\n\nk. Trim to max length (`--max_len`)\n\n\n6. For Illumina NextSeq/NovaSeq data, polyG can happen in read tails since G means no signal in the Illumina two-color systems. **Fastp** can detect the polyG in read tails and trim them. This feature is enabled for NextSeq/NovaSeq data by default, and you can specify **Force polyG tail trimming** ( `-g`, `--trim_poly_g`) to enable it for any data, or specify **Disable polyG tail trimming** ( `-G`, `--disable_trim_poly_g`) to disable it. NextSeq/NovaSeq data is detected by the machine ID in the FASTQ records. A minimum length can be set with **Minimum length to detect polyG read tail** ( `--poly_g_min_len`) for **Fastp** to detect polyG. This value is 10 by default.\n\n7. PolyX tail trimming is similar to polyG tail trimming, but is disabled by default. Use **Enable polyX trimming in 3' reads** ( `-x`,  `--trim_poly_x`) to enable it. **Minimum length to detect polyX in read tail** ( `--poly_x_min_len` ) can be set with for **Fastp** to detect polyX. This value is 10 by default. When polyG tail trimming and polyX tail trimming are both enabled, **Fastp** will perform polyG trimming first, then perform polyX trimming. This setting is useful for trimming the tails having polyX (i.e. polyA) before polyG. PolyG is usually caused by sequencing artifacts, while polyA can be commonly found from the tails of mRNA-Seq reads.\n\n8. Unique molecular identifier (UMI) is useful for duplication elimination and error correction based on generating consensus of reads originated from the same DNA fragment. It's usually used in deep sequencing applications like ctDNA sequencing. For Illumina platforms, UMIs can commonly be integrated in two different places: index or head of read. You can activate this with the **Enable UMI preprocessing**( `-U`, `--umi`)  option, and specify **UMI location** ( `--umi_loc`)  which can be one of the following:\n\n+ index1 - the first index is used as the UMI. If the data is PE, this UMI will be used for both read1/read2.\n\n+ index2 - the second index is used as the UMI. PE data only, this UMI will be used for both read1/read2.\n\n+ read1 - the head of read1 is used as the UMI. If the data is PE, this UMI will be used for both read1/read2.\n\n+ read2 - the head of read2 is used as the UMI. PE data only, this UMI will be used for both read1/read2.\n\n+ per_index, index1_index2 is used as the UMI for both read1/read2.\n\n+ per_read defines umi1 as the head of read1, and umi2 as the head of read2. umi1_umi2 is used as the UMI for both read1/read2.\n\nIf **UMI location** is specified with read1, read2 or per_read, the length of the UMI should be specified with **Length of UMI in read1/read2** ( `--umi_len`).\n\n**Fastp** will extract the UMIs, and append them to the first part of read names, so the UMIs will also be presented in SAM/BAM records. If the UMI is in the reads, then it will be shifted from the read so that the read will become shorter. If the UMI is in the index, it will be kept.\n\nA prefix can be specified with **UMI prefix** ( `--umi_prefix`). If a prefix is specified, an underline will be used to connect it and the UMI. For example, UMI=AATTCCGG, prefix=UMI, then the final string presented in the name will be `UMI_AATTCCGG`.\n\nIf the **UMI location** is read1/read2/per_read, **Fastp** can skip some bases after the UMI to trim the UMI separator and A/T tailing. Specify **Number of bases to skip following UMI** (`--umi_skip`) to enable the number of bases to skip. By default it is not enabled.\n\n\n9. For parallel processing of FASTQ files (i.e. alignment in parallel), **Fastp** supports splitting the output into multiple files. The splitting can work with two different modes: by limiting file number or by limiting lines of each file. These two modes cannot be enabled together. The file names of these split files will have a sequential number prefix, adding to the original file name specified by `--out1` or `--out2`, and the width of the prefix is controlled by the `-d` or `--split_prefix_digits` option. For example, `--split_prefix_digits=4`, `--out1=out.fq`, `--split=3`, then the output files will be `0001.out.fq,0002.out.fq,0003.out.fq`\n\n+ Splitting by limiting file number - Use **Number of files to split output FASTQ to** ( `-s`,  `--split`) to specify how many files you want to have. **Fastp** evaluates the read number of a FASTQ by reading its first ~1M reads. This evaluation is not accurate so the file sizes of the last several files can be a little different (a bit bigger or smaller). For best performance, it is suggested to specify the file number to be a multiple of the thread number.\n\n+ Splitting by limiting the lines of each file - Use **Number of lines in split output FASTQ files** ( `-S`,  `--split_by_lines`) to limit the lines of each file. The last files may have smaller sizes since usually the input file cannot be perfectly divided. The actual file lines may be a little greater than the value specified by `--split_by_lines` since **Fastp** reads and writes data by blocks (a block = 1000 reads).\n\n10. Overrepresented sequence analysis is disabled by default, you can specify **Enable overrepresented sequence analysis** ( `-p`, `--overrepresentation_analysis`) to enable it. For consideration of speed and memory, **Fastp** only counts sequences with length of 10bp, 20bp, 40bp, 100bp or (cycles - 2 ). By default, **Fastp** uses 1/20 reads for sequence counting, and you can change these settings by specifying the **Read sampling for overrepresentation analysis** ( `-P`,  `--overrepresentation_sampling`) option. For example, if you set 100, only 1/100 reads will be used for counting, and if you set 1, all reads will be used but it will be extremely slow. The default value of 20 is a balance of speed and accuracy. **Fastp** not only gives the counts of overrepresented sequences, but also provides the information on how they distribute over cycles. A figure is provided for each detected overrepresented sequence, from which you can know where this sequence is mostly found.\n\n11. For PE input, **Fastp** supports stitching them by specifying the **Merge overlapping paired-end reads** ( `-m`, `--merge`) option. In this merging mode:\n\n+ `--merged_out` should be given to specify the file to store merged reads. The merged reads are also filtered.\n\n+ `--out1` and `--out2` will be the reads that cannot be merged successfully, but both pass all the filters.\n\n+ `--unpaired1` will be the reads that cannot be merged, `read1` passes filters but `read2` doesn't.\n\n+ `--unpaired2` will be the reads that cannot be merged, `read2` passes filters but `read1` doesn't.\n\n+ `--include_unmerged` can be enabled to make reads of `--out1`, `--out2`, `--unpaired1` and `--unpaired2` redirected to `--merged_out`. So you will get a single output file. This option is disabled by default.\n\n\n`--failed_out` can still be given to store the reads (either merged or unmerged) that failed to pass filters.\n\nIn the output file, a tag like `merged_xxx_yyy` will be added to each read name to indicate how many base pairs are from read1 and from read2, respectively. For example, `@NB551106:9:H5Y5GBGX2:1:22306:18653:13119 1:N:0:GATCAG merged_150_15` means that 150bp are from read1, and 15bp are from read2. **Fastp** prefers the bases in read1 since they usually have higher quality than read2.\n\nSame as the base correction feature, this function is also based on overlapping detection, which has adjustable parameters **Minimum length for detecting overlapped regions** ( `--overlap_len_require`) (default 30), **Maximum number of mismatched bases for detecting PE overlaps** ( `--overlap_diff_limit`) (default 5) and **Maximum % of mismatched bases for detecting PE overlaps** ( `--overlap_diff_limit_percent`) (default 20%). Please note that the reads should meet these three conditions simultaneously.\n\n###Changes Introduced by Seven Bridges\n\n* **Interleaved FASTQ file output** parameter is added. If set to True, there will be one interleaved output file at **Trimmed reads** output port will contain one interleaved output file containing both read 1 and read 2.\n\nInput parameters omitted from this tool:\n* `--stdin` - Omitted\n* `--stdout` - Omitted\n* `--dont_overwrite` - Unnecessary for common use on Seven Bridges platforms.\n* `--cut_by_quality5` -  Deprecated in this tool version\n* `--cut_by_quality3` - Deprecated in this tool version\n* `--cut_by_quality_aggressive` - Deprecated in this tool version\n* `--discard_unmerged` - Deprecated in this tool version\n* `--help` - Omitted\n\n\n###Common Issues and Important Notes\n\n+ If you are working with paired-end reads, you need to specify an adapters for both reads in a pair. This is also valid if you are using adapter fasta file, you need to provide the same file for both ends.\n\n+ Please check if the **Paired-end** metadata field is specified for each file before running **Fastp** with paired-end inputs.\n\n+ Note: The tool installation was done using commit 424900e376a02033a32b623bc5c836897f6b7e5a (https://github.com/OpenGene/fastp/commit/424900e376a02033a32b623bc5c836897f6b7e5a) instead of the official release 0.20.1\n\n###Performance Benchmarking\n\nBenchmarking was performed on c4.2xlarge (8 vCPUs, 15 GB Memory) and c5.4xlarge (16 vCPUs, 32 GB Memory) AWS instances. Trimming clearly benefits from multiple threads. Below is a table describing the runtimes and task costs for a couple of samples with different file sizes.\n\n\n| Input size (GB) | # of threads | Duration | Cost ($) | Instance (AWS) |\n|:---------------:|:------------:|:--------------:|:--------:|:--------------:|\n| 2 x 18.5 | 8 | 22 min | 0.15 | c4.2xlarge |\n|2 x 18.5 | 16 | 14 min | 0.16 | c5.4xlarge |\n| 2 x 39.7 | 8 | 48 min | 0.32 | c4.2xlarge |\n| 2 x 39.7 | 16 | 31 min | 0.35 | c5.4xlarge |\n| 2 x 209.8 | 8 | 4 h 20 min | 1.72 | c4.2xlarge |\n| 2 x 209.8 | 16 | 2 h 29 min | 1.70 | c5.4xlarge |\n\n\n*Cost can be significantly reduced by **spot instance** usage. Visit [the Knowledge Center](https://docs.sevenbridges.com/docs/about-spot-instances) for more details.*          \n\n\n###References\n\n[1] [Fastp documentation](https://github.com/OpenGene/fastp)",
                "label": "Fastp",
                "arguments": [
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 0,
                        "valueFrom": "${\n    //input paths\n    var cmd = '';\n   \n    var file = [].concat(inputs.in_reads);   \n    \n    for (var i=0; i < file.length; i++) {\n        if ((file[i].metadata) && (file[i].metadata['paired_end']) && (file[i].metadata['paired_end'] == '1'))\n        {\n            cmd += '--in1 ' + file[i].path + ' ';\n        }\n        else if ((file[i].metadata) && (file[i].metadata['paired_end']) && (file[i].metadata['paired_end'] == '2'))\n        {\n            cmd += '--in2 ' + file[i].path + ' '\n        }\n        \n        else if (file.length == 1) {\n            \n            cmd += '--in1 ' + file[0].path ;\n        }\n    }\n    \n    return cmd\n    \n}\n"
                    },
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 1000,
                        "valueFrom": "${\n    //output naming\n    var cmd = '';\n    var file = [].concat(inputs.in_reads);\n    var ext = '';\n    if (file[0].path.toLowerCase().endsWith('gz')) {\n        ext = '.fq.gz'\n    } else {\n        ext = '.fq'\n    }\n    \n    \n    var filename = file[0].nameroot;\n    var in_file = file[0].path\n    if (file[0].metadata){\n        if (file[0].metadata['sample_id']){\n            filename = file[0].metadata['sample_id'];\n        }\n    }\n    \n    if (file.length == 1) {\n        if (inputs.interleaved_in) {\n            if (inputs.interleaved_out) {\n                cmd += '--stdout > ' + filename + '.trimmed' + ext;\n            }\n            else {\n                cmd += '--out1' + ' ' + filename + \".pe_1\" + '.trimmed' + ext + ' ' ;\n        \n                cmd += '--out2' + ' ' + filename + \".pe_2\" + '.trimmed' + ext ;\n            }\n        }\n        else {\n            cmd += '--out1' + ' ' + filename + '.trimmed' + ext ;\n        }\n    } else if (file.length == 2) {\n        cmd += '--out1' + ' ' + filename + \".pe_1\" + '.trimmed' + ext + ' ' ;\n        \n        cmd += '--out2' + ' ' + filename + \".pe_2\" + '.trimmed' + ext ;\n\n    }\n    return cmd\n}"
                    },
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 15,
                        "valueFrom": "${\n    //report naming\n    var cmd = '';\n    var file = [].concat(inputs.in_reads);\n   \n    \n    var filename = file[0].nameroot;\n    var in_file = file[0].path\n    if (file[0].metadata){\n        if (file[0].metadata['sample_id']){\n            filename = file[0].metadata['sample_id'];\n        }\n    }\n     \n          \n    \n    \n        \n    cmd += '--html' + ' ' + filename + '.fastp.html'+ ' ' ;\n        \n    cmd += '--json' + ' ' + filename + '.fastp.json';\n        \n    \n    return cmd\n}"
                    }
                ],
                "requirements": [
                    {
                        "class": "ShellCommandRequirement"
                    },
                    {
                        "class": "ResourceRequirement",
                        "ramMin": "${\n    if (inputs.mem_per_job) {\n        return inputs.mem_per_job;\n    } else {\n        return 4000;\n    }\n}",
                        "coresMin": "${\n    if (inputs.thread) {\n        return inputs.thread;\n    } else {\n        return 2;\n    }\n}"
                    },
                    {
                        "class": "DockerRequirement",
                        "dockerPull": "biocontainers/fastp:v0.23.1_cv1"
                    },
                    {
                        "class": "InlineJavascriptRequirement",
                        "expressionLib": [
                            "\nvar setMetadata = function(file, metadata) {\n    if (!('metadata' in file)) {\n        file['metadata'] = {}\n    }\n    for (var key in metadata) {\n        file['metadata'][key] = metadata[key];\n    }\n    return file\n};\n\nvar inheritMetadata = function(o1, o2) {\n    var commonMetadata = {};\n    if (!Array.isArray(o2)) {\n        o2 = [o2]\n    }\n    for (var i = 0; i < o2.length; i++) {\n        var example = o2[i]['metadata'];\n        for (var key in example) {\n            if (i == 0)\n                commonMetadata[key] = example[key];\n            else {\n                if (!(commonMetadata[key] == example[key])) {\n                    delete commonMetadata[key]\n                }\n            }\n        }\n    }\n    if (!Array.isArray(o1)) {\n        o1 = setMetadata(o1, commonMetadata)\n    } else {\n        for (var i = 0; i < o1.length; i++) {\n            o1[i] = setMetadata(o1[i], commonMetadata)\n        }\n    }\n    return o1;\n};"
                        ]
                    }
                ],
                "successCodes": [
                    0
                ],
                "temporaryFailCodes": [
                    1
                ],
                "sbg:projectName": "SBG Public Data",
                "sbg:revisionsInfo": [
                    {
                        "sbg:revision": 0,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1618325866,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 1,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1618326684,
                        "sbg:revisionNotes": "Initial"
                    },
                    {
                        "sbg:revision": 2,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1618326684,
                        "sbg:revisionNotes": "Update: new docker and new report name"
                    },
                    {
                        "sbg:revision": 3,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1618326684,
                        "sbg:revisionNotes": "Update description for 'detect_adapter_for_pe' option"
                    },
                    {
                        "sbg:revision": 4,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1618326684,
                        "sbg:revisionNotes": "set base correction to be boolean"
                    },
                    {
                        "sbg:revision": 5,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1618326684,
                        "sbg:revisionNotes": "Update description of some parameters"
                    },
                    {
                        "sbg:revision": 6,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1618326685,
                        "sbg:revisionNotes": "Update: description"
                    },
                    {
                        "sbg:revision": 7,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1618326685,
                        "sbg:revisionNotes": "Update: Description"
                    },
                    {
                        "sbg:revision": 8,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1618326685,
                        "sbg:revisionNotes": "Update: benchmarking"
                    },
                    {
                        "sbg:revision": 9,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1627391573,
                        "sbg:revisionNotes": "Import revision 33 from Dev project."
                    },
                    {
                        "sbg:revision": 10,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1627391574,
                        "sbg:revisionNotes": "Made change to support output of trimmed files of FQ.GZ type. this change is not made in the Dev project"
                    },
                    {
                        "sbg:revision": 11,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1628158057,
                        "sbg:revisionNotes": "Import revision 34 from Dev project."
                    },
                    {
                        "sbg:revision": 12,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1630508678,
                        "sbg:revisionNotes": "Import revision 37 from Dev project."
                    },
                    {
                        "sbg:revision": 13,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1648468513,
                        "sbg:revisionNotes": "Import revision 38 from Dev project."
                    },
                    {
                        "sbg:revision": 14,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1648468513,
                        "sbg:revisionNotes": "Import revision 39 from Dev project."
                    },
                    {
                        "sbg:revision": 15,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1648468513,
                        "sbg:revisionNotes": "Import revision 40 from Dev project."
                    }
                ],
                "sbg:image_url": null,
                "sbg:toolkit": "Fastp",
                "sbg:toolkitVersion": "0.23.1",
                "sbg:toolAuthor": "Shifu Chen",
                "sbg:license": "MIT",
                "sbg:categories": [
                    "FASTQ Processing",
                    "Quality Control",
                    "Read Trimming",
                    "Filtering",
                    "Utilities"
                ],
                "sbg:links": [
                    {
                        "id": "https://github.com/OpenGene/fastp",
                        "label": "Homepage"
                    },
                    {
                        "id": "https://github.com/OpenGene/fastp",
                        "label": "Source Code"
                    },
                    {
                        "id": "https://github.com/OpenGene/fastp",
                        "label": "Download"
                    },
                    {
                        "id": "https://academic.oup.com/bioinformatics/article/34/17/i884/5093234",
                        "label": "Publication"
                    },
                    {
                        "id": "https://github.com/OpenGene/fastp",
                        "label": "Documentation"
                    }
                ],
                "sbg:expand_workflow": false,
                "sbg:appVersion": [
                    "v1.1"
                ],
                "sbg:id": "biocontainers/fastp:v0.23.1_cv1",
                "sbg:revision": 15,
                "sbg:revisionNotes": "Import revision 40 from Dev project.",
                "sbg:modifiedOn": 1648468513,
                "sbg:modifiedBy": "admin",
                "sbg:createdOn": 1618325866,
                "sbg:createdBy": "admin",
                "sbg:project": "admin/sbg-public-data",
                "sbg:sbgMaintained": false,
                "sbg:validationErrors": [],
                "sbg:contributors": [
                    "admin"
                ],
                "sbg:latestRevision": 15,
                "sbg:publisher": "sbg",
                "sbg:content_hash": "ac77f95aea57df47af9305045105623169239371acf2c5b84db04a51dc2734c7c",
                "sbg:workflowLanguage": "CWL"
            },
            "label": "Fastp",
            "sbg:x": 129.8541717529297,
            "sbg:y": 39.666664123535156
        },
        {
            "id": "bwa_mem_bundle_0_7_17",
            "in": [
                {
                    "id": "reference_index_tar",
                    "source": "reference_index_tar"
                },
                {
                    "id": "input_reads",
                    "source": [
                        "fastp_0_23_1/out_trimmed_reads"
                    ]
                }
            ],
            "out": [
                {
                    "id": "aligned_reads"
                },
                {
                    "id": "dups_metrics"
                }
            ],
            "run": {
                "cwlVersion": "sbg:draft-2",
                "class": "CommandLineTool",
                "$namespaces": {
                    "sbg": "https://sevenbridges.com"
                },
                "id": "admin/sbg-public-data/bwa-mem-bundle-0-7-17/45",
                "label": "BWA MEM Bundle 0.7.17",
                "description": "**BWA-MEM** is an algorithm designed for aligning sequence reads onto a large reference genome. BWA-MEM is implemented as a component of BWA. The algorithm can automatically choose between performing end-to-end and local alignments. BWA-MEM is capable of outputting multiple alignments, and finding chimeric reads. It can be applied to a wide range of read lengths, from 70 bp to several megabases. \n\n## Common Use Cases\nIn order to obtain possibilities for additional fast processing of aligned reads, **Biobambam2 sortmadup** (2.0.87) tool is embedded together into the same package with BWA-MEM (0.7.17).\nIf deduplication of alignments is needed, it can be done by setting the parameter 'Duplication'. Biobambam2 sortmadup will be used internally to perform this action.\n\nBesides the standard BWA-MEM SAM output file, BWA-MEM package has been extended to support additional output options enabled by Biobambam2 sortmadup: BAM file, Coordinate Sorted BAM along with accompanying .bai file, queryname sorted BAM and CRAM. Sorted BAM is the default output of BWA-MEM. Parameter responsible for output type selection is *Output format*. Passing data from BWA-MEM to Biobambam2 sortmadup tool has been done through the linux pipes which saves processing times (up to an hour of the execution time for whole genome sample) of two read and write of aligned reads into the hard drive.\n\n## Common Issues and Important Notes\nFor input reads fastq files of total size less than 10 GB we suggest using the default setting for parameter 'total memory' of 15GB, for larger files we suggest using 58 GB of memory and 32 CPU cores.\n\nIn order to work BWA-MEM Bundle requires fasta reference file accompanied with **BWA Fasta indices** in TAR file.\n\nHuman reference genome version 38 comes with ALT contigs, a collection of diverged alleles present in some humans but not the others. Making effective use of these contigs will help to reduce mapping artifacts, however, to facilitate mapping these ALT contigs to the primary assembly, GRC decided to add to each contig long flanking sequences almost identical to the primary assembly. As a result, a naive mapping against GRCh38+ALT will lead to many mapQ-zero mappings in these flanking regions. Please use post-processing steps to fix these alignments or implement [steps](https://sourceforge.net/p/bio-bwa/mailman/message/32845712/) described by the author of BWA toolkit.\n\nWhen desired output is CRAM file without deduplication of the PCR duplicates, it is necessary to provide FASTA Index file as input.\n\nIf __Read group ID__ parameter is not defined, by default it will  be set to ‘1’. If the tool is scattered within a workflow it will assign the Read Group ID according to the order of the scattered folders. This ensures a unique Read Group ID when when processing multi-read group input data from one sample.",
                "baseCommand": [
                    {
                        "script": "{\n  cmd = \"/bin/bash -c \\\"\"\n  return cmd + \" export REF_CACHE=${PWD} ; \"\n}",
                        "class": "Expression",
                        "engine": "#cwl-js-engine"
                    },
                    {
                        "script": "{\n  reference_file = $job.inputs.reference_index_tar.path.split('/')[$job.inputs.reference_index_tar.path.split('/').length-1]\n  return 'tar -tvf ' +  reference_file + ' 1>&2; tar -xf ' + reference_file + ' ; '\n  \n}",
                        "class": "Expression",
                        "engine": "#cwl-js-engine"
                    },
                    "bwa",
                    "mem"
                ],
                "inputs": [
                    {
                        "sbg:category": "Input files",
                        "sbg:stageInput": "link",
                        "type": [
                            "File"
                        ],
                        "label": "Reference Index TAR",
                        "description": "Reference fasta file with BWA index files packed in TAR.",
                        "sbg:fileTypes": "TAR",
                        "id": "#reference_index_tar"
                    },
                    {
                        "sbg:category": "Input files",
                        "sbg:stageInput": "link",
                        "type": [
                            {
                                "type": "array",
                                "items": "File"
                            }
                        ],
                        "label": "Input reads",
                        "description": "Input sequence reads.",
                        "sbg:fileTypes": "FASTQ, FASTQ.GZ, FQ, FQ.GZ",
                        "id": "#input_reads"
                    },
                    {
                        "sbg:category": "Execution",
                        "sbg:toolDefaultValue": "8",
                        "type": [
                            "null",
                            "int"
                        ],
                        "label": "Threads",
                        "description": "Number of threads for BWA, Samblaster and Sambamba sort process.",
                        "id": "#threads"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "sbg:toolDefaultValue": "19",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-k",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Minimum seed length",
                        "description": "Minimum seed length for BWA MEM.",
                        "id": "#minimum_seed_length"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "sbg:toolDefaultValue": "100",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-d",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Dropoff",
                        "description": "Off-diagonal X-dropoff.",
                        "id": "#dropoff"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "sbg:toolDefaultValue": "1.5",
                        "type": [
                            "null",
                            "float"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-r",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Select seeds",
                        "description": "Look for internal seeds inside a seed longer than {-k} * FLOAT.",
                        "id": "#select_seeds"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "sbg:toolDefaultValue": "20",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-y",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Seed occurrence for the 3rd round",
                        "description": "Seed occurrence for the 3rd round seeding.",
                        "id": "#seed_occurrence_for_the_3rd_round"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "sbg:toolDefaultValue": "500",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-c",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Skip seeds with more than INT occurrences",
                        "description": "Skip seeds with more than INT occurrences.",
                        "id": "#skip_seeds"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "sbg:toolDefaultValue": "0.50",
                        "type": [
                            "null",
                            "float"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-D",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Drop chains fraction",
                        "description": "Drop chains shorter than FLOAT fraction of the longest overlapping chain.",
                        "id": "#drop_chains_fraction"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "sbg:toolDefaultValue": "0",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-W",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Discard chain length",
                        "description": "Discard a chain if seeded bases shorter than INT.",
                        "id": "#discard_chain_length"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "sbg:toolDefaultValue": "50",
                        "type": [
                            "null",
                            "string"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-m",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Mate rescue rounds",
                        "description": "Perform at most INT rounds of mate rescues for each read.",
                        "id": "#mate_rescue_rounds"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-S",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Skip mate rescue",
                        "description": "Skip mate rescue.",
                        "id": "#skip_mate_rescue"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-P",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Skip pairing",
                        "description": "Skip pairing; mate rescue performed unless -S also in use.",
                        "id": "#skip_pairing"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-e",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Discard exact matches",
                        "description": "Discard full-length exact matches.",
                        "id": "#discard_exact_matches"
                    },
                    {
                        "sbg:category": "BWA Scoring options",
                        "sbg:toolDefaultValue": "1",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-A",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Score for a sequence match",
                        "description": "Score for a sequence match, which scales options -TdBOELU unless overridden.",
                        "id": "#score_for_a_sequence_match"
                    },
                    {
                        "sbg:category": "BWA Scoring options",
                        "sbg:toolDefaultValue": "4",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-B",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Mismatch penalty",
                        "description": "Penalty for a mismatch.",
                        "id": "#mismatch_penalty"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-p",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Smart pairing in input FASTQ file",
                        "description": "Smart pairing in input FASTQ file (ignoring in2.fq).",
                        "id": "#smart_pairing_in_input_fastq"
                    },
                    {
                        "sbg:category": "BWA Read Group Options",
                        "sbg:toolDefaultValue": "Constructed from per-attribute parameters or inferred from metadata.",
                        "type": [
                            "null",
                            "string"
                        ],
                        "label": "Read group header",
                        "description": "Read group header line such as '@RG\\tID:foo\\tSM:bar'.  This value takes precedence over per-attribute parameters.",
                        "id": "#read_group_header"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "type": [
                            "null",
                            "string"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-H",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Insert string to output SAM or BAM header",
                        "description": "Insert STR to header if it starts with @; or insert lines in FILE.",
                        "id": "#insert_string_to_header"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-j",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Ignore ALT file",
                        "description": "Treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt file).",
                        "id": "#ignore_alt_file"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "sbg:toolDefaultValue": "3",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "1",
                                    "2",
                                    "3",
                                    "4"
                                ],
                                "name": "verbose_level"
                            }
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-v",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Verbose level",
                        "description": "Verbose level: 1=error, 2=warning, 3=message, 4+=debugging.",
                        "id": "#verbose_level"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "sbg:toolDefaultValue": "30",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-T",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Minimum alignment score for a read to be output in SAM/BAM",
                        "description": "Minimum alignment score for a read to be output in SAM/BAM.",
                        "id": "#minimum_output_score"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-a",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Output alignments",
                        "description": "Output all alignments for SE or unpaired PE.",
                        "id": "#output_alignments"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-C",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Append comment",
                        "description": "Append FASTA/FASTQ comment to SAM output.",
                        "id": "#append_comment"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-V",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Output header",
                        "description": "Output the reference FASTA header in the XR tag.",
                        "id": "#output_header"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-Y",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Use soft clipping",
                        "description": "Use soft clipping for supplementary alignments.",
                        "id": "#use_soft_clipping"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-M",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Mark shorter",
                        "description": "Mark shorter split hits as secondary.",
                        "id": "#mark_shorter"
                    },
                    {
                        "sbg:category": "BWA Scoring options",
                        "sbg:toolDefaultValue": "[6,6]",
                        "type": [
                            "null",
                            {
                                "type": "array",
                                "items": "int"
                            }
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-O",
                            "separate": false,
                            "itemSeparator": ",",
                            "sbg:cmdInclude": true
                        },
                        "label": "Gap open penalties",
                        "description": "Gap open penalties for deletions and insertions. This array can't have more than two values.",
                        "id": "#gap_open_penalties"
                    },
                    {
                        "sbg:category": "BWA Scoring options",
                        "sbg:toolDefaultValue": "[1,1]",
                        "type": [
                            "null",
                            {
                                "type": "array",
                                "items": "int"
                            }
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-E",
                            "separate": false,
                            "itemSeparator": ",",
                            "sbg:cmdInclude": true
                        },
                        "label": "Gap extension",
                        "description": "Gap extension penalty; a gap of size k cost '{-O} + {-E}*k'. This array can't have more than two values.",
                        "id": "#gap_extension_penalties"
                    },
                    {
                        "sbg:category": "BWA Scoring options",
                        "sbg:toolDefaultValue": "[5,5]",
                        "type": [
                            "null",
                            {
                                "type": "array",
                                "items": "int"
                            }
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-L",
                            "separate": false,
                            "itemSeparator": ",",
                            "sbg:cmdInclude": true
                        },
                        "label": "Clipping penalty",
                        "description": "Penalty for 5'- and 3'-end clipping.",
                        "id": "#clipping_penalty"
                    },
                    {
                        "sbg:category": "BWA Scoring options",
                        "sbg:toolDefaultValue": "17",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-U",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Unpaired read penalty",
                        "description": "Penalty for an unpaired read pair.",
                        "id": "#unpaired_read_penalty"
                    },
                    {
                        "sbg:category": "BWA Scoring options",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "pacbio",
                                    "ont2d",
                                    "intractg"
                                ],
                                "name": "read_type"
                            }
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-x",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Sequencing technology-specific settings",
                        "description": "Sequencing technology-specific settings; Setting -x changes multiple parameters unless overriden. pacbio: -k17 -W40 -r10 -A1 -B1 -O1 -E1 -L0  (PacBio reads to ref). ont2d: -k14 -W20 -r10 -A1 -B1 -O1 -E1 -L0  (Oxford Nanopore 2D-reads to ref). intractg: -B9 -O16 -L5  (intra-species contigs to ref).",
                        "id": "#read_type"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "sbg:toolDefaultValue": "[5, 200]",
                        "type": [
                            "null",
                            {
                                "type": "array",
                                "items": "int"
                            }
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-h",
                            "separate": false,
                            "itemSeparator": ",",
                            "sbg:cmdInclude": true
                        },
                        "label": "Output in XA",
                        "description": "If there are <INT hits with score >80% of the max score, output all in XA. This array should have no more than two values.",
                        "id": "#output_in_xa"
                    },
                    {
                        "sbg:category": "BWA Input/output options",
                        "type": [
                            "null",
                            {
                                "type": "array",
                                "items": "float"
                            }
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-I",
                            "separate": false,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Specify distribution parameters",
                        "description": "Specify the mean, standard deviation (10% of the mean if absent), max (4 sigma from the mean if absent) and min of the insert size distribution.FR orientation only. This array can have maximum four values, where first two should be specified as FLOAT and last two as INT.",
                        "id": "#speficy_distribution_parameters"
                    },
                    {
                        "sbg:category": "BWA Algorithm options",
                        "sbg:toolDefaultValue": "100",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-w",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Band width",
                        "description": "Band width for banded alignment.",
                        "id": "#band_width"
                    },
                    {
                        "sbg:category": "BWA Read Group Options",
                        "sbg:toolDefaultValue": "Inferred from metadata",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "454",
                                    "Helicos",
                                    "Illumina",
                                    "Solid",
                                    "IonTorrent"
                                ],
                                "name": "rg_platform"
                            }
                        ],
                        "label": "Platform",
                        "description": "Specify the version of the technology that was used for sequencing, which will be placed in RG line.",
                        "id": "#rg_platform"
                    },
                    {
                        "sbg:category": "BWA Read Group Options",
                        "sbg:toolDefaultValue": "Inferred from metadata",
                        "type": [
                            "null",
                            "string"
                        ],
                        "label": "Sample ID",
                        "description": "Specify the sample ID for RG line - A human readable identifier for a sample or specimen, which could contain some metadata information. A sample or specimen is material taken from a biological entity for testing, diagnosis, propagation, treatment, or research purposes, including but not limited to tissues, body fluids, cells, organs, embryos, body excretory products, etc.",
                        "id": "#rg_sample_id"
                    },
                    {
                        "sbg:category": "BWA Read Group Options",
                        "sbg:toolDefaultValue": "Inferred from metadata",
                        "type": [
                            "null",
                            "string"
                        ],
                        "label": "Library ID",
                        "description": "Specify the identifier for the sequencing library preparation, which will be placed in RG line.",
                        "id": "#rg_library_id"
                    },
                    {
                        "sbg:category": "BWA Read Group Options",
                        "sbg:toolDefaultValue": "Inferred from metadata",
                        "type": [
                            "null",
                            "string"
                        ],
                        "label": "Platform unit ID",
                        "description": "Specify the platform unit (lane/slide) for RG line - An identifier for lanes (Illumina), or for slides (SOLiD) in the case that a library was split and ran over multiple lanes on the flow cell or slides.",
                        "id": "#rg_platform_unit_id"
                    },
                    {
                        "sbg:category": "BWA Read Group Options",
                        "type": [
                            "null",
                            "string"
                        ],
                        "label": "Data submitting center",
                        "description": "Specify the data submitting center for RG line.",
                        "id": "#rg_data_submitting_center"
                    },
                    {
                        "sbg:category": "BWA Read Group Options",
                        "type": [
                            "null",
                            "string"
                        ],
                        "label": "Median fragment length",
                        "description": "Specify the median fragment length for RG line.",
                        "id": "#rg_median_fragment_length"
                    },
                    {
                        "sbg:category": "Execution",
                        "sbg:toolDefaultValue": "Coordinate Sorted BAM",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "SAM",
                                    "BAM",
                                    "CRAM",
                                    "Queryname Sorted BAM",
                                    "Queryname Sorted SAM",
                                    "Coordinate Sorted BAM"
                                ],
                                "name": "output_format"
                            }
                        ],
                        "label": "Output format",
                        "description": "Cordinate sort is default output.",
                        "id": "#output_format"
                    },
                    {
                        "sbg:category": "Execution",
                        "type": [
                            "null",
                            "int"
                        ],
                        "label": "Memory for BAM sorting",
                        "description": "Amount of RAM [Gb] to give to the sorting algorithm (if not provided will be set to one third of the total memory).",
                        "id": "#sort_memory"
                    },
                    {
                        "sbg:category": "Biobambam2 parameters",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "None",
                                    "MarkDuplicates",
                                    "RemoveDuplicates"
                                ],
                                "name": "deduplication"
                            }
                        ],
                        "label": "PCR duplicate detection",
                        "description": "Use Biobambam2 for finding duplicates on sequence reads.",
                        "id": "#deduplication"
                    },
                    {
                        "sbg:category": "Execution",
                        "sbg:stageInput": null,
                        "sbg:toolDefaultValue": "15",
                        "type": [
                            "null",
                            "int"
                        ],
                        "label": "Total memory",
                        "description": "Total memory to be used by the tool in GB. It's sum of BWA, Sambamba Sort and Samblaster. For fastq files of total size less than 10GB, we suggest using the default setting of 15GB, for larger files we suggest using 58GB of memory (and 32CPU cores).",
                        "id": "#total_memory"
                    },
                    {
                        "sbg:category": "Execution",
                        "sbg:stageInput": null,
                        "sbg:toolDefaultValue": "False",
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "label": "Filter out secondary alignments",
                        "description": "Filter out secondary alignments. Sambamba view tool will be used to perform this internally.",
                        "id": "#filter_out_secondary_alignments"
                    },
                    {
                        "sbg:category": "Configuration",
                        "type": [
                            "null",
                            "string"
                        ],
                        "label": "Output SAM/BAM file name",
                        "description": "Name of the output BAM file.",
                        "id": "#output_name"
                    },
                    {
                        "sbg:category": "Configuration",
                        "sbg:stageInput": null,
                        "sbg:toolDefaultValue": "1",
                        "type": [
                            "null",
                            "int"
                        ],
                        "label": "Reserved number of threads on the instance",
                        "description": "Reserved number of threads on the instance used by scheduler.",
                        "id": "#reserved_threads"
                    },
                    {
                        "sbg:category": "Configuration",
                        "sbg:toolDefaultValue": "1",
                        "type": [
                            "null",
                            "string"
                        ],
                        "label": "Read group ID",
                        "description": "Read group ID",
                        "id": "#rg_id"
                    },
                    {
                        "sbg:category": "Execution",
                        "sbg:stageInput": null,
                        "sbg:toolDefaultValue": "False",
                        "type": [
                            "null",
                            "int"
                        ],
                        "label": "Optimize threads for HG38",
                        "description": "Lower the number of threads if HG38 reference genome is used.",
                        "id": "#wgs_hg38_mode_threads"
                    },
                    {
                        "sbg:stageInput": null,
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-5",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Split alignment smallest coordinate as primary",
                        "description": "for split alignment, take the alignment with the smallest coordinate as primary.",
                        "id": "#split_alignment_primary"
                    },
                    {
                        "sbg:stageInput": null,
                        "type": [
                            "null",
                            "boolean"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-q",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "Don't modify mapQ of supplementary alignments",
                        "description": "Don't modify mapQ of supplementary alignments",
                        "id": "#mapQ_of_suplementary"
                    },
                    {
                        "sbg:stageInput": null,
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "-K",
                            "separate": true,
                            "itemSeparator": "null",
                            "sbg:cmdInclude": true
                        },
                        "label": "process INT input bases in each batch (for reproducibility)",
                        "description": "process INT input bases in each batch regardless of nThreads (for reproducibility)",
                        "id": "#num_input_bases_in_each_batch"
                    },
                    {
                        "sbg:stageInput": "copy",
                        "type": [
                            "null",
                            "File"
                        ],
                        "inputBinding": {
                            "position": 4,
                            "separate": true,
                            "itemSeparator": "null",
                            "valueFrom": {
                                "class": "Expression",
                                "engine": "#cwl-js-engine",
                                "script": "{\n    return \"\";\n}"
                            }
                        },
                        "label": "Fasta Index file for CRAM output",
                        "description": "Fasta index file is required for CRAM output when no PCR Deduplication is selected.",
                        "sbg:fileTypes": "FAI",
                        "id": "#fasta_index"
                    }
                ],
                "outputs": [
                    {
                        "type": [
                            "null",
                            "File"
                        ],
                        "label": "Aligned SAM/BAM",
                        "description": "Aligned reads.",
                        "sbg:fileTypes": "SAM, BAM, CRAM",
                        "outputBinding": {
                            "glob": "{*.sam,*.bam,*.cram}",
                            "sbg:metadata": {
                                "reference_genome": {
                                    "script": "{\n  reference_file = $job.inputs.reference_index_tar.path.split('/')[$job.inputs.reference_index_tar.path.split('/').length-1]\n  name = reference_file.slice(0, -4) // cut .tar extension \n  \n  name_list = name.split('.')\n  ext = name_list[name_list.length-1]\n\n  if (ext == 'gz' || ext == 'GZ'){\n    a = name_list.pop() // strip fasta.gz\n    a = name_list.pop()\n  } else\n    a = name_list.pop() //strip only fasta/fa\n  \n  return name_list.join('.')\n  \n}",
                                    "class": "Expression",
                                    "engine": "#cwl-js-engine"
                                }
                            },
                            "sbg:inheritMetadataFrom": "#input_reads",
                            "secondaryFiles": [
                                ".bai",
                                "^.bai",
                                ".crai",
                                "^.crai"
                            ]
                        },
                        "id": "#aligned_reads"
                    },
                    {
                        "type": [
                            "null",
                            "File"
                        ],
                        "label": "Sormadup metrics",
                        "description": "Metrics file for biobambam mark duplicates",
                        "sbg:fileTypes": "LOG",
                        "outputBinding": {
                            "glob": "*.sormadup_metrics.log"
                        },
                        "id": "#dups_metrics"
                    }
                ],
                "requirements": [
                    {
                        "class": "ExpressionEngineRequirement",
                        "id": "#cwl-js-engine",
                        "requirements": [
                            {
                                "class": "DockerRequirement",
                                "dockerPull": "rabix/js-engine"
                            }
                        ]
                    }
                ],
                "hints": [
                    {
                        "class": "sbg:CPURequirement",
                        "value": {
                            "script": "{  \n  // Calculate suggested number of CPUs depending of the input reads size\n  if ($job.inputs.input_reads.constructor == Array){\n    if ($job.inputs.input_reads[1]){\n      reads_size = $job.inputs.input_reads[0].size + $job.inputs.input_reads[1].size\n    } else{\n      reads_size = $job.inputs.input_reads[0].size\n    }\n  }\n  else{\n    reads_size = $job.inputs.input_reads.size\n  }\n  if(!reads_size) { reads_size = 0 }\n\n\n  GB_1 = 1024*1024*1024\n  if(reads_size < GB_1){ suggested_cpus = 1 }\n  else if(reads_size < 10 * GB_1){ suggested_cpus = 8 }\n  else { suggested_cpus = 31 }\n  \n  if($job.inputs.reserved_threads){ return $job.inputs.reserved_threads }\n  else if($job.inputs.threads){ return $job.inputs.threads } \n  else if($job.inputs.sambamba_threads) { return $job.inputs.sambamba_threads }\n  else{    return suggested_cpus  }\n}",
                            "class": "Expression",
                            "engine": "#cwl-js-engine"
                        }
                    },
                    {
                        "class": "sbg:MemRequirement",
                        "value": {
                            "script": "{  \n\n  // Calculate suggested number of CPUs depending of the input reads size\n  if ($job.inputs.input_reads.constructor == Array){\n    if ($job.inputs.input_reads[1]){\n      reads_size = $job.inputs.input_reads[0].size + $job.inputs.input_reads[1].size\n    } else{\n      reads_size = $job.inputs.input_reads[0].size\n    }\n  }\n  else{\n    reads_size = $job.inputs.input_reads.size\n  }\n  if(!reads_size) { reads_size = 0 }\n \n  GB_1 = 1024*1024*1024\n  if(reads_size < GB_1){ suggested_memory = 4 }\n  else if(reads_size < 10 * GB_1){ suggested_memory = 15 }\n  else { suggested_memory = 58 }\n  \n  if($job.inputs.total_memory){  \t\n    return  $job.inputs.total_memory* 1024  \n  } \n  else if($job.inputs.sort_memory){\n    return  $job.inputs.sort_memory* 1024\n  }\n  else{  \t\n    return suggested_memory * 1024  \n  }\n}",
                            "class": "Expression",
                            "engine": "#cwl-js-engine"
                        }
                    },
                    {
                        "class": "DockerRequirement",
                        "dockerPull": "images.sbgenomics.com/vladimirk/bwa_biobambam2:0.7.17"
                    }
                ],
                "arguments": [
                    {
                        "position": 112,
                        "prefix": "",
                        "separate": false,
                        "itemSeparator": "null",
                        "valueFrom": {
                            "class": "Expression",
                            "engine": "#cwl-js-engine",
                            "script": "{\n  ///////////////////////////////////////////\n ///  BIOBAMBAM BAMSORMADUP   //////////////////////\n///////////////////////////////////////////\n  \nfunction common_substring(a,b) {\n  var i = 0;\n  while(a[i] === b[i] && i < a.length)\n  {\n    i = i + 1;\n  }\n\n  return a.slice(0, i);\n}\n\n   // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_1 = $job.inputs.input_reads[0][0] // scatter mode\n    input_2 = $job.inputs.input_reads[0][1]\n  } else if($job.inputs.input_reads instanceof Array){\n    input_1 = $job.inputs.input_reads[0]\n    input_2 = $job.inputs.input_reads[1]\n  }else {\n    input_1 = [].concat($job.inputs.input_reads)[0]\n    input_2 = input_1\n  }\n  full_name = input_1.path.split('/')[input_1.path.split('/').length-1] \n  \n  if($job.inputs.output_name){name = $job.inputs.output_name }\n  else if ($job.inputs.input_reads.length == 1){\n    name = full_name\n    if(name.slice(-3, name.length) === '.gz' || name.slice(-3, name.length) === '.GZ')\n      name = name.slice(0, -3)   \n    if(name.slice(-3, name.length) === '.fq' || name.slice(-3, name.length) === '.FQ')\n      name = name.slice(0, -3)\n    if(name.slice(-6, name.length) === '.fastq' || name.slice(-6, name.length) === '.FASTQ')\n      name = name.slice(0, -6)\n       \n  }else{\n    full_name2 = input_2.path.split('/')[input_2.path.split('/').length-1] \n    name = common_substring(full_name, full_name2)\n    \n    if(name.slice(-1, name.length) === '_' || name.slice(-1, name.length) === '.')\n      name = name.slice(0, -1)\n    if(name.slice(-2, name.length) === 'p_' || name.slice(-1, name.length) === 'p.')\n      name = name.slice(0, -2)\n    if(name.slice(-2, name.length) === 'P_' || name.slice(-1, name.length) === 'P.')\n      name = name.slice(0, -2)\n    if(name.slice(-3, name.length) === '_p_' || name.slice(-3, name.length) === '.p.')\n      name = name.slice(0, -3)\n    if(name.slice(-3, name.length) === '_pe' || name.slice(-3, name.length) === '.pe')\n      name = name.slice(0, -3)\n  }\n\n  //////////////////////////\n  // Set sort memory size\n  \n  reads_size = 0 // Not used because of situations when size does not exist!\n  GB_1 = 1024*1024*1024\n  if(reads_size < GB_1){ \n    suggested_memory = 4\n    suggested_cpus = 1\n  }\n  else if(reads_size < 10 * GB_1){ \n    suggested_memory = 15\n    suggested_cpus = 8\n  }\n  else { \n    suggested_memory = 58 \n    suggested_cpus = 31\n  }\n  \n  \n  if(!$job.inputs.total_memory){ total_memory = suggested_memory }\n  else{ total_memory = $job.inputs.total_memory }\n\n  // TODO:Rough estimation, should be fine-tuned!\n  if(total_memory > 16){ sorter_memory = parseInt(total_memory / 3) }\n  else{ sorter_memory = 5 }\n          \n  if ($job.inputs.sort_memory){\n    sorter_memory_string = $job.inputs.sort_memory +'GiB'\n  }\n  else sorter_memory_string = sorter_memory + 'GiB' \n  \n  // Read number of threads if defined\n  if ($job.inputs.threads){\n    threads = $job.inputs.threads\n  }\n  else if ($job.inputs.wgs_hg38_mode_threads){\n    MAX_THREADS = 36\n    ref_name_arr = $job.inputs.reference_index_tar.path.split('/')\n    ref_name = ref_name_arr[ref_name_arr.length - 1]\n    if (ref_name.search('38') >= 0){threads = $job.inputs.wgs_hg38_mode_threads}\n    else {threads = MAX_THREADS}\n  }\n  else { threads = 8 }\n  \n  \n  \nif ($job.inputs.deduplication == \"MarkDuplicates\") {\n    tool = 'bamsormadup'\n    dedup = ' markduplicates=1'\n} else {\n    if ($job.inputs.output_format == 'CRAM') {\n        tool = 'bamsort index=0'\n    } else {\n        tool = 'bamsort index=1'\n    }\n    if ($job.inputs.deduplication == \"RemoveDuplicates\") {\n        dedup = ' rmdup=1'\n    } else {\n        dedup = ''\n    }\n}\nsort_path = tool + dedup\n  \n  indexfilename = ' '\n  // Coordinate Sorted BAM is default\n  if ($job.inputs.output_format == 'CRAM'){\n    out_format = ' outputformat=cram SO=coordinate'\n    ref_name_arr = $job.inputs.reference_index_tar.path.split('/')\n    ref_name = ref_name_arr[ref_name_arr.length - 1].split('.tar')[0]\n    out_format += ' reference=' + ref_name\n    if (sort_path != 'bamsort index=0') {\n            indexfilename = ' indexfilename=' + name + '.cram.crai'\n        }\n    extension = '.cram'    \n  }else if($job.inputs.output_format == 'SAM'){\n    out_format = ' outputformat=sam SO=coordinate'\n    extension = '.sam'    \n  }else if ($job.inputs.output_format == 'Queryname Sorted BAM'){\n    out_format = ' outputformat=bam SO=queryname'\n    extension = '.bam'\n  }else if ($job.inputs.output_format == 'Queryname Sorted SAM'){\n    out_format = ' outputformat=sam SO=queryname'\n    extension = '.sam'    \n  }else {\n    out_format = ' outputformat=bam SO=coordinate'\n    indexfilename = ' indexfilename=' + name + '.bam.bai'\n    extension = '.bam'\n  }\n    cmd = \" | \" + sort_path + \" threads=\" + threads + \" level=1 tmplevel=-1 inputformat=sam\" \n    cmd += out_format\n    cmd += indexfilename\n    // capture metrics file\n    cmd += \" M=\" + name + \".sormadup_metrics.log\"\n    \n    if($job.inputs.output_format == 'SAM'){\n        cmd = ''\n    }\n    return cmd + ' > ' + name + extension\n\n}\n  \n"
                        }
                    },
                    {
                        "position": 1,
                        "prefix": "",
                        "separate": true,
                        "valueFrom": {
                            "class": "Expression",
                            "engine": "#cwl-js-engine",
                            "script": "{\n  \n  if($job.inputs.read_group_header){\n  \treturn '-R ' + $job.inputs.read_group_header\n  }\n    \n  function add_param(key, val){\n    if(!val){\n      return\n\t}\n    param_list.push(key + ':' + val)\n  }\n\n  param_list = []\n\n  // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_1 = $job.inputs.input_reads[0][0] // scatter mode\n  } else if($job.inputs.input_reads instanceof Array){\n    input_1 = $job.inputs.input_reads[0]\n  }else {\n    input_1 = [].concat($job.inputs.input_reads)[0]\n  }\n  \n  //Read metadata for input reads\n  read_metadata = input_1.metadata\n  if(!read_metadata) read_metadata = []\n  \n  // Used for scatter mode\n  var folder = input_1.path.split('/').slice(-2,-1).toString();\n  var suffix = \"_s\"\n \n  if($job.inputs.rg_id){\n    add_param('ID', $job.inputs.rg_id)\n  } else if (folder.indexOf(suffix, folder.length - suffix.length) !== -1) { // scatter mode\n        var rg = folder.split(\"_\").slice(-2)[0]\n        if (parseInt(rg)) add_param('ID', rg)\n        else add_param('ID', 1)\n    }\n  else {\n    add_param('ID', '1')\n  } \n   \n  \n  if($job.inputs.rg_data_submitting_center){\n  \tadd_param('CN', $job.inputs.rg_data_submitting_center)\n  }\n  else if('data_submitting_center' in  read_metadata){\n  \tadd_param('CN', read_metadata.data_submitting_center)\n  }\n  \n  if($job.inputs.rg_library_id){\n  \tadd_param('LB', $job.inputs.rg_library_id)\n  }\n  else if('library_id' in read_metadata){\n  \tadd_param('LB', read_metadata.library_id)\n  }\n  \n  if($job.inputs.rg_median_fragment_length){\n  \tadd_param('PI', $job.inputs.rg_median_fragment_length)\n  }\n\n  \n  if($job.inputs.rg_platform){\n  \tadd_param('PL', $job.inputs.rg_platform)\n  }\n  else if('platform' in read_metadata){\n    if(read_metadata.platform == 'HiSeq X Ten'){\n      rg_platform = 'Illumina'\n    }\n    else{\n      rg_platform = read_metadata.platform\n    }\n  \tadd_param('PL', rg_platform)\n  }\n  \n  if($job.inputs.rg_platform_unit_id){\n  \tadd_param('PU', $job.inputs.rg_platform_unit_id)\n  }\n  else if('platform_unit_id' in read_metadata){\n  \tadd_param('PU', read_metadata.platform_unit_id)\n  }\n  \n  if($job.inputs.rg_sample_id){\n  \tadd_param('SM', $job.inputs.rg_sample_id)\n  }\n  else if('sample_id' in  read_metadata){\n  \tadd_param('SM', read_metadata.sample_id)\n  }\n    \n  return \"-R '@RG\\\\t\" + param_list.join('\\\\t') + \"'\"\n  \n}"
                        }
                    },
                    {
                        "position": 101,
                        "separate": true,
                        "itemSeparator": "null",
                        "valueFrom": {
                            "script": "{\n  /////// Set input reads in the correct order depending of the paired end from metadata\n    \n     // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_reads = $job.inputs.input_reads[0] // scatter mode\n  } else {\n    input_reads = $job.inputs.input_reads = [].concat($job.inputs.input_reads)\n  }\n  \n  \n  //Read metadata for input reads\n  read_metadata = input_reads[0].metadata\n  if(!read_metadata) read_metadata = []\n  \n  order = 0 // Consider this as normal order given at input: pe1 pe2\n  \n  // Check if paired end 1 corresponds to the first given read\n  if(read_metadata == []){ order = 0 }\n  else if('paired_end' in  read_metadata){ \n    pe1 = read_metadata.paired_end\n    if(pe1 != 1) order = 1 // change order\n  }\n\n  // Return reads in the correct order\n  if (input_reads.length == 1){\n    return input_reads[0].path // Only one read present\n  }\n  else if (input_reads.length == 2){\n    if (order == 0) return input_reads[0].path + ' ' + input_reads[1].path\n    else return input_reads[1].path + ' ' + input_reads[0].path\n  }\n\n}",
                            "class": "Expression",
                            "engine": "#cwl-js-engine"
                        }
                    },
                    {
                        "position": 2,
                        "prefix": "-t",
                        "separate": true,
                        "itemSeparator": "null",
                        "valueFrom": {
                            "script": "{\n  MAX_THREADS = 36\n  suggested_threads = 8\n  \n  if($job.inputs.threads){ threads = $job.inputs.threads  }\n  else if ($job.inputs.wgs_hg38_mode_threads){\n    ref_name_arr = $job.inputs.reference_index_tar.path.split('/')\n    ref_name = ref_name_arr[ref_name_arr.length - 1]\n    if (ref_name.search('38') >= 0){threads = $job.inputs.wgs_hg38_mode_threads}\n    else {threads = MAX_THREADS}\n  }\n  else{ threads = suggested_threads  }\n    \n  return threads\n}",
                            "class": "Expression",
                            "engine": "#cwl-js-engine"
                        }
                    },
                    {
                        "position": 10,
                        "separate": true,
                        "itemSeparator": "null",
                        "valueFrom": {
                            "script": "{\n  name = ''\n  metadata = [].concat($job.inputs.reference_index_tar)[0].metadata\n  \n  if (metadata && metadata.reference_genome) {\n \tname = metadata.reference_genome\n  }\n  else {\n\treference_file = $job.inputs.reference_index_tar.path.split('/')[$job.inputs.reference_index_tar.path.split('/').length-1]\n  \tname = reference_file.slice(0, -4) // cut .tar extension \n  }\n    \n  return name \t\n}",
                            "class": "Expression",
                            "engine": "#cwl-js-engine"
                        }
                    },
                    {
                        "position": 10000,
                        "separate": true,
                        "itemSeparator": "null",
                        "valueFrom": {
                            "script": "{\n  cmd = \";declare -i pipe_statuses=(\\\\${PIPESTATUS[*]});len=\\\\${#pipe_statuses[@]};declare -i tot=0;echo \\\\${pipe_statuses[*]};for (( i=0; i<\\\\${len}; i++ ));do if [ \\\\${pipe_statuses[\\\\$i]} -ne 0 ];then tot=\\\\${pipe_statuses[\\\\$i]}; fi;done;if [ \\\\$tot -ne 0 ]; then >&2 echo Error in piping. Pipe statuses: \\\\${pipe_statuses[*]};fi; if [ \\\\$tot -ne 0 ]; then false;fi\\\"\"\n  return cmd\n}",
                            "class": "Expression",
                            "engine": "#cwl-js-engine"
                        }
                    }
                ],
                "sbg:toolAuthor": "Heng Li",
                "sbg:toolkit": "BWA",
                "sbg:license": "BWA: GNU Affero General Public License v3.0, MIT License. Sambamba: GNU GENERAL PUBLIC LICENSE. Samblaster: The MIT License (MIT)",
                "sbg:categories": [
                    "Alignment",
                    "FASTQ Processing"
                ],
                "sbg:projectName": "SBG Public Data",
                "sbg:toolkitVersion": "0.7.17",
                "sbg:image_url": null,
                "sbg:cmdPreview": "/bin/bash -c \" export REF_CACHE=${PWD} ;  tar -tvf reference.HG38.fasta.gz.tar 1>&2; tar -xf reference.HG38.fasta.gz.tar ;  bwa mem  -R '@RG\\tID:1\\tPL:Illumina\\tSM:dnk_sample' -t 10  reference.HG38.fasta.gz  /path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_2.gz /path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_1.gz  | bamsormadup threads=10 level=1 tmplevel=-1 inputformat=sam outputformat=cram SO=coordinate reference=reference.HG38.fasta.gz indexfilename=LP6005524-DNA_C01_lane_7.sorted.converted.filtered.cram.crai M=LP6005524-DNA_C01_lane_7.sorted.converted.filtered.sormadup_metrics.log > LP6005524-DNA_C01_lane_7.sorted.converted.filtered.cram  ;declare -i pipe_statuses=(\\${PIPESTATUS[*]});len=\\${#pipe_statuses[@]};declare -i tot=0;echo \\${pipe_statuses[*]};for (( i=0; i<\\${len}; i++ ));do if [ \\${pipe_statuses[\\$i]} -ne 0 ];then tot=\\${pipe_statuses[\\$i]}; fi;done;if [ \\$tot -ne 0 ]; then >&2 echo Error in piping. Pipe statuses: \\${pipe_statuses[*]};fi; if [ \\$tot -ne 0 ]; then false;fi\"",
                "sbg:revisionsInfo": [
                    {
                        "sbg:revision": 0,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "Copy of vladimirk/bwa-mem-bundle-0-7-13-demo/bwa-mem-bundle-0-7-13/46"
                    },
                    {
                        "sbg:revision": 1,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "init"
                    },
                    {
                        "sbg:revision": 2,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "added biobambam2 sort"
                    },
                    {
                        "sbg:revision": 3,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "dedup added"
                    },
                    {
                        "sbg:revision": 4,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "boolean inputs fixed"
                    },
                    {
                        "sbg:revision": 5,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "output written with >"
                    },
                    {
                        "sbg:revision": 6,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "sambamba and samblaster"
                    },
                    {
                        "sbg:revision": 7,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "samblaster path corrected"
                    },
                    {
                        "sbg:revision": 8,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "Added ALT Contig reference"
                    },
                    {
                        "sbg:revision": 9,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "docs"
                    },
                    {
                        "sbg:revision": 10,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "num_bases_reproducibility"
                    },
                    {
                        "sbg:revision": 11,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1532539861,
                        "sbg:revisionNotes": "Do_not_use_alt_38 parameter removed due to redundancy"
                    },
                    {
                        "sbg:revision": 12,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711358,
                        "sbg:revisionNotes": "Added new @RG options."
                    },
                    {
                        "sbg:revision": 13,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711359,
                        "sbg:revisionNotes": "added bamsormadup"
                    },
                    {
                        "sbg:revision": 14,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711359,
                        "sbg:revisionNotes": "add 'inputformat=sam'"
                    },
                    {
                        "sbg:revision": 15,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711359,
                        "sbg:revisionNotes": "add 'cram output support and capture reference'"
                    },
                    {
                        "sbg:revision": 16,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711359,
                        "sbg:revisionNotes": "capture output with + ' > ' + name + extension"
                    },
                    {
                        "sbg:revision": 17,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711359,
                        "sbg:revisionNotes": "capturing cram output and dups metrics file"
                    },
                    {
                        "sbg:revision": 18,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711359,
                        "sbg:revisionNotes": "add cram selection as an output format"
                    },
                    {
                        "sbg:revision": 19,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711359,
                        "sbg:revisionNotes": "fix output_format options"
                    },
                    {
                        "sbg:revision": 20,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "lower case outputformat=cram"
                    },
                    {
                        "sbg:revision": 21,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "fix typo"
                    },
                    {
                        "sbg:revision": 22,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "tar -tv"
                    },
                    {
                        "sbg:revision": 23,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "see tar contents"
                    },
                    {
                        "sbg:revision": 24,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "1>&2"
                    },
                    {
                        "sbg:revision": 25,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "typo"
                    },
                    {
                        "sbg:revision": 26,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "add export REF_CACHE=$CWD"
                    },
                    {
                        "sbg:revision": 27,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "export REF_CACHE=$CWD ;"
                    },
                    {
                        "sbg:revision": 28,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "REF_CACHE=$PWD"
                    },
                    {
                        "sbg:revision": 29,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "set REF_CACHE"
                    },
                    {
                        "sbg:revision": 30,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711360,
                        "sbg:revisionNotes": "link to reference_tarball"
                    },
                    {
                        "sbg:revision": 31,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711361,
                        "sbg:revisionNotes": ".bam.bai instead only .bai"
                    },
                    {
                        "sbg:revision": 32,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1553711361,
                        "sbg:revisionNotes": "_R multi lane"
                    },
                    {
                        "sbg:revision": 33,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1554195125,
                        "sbg:revisionNotes": "label version to 0.7.17"
                    },
                    {
                        "sbg:revision": 34,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1556185547,
                        "sbg:revisionNotes": "Coordinate Sorted BAM enum label"
                    },
                    {
                        "sbg:revision": 35,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1556185547,
                        "sbg:revisionNotes": "description. Threads mapped to bamsortmadup"
                    },
                    {
                        "sbg:revision": 36,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1556185548,
                        "sbg:revisionNotes": "-q -5 boolean fix!"
                    },
                    {
                        "sbg:revision": 37,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1558705095,
                        "sbg:revisionNotes": "bamsort bamsormadup"
                    },
                    {
                        "sbg:revision": 38,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1558705097,
                        "sbg:revisionNotes": "description for deduplication"
                    },
                    {
                        "sbg:revision": 39,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1558705097,
                        "sbg:revisionNotes": "bamsort index=1"
                    },
                    {
                        "sbg:revision": 40,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1593179089,
                        "sbg:revisionNotes": "biobambam2 off if SAM is output"
                    },
                    {
                        "sbg:revision": 41,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1593179091,
                        "sbg:revisionNotes": "Bug fix for CRAM output with no PCR deduplication"
                    },
                    {
                        "sbg:revision": 42,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1593179091,
                        "sbg:revisionNotes": "Bug fix for CRAM output with no PCR deduplication"
                    },
                    {
                        "sbg:revision": 43,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1593179091,
                        "sbg:revisionNotes": "Coordinate SOrted BAM added to enum list"
                    },
                    {
                        "sbg:revision": 44,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1593179091,
                        "sbg:revisionNotes": "Updated JS to assign a unique Read group ID when the tool is scattered"
                    },
                    {
                        "sbg:revision": 45,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1649159217,
                        "sbg:revisionNotes": "update categories"
                    }
                ],
                "sbg:job": {
                    "allocatedResources": {
                        "cpu": 1,
                        "mem": 4096
                    },
                    "inputs": {
                        "read_group_header": "",
                        "band_width": null,
                        "rg_sample_id": "",
                        "mark_shorter": false,
                        "rg_platform": null,
                        "rg_data_submitting_center": "",
                        "sort_memory": null,
                        "wgs_hg38_mode_threads": 10,
                        "output_format": "CRAM",
                        "threads": null,
                        "total_memory": null,
                        "rg_platform_unit_id": "",
                        "rg_id": "",
                        "output_name": "",
                        "split_alignment_primary": false,
                        "rg_library_id": "",
                        "rg_median_fragment_length": "",
                        "reserved_threads": null,
                        "skip_seeds": null,
                        "reference_index_tar": {
                            "size": 0,
                            "class": "File",
                            "path": "/path/to/reference.HG38.fasta.gz.tar",
                            "secondaryFiles": [
                                {
                                    "path": ".amb"
                                },
                                {
                                    "path": ".ann"
                                },
                                {
                                    "path": ".bwt"
                                },
                                {
                                    "path": ".pac"
                                },
                                {
                                    "path": ".sa"
                                }
                            ]
                        },
                        "filter_out_secondary_alignments": false,
                        "num_input_bases_in_each_batch": null,
                        "mapQ_of_suplementary": false,
                        "input_reads": [
                            {
                                "size": 30000000000,
                                "class": "File",
                                "path": "/path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_1.gz",
                                "secondaryFiles": [],
                                "metadata": {
                                    "paired_end": "2",
                                    "platform": "HiSeq X Ten",
                                    "sample_id": "dnk_sample"
                                }
                            },
                            {
                                "path": "/path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_2.gz"
                            }
                        ],
                        "deduplication": "RemoveDuplicates"
                    }
                },
                "sbg:links": [
                    {
                        "id": "http://bio-bwa.sourceforge.net/",
                        "label": "Homepage"
                    },
                    {
                        "id": "https://github.com/lh3/bwa",
                        "label": "Source code"
                    },
                    {
                        "id": "http://bio-bwa.sourceforge.net/bwa.shtml",
                        "label": "Wiki"
                    },
                    {
                        "id": "http://sourceforge.net/projects/bio-bwa/",
                        "label": "Download"
                    },
                    {
                        "id": "http://arxiv.org/abs/1303.3997",
                        "label": "Publication"
                    },
                    {
                        "id": "http://www.ncbi.nlm.nih.gov/pubmed/19451168",
                        "label": "Publication BWA Algorithm"
                    }
                ],
                "sbg:expand_workflow": false,
                "sbg:appVersion": [
                    "sbg:draft-2"
                ],
                "sbg:id": "admin/sbg-public-data/bwa-mem-bundle-0-7-17/45",
                "sbg:revision": 45,
                "sbg:revisionNotes": "update categories",
                "sbg:modifiedOn": 1649159217,
                "sbg:modifiedBy": "admin",
                "sbg:createdOn": 1532539861,
                "sbg:createdBy": "admin",
                "sbg:project": "admin/sbg-public-data",
                "sbg:sbgMaintained": false,
                "sbg:validationErrors": [],
                "sbg:contributors": [
                    "admin"
                ],
                "sbg:latestRevision": 45,
                "sbg:publisher": "sbg",
                "sbg:content_hash": "a51b17304fd4034b7467e50aceec7bf180988476261df5039c4d0cb811b3772b5",
                "sbg:workflowLanguage": "CWL"
            },
            "label": "BWA MEM Bundle 0.7.17",
            "sbg:x": 420.55804443359375,
            "sbg:y": 46.66666793823242
        },
        {
            "id": "gatk_haplotypecaller_4_4_0_0",
            "in": [
                {
                    "id": "in_alignments",
                    "source": [
                        "samtools_index_1_9_cwl1_0/indexed_data_file"
                    ]
                },
                {
                    "id": "in_reference",
                    "source": "sbg_fasta_indices/fasta_reference"
                }
            ],
            "out": [
                {
                    "id": "out_variants"
                },
                {
                    "id": "out_alignments"
                },
                {
                    "id": "out_graph"
                },
                {
                    "id": "out_assembly_region"
                },
                {
                    "id": "out_pairhmm"
                }
            ],
            "run": {
                "class": "CommandLineTool",
                "cwlVersion": "v1.2",
                "$namespaces": {
                    "sbg": "https://sevenbridges.com"
                },
                "id": "admin/sbg-public-data/gatk-haplotypecaller-4-4-0-0/3",
                "baseCommand": [
                    "/opt/gatk-4.4.0.0/gatk",
                    "--java-options"
                ],
                "inputs": [
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "0.002",
                        "id": "active_probability_threshold",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--active-probability-threshold",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Active probability threshold",
                        "doc": "Minimum probability for a locus to be considered active."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "adaptive_pruning",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--adaptive-pruning",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Adaptive pruning",
                        "doc": "Use Mutect2's adaptive graph pruning algorithm."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "0.001",
                        "id": "adaptive_pruning_initial_error_rate",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--adaptive-pruning-initial-error-rate",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Adaptive pruning initial error rate",
                        "doc": "Initial base error rate estimate for adaptive pruning."
                    },
                    {
                        "sbg:altPrefix": "-add-output-sam-program-record",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "true",
                        "id": "add_output_sam_program_record",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "add_output_sam_program_record"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--add-output-sam-program-record",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Add output SAM program record",
                        "doc": "If true, adds a PG tag to created SAM/BAM/CRAM files."
                    },
                    {
                        "sbg:altPrefix": "-add-output-vcf-command-line",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "true",
                        "id": "add_output_vcf_command_line",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "add_output_vcf_command_line"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--add-output-vcf-command-line",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Add output VCF command line",
                        "doc": "If true, adds a command line header line to created VCF files."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "all_site_pls",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--all-site-pls",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Annotate all sites with PLs",
                        "doc": "Advanced, experimental argument: if SNP likelihood model is specified, and if EMIT_ALL_SITES output mode is set, when we set this argument then we will also emit PLs at all sites. This will give a measure of reference confidence and a measure of which alt alleles are more plausible (if any). WARNINGS: - This feature will inflate VCF file size considerably. - All SNP ALT alleles will be emitted with corresponding 10 PL values. - An error will be emitted if EMIT_ALL_SITES is not set, or if anything other than diploid SNP model is used"
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "alleles",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--alleles",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Alleles",
                        "doc": "The set of alleles to force-call regardless of evidence.",
                        "sbg:fileTypes": "VCF, VCF.GZ",
                        "secondaryFiles": [
                            {
                                "pattern": ".idx",
                                "required": false
                            },
                            {
                                "pattern": ".tbi",
                                "required": false
                            }
                        ]
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "allow_non_unique_kmers_in_ref",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--allow-non-unique-kmers-in-ref",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Allow non unique kmers in ref",
                        "doc": "Allow graphs that have non-unique kmers in the reference."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "annotate_with_num_discovered_alleles",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--annotate-with-num-discovered-alleles",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Annotate with num discovered alleles",
                        "doc": "If provided, we will annotate records with the number of alternate alleles that were discovered (but not necessarily genotyped) at a given site."
                    },
                    {
                        "sbg:altPrefix": "-A",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "annotation",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.annotation).length; i++ ){\n        cmd += \" --annotation \" + [].concat(inputs.annotation)[i];\n    }    \n    return cmd;\n}"
                        },
                        "label": "Annotation",
                        "doc": "One or more specific annotations to add to variant calls. This argument may be specified 0 or more times.\n\nPossible values: \nAlleleFraction, AllelePseudoDepth,   AS_BaseQualityRankSumTest, AS_FisherStrand, AS_InbreedingCoeff,   AS_MappingQualityRankSumTest, AS_QualByDepth, AS_ReadPosRankSumTest, AS_RMSMappingQuality,   AS_StrandBiasMutectAnnotation, AS_StrandOddsRatio, AssemblyComplexity, BaseQuality,   BaseQualityHistogram, BaseQualityRankSumTest, ChromosomeCounts, ClippingRankSumTest,   CountNs, Coverage, CycleSkipStatus, DepthPerAlleleBySample, DepthPerSampleHC, ExcessHet,   FeaturizedReadSets, FisherStrand, FragmentDepthPerAlleleBySample, FragmentLength,   GcContent, GenotypeSummaries, HaplotypeFilteringAnnotation, HmerIndelLength, HmerIndelNuc,   HmerMotifs, InbreedingCoeff, IndelClassify, IndelLength, LikelihoodRankSumTest,   MappingQuality, MappingQualityRankSumTest, MappingQualityZero, OrientationBiasReadCounts,   OriginalAlignment, PossibleDeNovo, QualByDepth, RawGtCount, ReadPosition,   ReadPosRankSumTest, ReferenceBases, RMSMappingQuality, SampleList, StrandBiasBySample,   StrandOddsRatio, TandemRepeat, UniqueAltReadCount, VariantType"
                    },
                    {
                        "sbg:altPrefix": "-G",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "annotation_group",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.annotation_group).length; i++ ){\n        cmd += \" --annotation-group \" + [].concat(inputs.annotation_group)[i];\n    }    \n    return cmd;\n}"
                        },
                        "label": "Annotation group",
                        "doc": "One or more groups of annotations to apply to variant calls. Any requirements that are not met (e.g. failing to provide a pedigree file for a pedigree-based annotation) may cause the run to fail. This argument may be specified 0 or more times.\n\nPossible values: \nAlleleSpecificAnnotation, AS_StandardAnnotation, GenotypeAnnotation, InfoFieldAnnotation, JumboGenotypeAnnotation, JumboInfoAnnotation, ReducibleAnnotation, StandardAnnotation, StandardFlowBasedAnnotation, StandardHCAnnotation, StandardMutectAnnotation, VariantAnnotation"
                    },
                    {
                        "sbg:altPrefix": "-AX",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "annotations_to_exclude",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.annotations_to_exclude).length; i++ ){\n        cmd += \" --annotations-to-exclude \" + [].concat(inputs.annotations_to_exclude)[i];\n    }    \n    return cmd;\n}"
                        },
                        "label": "Annotations to exclude",
                        "doc": "One or more specific annotations to exclude from variant calls. This argument may be specified 0 or more times. Which annotations to exclude from output in the variant calls. Note that this argument has higher priority than the -A or -G arguments, so these annotations will be excluded even if they are explicitly included with the other options.\n\nPossible values: \nBaseQualityRankSumTest, ChromosomeCounts, Coverage, DepthPerAlleleBySample, DepthPerSampleHC, ExcessHet, FisherStrand, InbreedingCoeff, MappingQualityRankSumTest, QualByDepth, ReadPosRankSumTest, RMSMappingQuality, StrandOddsRatio"
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "assembly_region_out",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--assembly-region-out",
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    if(inputs.assembly_region_out) {\n        var tmp = inputs.assembly_region_out.slice(-4);\n\n        if(tmp == \".igv\" || tmp == \".IGV\") {\n            return inputs.assembly_region_out.slice(0,-4) + '.assembly.igv';\n        }\n        else {\n            return inputs.assembly_region_out + '.assembly.igv';\n        }\n    }\n    else {\n        return null;\n    }\n}"
                        },
                        "label": "Assembly region output",
                        "doc": "Name of the IGV file to which assembly region should be written. Suffix \".assembly.igv\" will be added to the file name."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "100",
                        "id": "assembly_region_padding",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--assembly-region-padding",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Assembly region padding",
                        "doc": "Number of additional bases of context to include around each assembly region."
                    },
                    {
                        "sbg:altPrefix": "-bamout",
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "bam_output",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--bam-output",
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    if(inputs.bam_output) {\n        var tmp = inputs.bam_output.slice(-4);\n        if(tmp == \".bam\" || tmp == \".BAM\") {\n            return inputs.bam_output.slice(0, -4) + '.bam';\n        }\n        else {\n            return inputs.bam_output + '.bam';\n        }\n    }\n    else {\n        return null;\n    }\n}"
                        },
                        "label": "BAM output",
                        "doc": "Name of the file to which assembled haplotypes should be written."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "CALLED_HAPLOTYPES",
                        "id": "bam_writer_type",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "ALL_POSSIBLE_HAPLOTYPES",
                                    "CALLED_HAPLOTYPES",
                                    "NO_HAPLOTYPES",
                                    "CALLED_HAPLOTYPES_NO_READS"
                                ],
                                "name": "bam_writer_type"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--bam-writer-type",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "BAM writer type",
                        "doc": "Which haplotypes should be written to the BAM."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "18",
                        "id": "base_quality_score_threshold",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--base-quality-score-threshold",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Base quality score threshold",
                        "doc": "Base qualities below this threshold will be reduced to the minimum (6)."
                    },
                    {
                        "sbg:altPrefix": "-comp",
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "comp",
                        "type": "File[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.comp).length; i++ ){\n        cmd += \" --comparison \" + [].concat(inputs.comp)[i].path;\n    }    \n    return cmd;\n}"
                        },
                        "label": "Comparison VCF",
                        "doc": "Comparison vcf file(s). If a call overlaps with a record from the provided comp track, the INFO field will be annotated as such in the output with the track name. Records that are filtered in the comp track will be ignored. Note that 'dbSNP' has been special-cased (see the --dbsnp)",
                        "sbg:fileTypes": "VCF, VCF.GZ",
                        "secondaryFiles": [
                            {
                                "pattern": ".idx",
                                "required": false
                            },
                            {
                                "pattern": ".tbi",
                                "required": false
                            }
                        ]
                    },
                    {
                        "sbg:altPrefix": "-contamination-file",
                        "sbg:category": "Advanced Arguments",
                        "id": "contamination_fraction_per_sample_file",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--contamination-fraction-per-sample-file",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Contamination fraction per sample",
                        "doc": "Tab-separated file containing fraction of contamination in sequencing data (per sample) to aggressively remove. Format should be \"<SampleID><TAB><Contamination>\" (Contamination is double) per line; No header.",
                        "sbg:fileTypes": "TSV"
                    },
                    {
                        "sbg:altPrefix": "-contamination",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "0.0",
                        "id": "contamination_fraction_to_filter",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--contamination-fraction-to-filter",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Contamination fraction to filter",
                        "doc": "Fraction of contamination in sequencing data (for all samples) to aggressively remove ."
                    },
                    {
                        "sbg:altPrefix": "-OBI",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "true",
                        "id": "create_output_bam_index",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "create_output_bam_index"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--create-output-bam-index",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Create output BAM index",
                        "doc": "If true, create a BAM/CRAM index when writing a coordinate-sorted BAM/CRAM file."
                    },
                    {
                        "sbg:altPrefix": "-OVI",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "true",
                        "id": "create_output_variant_index",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "create_output_variant_index"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--create-output-variant-index",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Create output variant index",
                        "doc": "If true, create a VCF index when writing a coordinate-sorted VCF file."
                    },
                    {
                        "sbg:altPrefix": "-D",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "dbsnp",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--dbsnp",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "dbSNP",
                        "doc": "dbSNP file.",
                        "sbg:fileTypes": "VCF, VCF.GZ",
                        "secondaryFiles": [
                            {
                                "pattern": ".idx",
                                "required": false
                            },
                            {
                                "pattern": ".tbi",
                                "required": false
                            }
                        ]
                    },
                    {
                        "sbg:altPrefix": "-debug",
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "debug_assembly",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--debug-assembly",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Debug assembly",
                        "doc": "Print out verbose debug information about each assembly region."
                    },
                    {
                        "sbg:altPrefix": "-DBIC",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "disable_bam_index_caching",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable-bam-index-caching",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Disable BAM index caching",
                        "doc": "If true, don't cache BAM indexes, this will reduce memory requirements but may harm performance if many intervals are specified. Caching is automatically disabled if there are no intervals specified."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "disable_optimizations",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable-optimizations",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Disable optimizations",
                        "doc": "Don't skip calculations in active regions with no variants."
                    },
                    {
                        "sbg:altPrefix": "-DF",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "disable_read_filter",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.disable_read_filter).length; i++ ){\n        cmd += \" --disable-read-filter \" + [].concat(inputs.disable_read_filter)[i];\n    }    \n    return cmd;\n}"
                        },
                        "label": "Disable read filter",
                        "doc": "Read filters to be disabled before analysis. This argument may be specified 0 or more times.\n\nPossible values:\nGoodCigarReadFilter, MappedReadFilter, MappingQualityAvailableReadFilter, MappingQualityReadFilter, NonZeroReferenceLengthAlignmentReadFilter, NotDuplicateReadFilter, NotSecondaryAlignmentReadFilter, PassesVendorQualityCheckReadFilter, WellformedReadFilter"
                    },
                    {
                        "sbg:altPrefix": "-disable-sequence-dictionary-validation",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "disable_sequence_dictionary_validation",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable-sequence-dictionary-validation",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Disable sequence dictionary validation",
                        "doc": "If specified, do not check the sequence dictionaries from our inputs for compatibility. Use at your own risk!"
                    },
                    {
                        "sbg:altPrefix": "-disable-tool-default-annotations",
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "disable_tool_default_annotations",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable-tool-default-annotations",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Disable tool default annotations",
                        "doc": "Disable all tool default annotations."
                    },
                    {
                        "sbg:altPrefix": "-disable-tool-default-read-filters",
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "disable_tool_default_read_filters",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable-tool-default-read-filters",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Disable tool default read filters",
                        "doc": "Disable all tool default read filters (warning: many tools will not function correctly without their default read filters on)."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "do_not_run_physical_phasing",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--do-not-run-physical-phasing",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Do not run physical phasing",
                        "doc": "Disable physical phasing."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "dont_increase_kmer_sizes_for_cycles",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--dont-increase-kmer-sizes-for-cycles",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Dont increase kmer sizes for cycles",
                        "doc": "Disable iterating over kmer sizes when graph cycles are detected."
                    },
                    {
                        "sbg:altPrefix": "-ERC",
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "NONE",
                        "id": "emit_ref_confidence",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "NONE",
                                    "BP_RESOLUTION",
                                    "GVCF"
                                ],
                                "name": "emit_ref_confidence"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--emit-ref-confidence",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Emit ref confidence",
                        "doc": "Mode for emitting reference confidence scores."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "enable_all_annotations",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--enable-all-annotations",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Enable all annotations",
                        "doc": "Use all possible annotations (not for the faint of heart)."
                    },
                    {
                        "sbg:altPrefix": "-XL",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "exclude_intervals_string",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.exclude_intervals_string).length; i++ ){\n        cmd += \" --exclude-intervals \" + [].concat(inputs.exclude_intervals_string)[i];\n    }    \n    return cmd;\n}\n"
                        },
                        "label": "Exclude intervals string",
                        "doc": "One or more genomic intervals to exclude from processing. This argument may be specified 0 or more times."
                    },
                    {
                        "sbg:altPrefix": "-founder-id",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "founder_id",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.founder_id).length; i++ ){\n        cmd += \" --founder-id \" + [].concat(inputs.founder_id)[i];\n    }    \n    return cmd;\n}"
                        },
                        "label": "Founder ID",
                        "doc": "Samples representing the population \"founders\".  This argument may be specified 0 or more times."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "sbg:altPrefix": "-genotype-filtered-alleles",
                        "id": "force_call_filtered_alleles",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--force-call-filtered-alleles",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Force-call filtered alleles",
                        "doc": "Force-call filtered alleles included in the resource specified by --alleles."
                    },
                    {
                        "sbg:altPrefix": "-graph",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "graph_output",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--graph-output",
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    if(inputs.graph_output) {\n        var tmp = inputs.graph_output.slice(-4);\n        if(tmp == \".txt\" || tmp == \".TXT\") {\n            return inputs.graph_output.slice(0, -4) + '.graph.txt';\n        }\n        else {\n            return inputs.graph_output + '.graph.txt';\n        }\n    }\n    else {\n        return null;\n    }\n}"
                        },
                        "label": "Graph output",
                        "doc": "Name of the file to which debug assembly graph information should be written. Suffix \".graph.txt\" will be added to the file name."
                    },
                    {
                        "sbg:altPrefix": "-GQB",
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 70, 80, 90, 99",
                        "id": "gvcf_gq_bands",
                        "type": "int[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.gvcf_gq_bands).length; i++ ){\n        cmd += \" --gvcf-gq-bands \" + [].concat(inputs.gvcf_gq_bands)[i];\n    }    \n    return cmd;\n}"
                        },
                        "label": "GVCF GQ bands",
                        "doc": "Exclusive upper bounds for reference confidence GQ bands (must be in [1, 100] and specified in increasing order). This argument may be specified 0 or more times."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "0.001",
                        "id": "heterozygosity",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--heterozygosity",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Heterozygosity",
                        "doc": "Heterozygosity value used to compute prior probabilities for any locus. See the GATKDocs for full details on the meaning of this population genetics concept."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "0.01",
                        "id": "heterozygosity_stdev",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--heterozygosity-stdev",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Heterozygosity stdev",
                        "doc": "Standard deviation of heterozygosity for SNP and indel calling."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "1.25E-4",
                        "id": "indel_heterozygosity",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--indel-heterozygosity",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Indel heterozygosity",
                        "doc": "Heterozygosity for indel calling. See the GATKDocs for heterozygosity for full details on the meaning of this population genetics concept."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "10",
                        "id": "indel_size_to_eliminate_in_ref_model",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--indel-size-to-eliminate-in-ref-model",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Indel size to eliminate in ref model",
                        "doc": "The size of an indel to check for in the reference model."
                    },
                    {
                        "sbg:altPrefix": "-I",
                        "sbg:category": "Required Arguments",
                        "id": "in_alignments",
                        "type": "File[]",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.in_alignments).length; i++ ){\n        cmd += \" --input \" + [].concat(inputs.in_alignments)[i].path;\n    }    \n    return cmd;\n}"
                        },
                        "label": "Input alignments",
                        "doc": "BAM/SAM/CRAM file containing reads. This argument must be specified at least once.",
                        "sbg:fileTypes": "BAM, CRAM",
                        "secondaryFiles": [
                            {
                                "pattern": ".bai",
                                "required": false
                            },
                            {
                                "pattern": "^.bai",
                                "required": false
                            },
                            {
                                "pattern": ".crai",
                                "required": false
                            },
                            {
                                "pattern": "^.crai",
                                "required": false
                            }
                        ]
                    },
                    {
                        "sbg:altPrefix": "-ixp",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "0",
                        "id": "interval_exclusion_padding",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--interval-exclusion-padding",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Interval exclusion padding",
                        "doc": "Amount of padding (in bp) to add to each interval you are excluding."
                    },
                    {
                        "sbg:altPrefix": "-imr",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "ALL",
                        "id": "interval_merging_rule",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "ALL",
                                    "OVERLAPPING_ONLY"
                                ],
                                "name": "interval_merging_rule"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--interval-merging-rule",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Interval merging rule",
                        "doc": "Interval merging rule for abutting intervals."
                    },
                    {
                        "sbg:altPrefix": "-ip",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "0",
                        "id": "interval_padding",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--interval-padding",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Interval padding",
                        "doc": "Amount of padding (in bp) to add to each interval you are including."
                    },
                    {
                        "sbg:altPrefix": "-isr",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "UNION",
                        "id": "interval_set_rule",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "UNION",
                                    "INTERSECTION"
                                ],
                                "name": "interval_set_rule"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--interval-set-rule",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Interval set rule",
                        "doc": "Set merging approach to use for combining interval inputs."
                    },
                    {
                        "sbg:altPrefix": "-L",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "include_intervals_file",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--intervals",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Include intervals file",
                        "doc": "One or more genomic intervals over which to operate.",
                        "sbg:fileTypes": "INTERVAL_LIST, LIST, BED"
                    },
                    {
                        "sbg:altPrefix": "-L",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "include_intervals_string",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.include_intervals_string).length; i++ ){\n        cmd += \" --intervals \" + [].concat(inputs.include_intervals_string)[i];\n    }    \n    return cmd;\n}\n"
                        },
                        "label": "Include intervals string",
                        "doc": "One or more genomic intervals over which to operate. This argument may be specified 0 or more times."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "10, 25",
                        "id": "kmer_size",
                        "type": "int[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.kmer_size).length; i++ ){\n        cmd += \" --kmer-size \" + [].concat(inputs.kmer_size)[i];\n    }    \n    return cmd;\n}"
                        },
                        "label": "Kmer size",
                        "doc": "Kmer size to use in the read threading assembler. This argument may be specified 0 or more times."
                    },
                    {
                        "sbg:altPrefix": "-LE",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "lenient",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--lenient",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Lenient",
                        "doc": "Lenient processing of VCF files."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "6",
                        "id": "max_alternate_alleles",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-alternate-alleles",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max alternate alleles",
                        "doc": "Maximum number of alternate alleles to genotype."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "300",
                        "id": "max_assembly_region_size",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-assembly-region-size",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max assembly region size",
                        "doc": "Maximum size of an assembly region."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "1024",
                        "id": "max_genotype_count",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-genotype-count",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max genotype count",
                        "doc": "Maximum number of genotypes to consider at any site."
                    },
                    {
                        "sbg:altPrefix": "-mnp-dist",
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "0",
                        "id": "max_mnp_distance",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-mnp-distance",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max MNP distance",
                        "doc": "Two or more phased substitutions separated by this distance or less are merged into MNPs."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "128",
                        "id": "max_num_haplotypes_in_population",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-num-haplotypes-in-population",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max num haplotypes in population",
                        "doc": "Maximum number of haplotypes to consider for your population."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "50",
                        "id": "max_prob_propagation_distance",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-prob-propagation-distance",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max prob propagation distance",
                        "doc": "Upper limit on how many bases away probability mass can be moved around when calculating the boundaries between active and inactive assembly regions."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "50",
                        "id": "max_reads_per_alignment_start",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-reads-per-alignment-start",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max reads per alignment start",
                        "doc": "Maximum number of reads to retain per alignment start position. Reads above this threshold will be downsampled. Set to 0 to disable."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "100",
                        "id": "max_unpruned_variants",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-unpruned-variants",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max unpruned variants",
                        "doc": "Maximum number of variants in graph the adaptive pruner will allow."
                    },
                    {
                        "sbg:category": "Execution and Platform",
                        "sbg:toolDefaultValue": "100",
                        "id": "mem_overhead_per_job_haplotype_caller",
                        "type": "int?",
                        "label": "Memory overhead per job [MB]",
                        "doc": "It allows a user to set the desired overhead memory (in MB) when running a tool or adding it to a workflow."
                    },
                    {
                        "sbg:category": "Execution and Platform",
                        "sbg:toolDefaultValue": "4000",
                        "id": "mem_per_job_haplotype_caller",
                        "type": "int?",
                        "label": "Memory per job [MB]",
                        "doc": "It allows a user to set the desired memory requirement (in MB) when running a tool or adding it to a workflow."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "50",
                        "id": "min_assembly_region_size",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--min-assembly-region-size",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Min assembly region size",
                        "doc": "Minimum size of an assembly region."
                    },
                    {
                        "sbg:altPrefix": "-mbq",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "10",
                        "id": "min_base_quality_score",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--min-base-quality-score",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Min base quality score",
                        "doc": "Minimum base quality required to consider a base for calling."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "4",
                        "id": "min_dangling_branch_length",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--min-dangling-branch-length",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Min dangling branch length",
                        "doc": "Minimum length of a dangling branch to attempt recovery."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "2",
                        "id": "min_pruning",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--min-pruning",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Min pruning",
                        "doc": "Minimum support to not prune paths in the graph."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "4",
                        "id": "native_pair_hmm_threads",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--native-pair-hmm-threads",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Native pairHMM threads",
                        "doc": "How many threads should a native pairHMM implementation use."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "native_pair_hmm_use_double_precision",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--native-pair-hmm-use-double-precision",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Native pairHMM use double precision",
                        "doc": "Use double precision in the native pairHMM. This is slower but matches the java implementation better."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "1",
                        "id": "num_pruning_samples",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--num-pruning-samples",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Num pruning samples",
                        "doc": "Number of samples that must pass the minPruning threshold."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "0",
                        "id": "num_reference_samples_if_no_call",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--num-reference-samples-if-no-call",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Num reference samples if no call",
                        "doc": "Number of hom-ref genotypes to infer at sites not present in a panel."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "null",
                        "id": "output_prefix",
                        "type": "string?",
                        "label": "Output name prefix",
                        "doc": "Output file name prefix."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "EMIT_VARIANTS_ONLY",
                        "id": "output_mode",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "EMIT_VARIANTS_ONLY",
                                    "EMIT_ALL_CONFIDENT_SITES",
                                    "EMIT_ALL_ACTIVE_SITES"
                                ],
                                "name": "output_mode"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--output-mode",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Output mode",
                        "doc": "Specifies which type of calls we should output."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "10",
                        "id": "pair_hmm_gap_continuation_penalty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--pair-hmm-gap-continuation-penalty",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Pair HMM gap continuation penalty",
                        "doc": "Flat gap continuation penalty for use in the pairHMM."
                    },
                    {
                        "sbg:altPrefix": "-pairHMM",
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "FASTEST_AVAILABLE",
                        "id": "pair_hmm_implementation",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "EXACT",
                                    "ORIGINAL",
                                    "LOGLESS_CACHING",
                                    "AVX_LOGLESS_CACHING",
                                    "AVX_LOGLESS_CACHING_OMP",
                                    "FASTEST_AVAILABLE"
                                ],
                                "name": "pair_hmm_implementation"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--pair-hmm-implementation",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Pair HMM implementation",
                        "doc": "The pairHMM implementation to use for genotype likelihood calculations."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "CONSERVATIVE",
                        "id": "pcr_indel_model",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "NONE",
                                    "HOSTILE",
                                    "AGGRESSIVE",
                                    "CONSERVATIVE"
                                ],
                                "name": "pcr_indel_model"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--pcr-indel-model",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "PCR indel model",
                        "doc": "The PCR indel model to use."
                    },
                    {
                        "sbg:altPrefix": "-ped",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "pedigree",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--pedigree",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Pedigree",
                        "doc": "Pedigree file for determining the population \"founders\".",
                        "sbg:fileTypes": "PED"
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "45",
                        "id": "phred_scaled_global_read_mismapping_rate",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--phred-scaled-global-read-mismapping-rate",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Phred scaled global read mismapping rate",
                        "doc": "The global assumed mismapping rate for reads."
                    },
                    {
                        "sbg:altPrefix": "-population",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "population_callset",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--population-callset",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Population callset",
                        "doc": "Callset to use in calculating genotype priors.",
                        "sbg:fileTypes": "VCF, VCF.GZ",
                        "secondaryFiles": [
                            {
                                "pattern": ".idx",
                                "required": false
                            },
                            {
                                "pattern": ".tbi",
                                "required": false
                            }
                        ]
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "2.302585092994046",
                        "id": "pruning_lod_threshold",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--pruning-lod-threshold",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Pruning lod threshold",
                        "doc": "Ln likelihood ratio threshold for adaptive pruning algorithm."
                    },
                    {
                        "sbg:altPrefix": "-RF",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "read_filter",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.read_filter).length; i++ ){\n        cmd += \" --read-filter \" + [].concat(inputs.read_filter)[i];\n    }    \n    return cmd;\n}\n"
                        },
                        "label": "Read filter",
                        "doc": "Read filters to be applied before analysis. This argument may be specified 0 or more times.\n\nPossible values: \nAlignmentAgreesWithHeaderReadFilter, AllowAllReadsReadFilter, AmbiguousBaseReadFilter, CigarContainsNoNOperator,\nExcessiveEndClippedReadFilter,\nFirstOfPairReadFilter, \nFlowBasedTPAttributeSymetricReadFilter, FlowBasedTPAttributeValidReadFilter,\nFragmentLengthReadFilter, GoodCigarReadFilter, HasReadGroupReadFilter, \nHmerQualitySymetricReadFilter, IntervalOverlapReadFilter, JexlExpressionReadTagValueFilter, LibraryReadFilter, MappedReadFilter, MappingQualityAvailableReadFilter, MappingQualityNotZeroReadFilter, MappingQualityReadFilter, MatchingBasesAndQualsReadFilter, MateDifferentStrandReadFilter, MateDistantReadFilter, MateOnSameContigOrNoMappedMateReadFilter, MateUnmappedAndUnmappedReadFilter, MetricsReadFilter, NonChimericOriginalAlignmentReadFilter, NonZeroFragmentLengthReadFilter, NonZeroReferenceLengthAlignmentReadFilter, NotDuplicateReadFilter, NotOpticalDuplicateReadFilter, NotProperlyPairedReadFilter, NotSecondaryAlignmentReadFilter, NotSupplementaryAlignmentReadFilter, OverclippedReadFilter, PairedReadFilter, PassesVendorQualityCheckReadFilter, PlatformReadFilter, PlatformUnitReadFilter, PrimaryLineReadFilter, ProperlyPairedReadFilter, ReadGroupBlackListReadFilter, ReadGroupHasFlowOrderReadFilter, ReadGroupReadFilter, ReadLengthEqualsCigarLengthReadFilter, ReadLengthReadFilter, ReadNameReadFilter, ReadStrandFilter, ReadTagValueFilter, SampleReadFilter, SecondOfPairReadFilter, SeqIsStoredReadFilter, SoftClippedReadFilter, ValidAlignmentEndReadFilter, ValidAlignmentStartReadFilter, WellformedFlowBasedReadFilter, WellformedReadFilter"
                    },
                    {
                        "sbg:altPrefix": "-VS",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "SILENT",
                        "id": "read_validation_stringency",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "STRICT",
                                    "LENIENT",
                                    "SILENT"
                                ],
                                "name": "read_validation_stringency"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--read-validation-stringency",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Read validation stringency",
                        "doc": "Validation stringency for all SAM/BAM/CRAM/SRA files read by this program. The default stringency value silent can improve performance when processing a bam file in which variable-length data (read, qualities, tags) do not otherwise need to be decoded."
                    },
                    {
                        "sbg:altPrefix": "-R",
                        "sbg:category": "Required Arguments",
                        "sbg:toolDefaultValue": "FASTA, FA",
                        "id": "in_reference",
                        "type": "File",
                        "inputBinding": {
                            "prefix": "--reference",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Reference",
                        "doc": "Reference sequence file.",
                        "sbg:fileTypes": "FASTA, FA",
                        "secondaryFiles": [
                            {
                                "pattern": ".fai",
                                "required": false
                            },
                            {
                                "pattern": "^.dict",
                                "required": false
                            }
                        ]
                    },
                    {
                        "sbg:altPrefix": "-ALIAS",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "null",
                        "id": "sample_name",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--sample-name",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Sample name",
                        "doc": "Name of single sample to use from a multi-sample bam."
                    },
                    {
                        "sbg:altPrefix": "-ploidy",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "2",
                        "id": "sample_ploidy",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--sample-ploidy",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Sample ploidy",
                        "doc": "Ploidy (number of chromosomes) per sample. For pooled data, set to (number of samples in each pool x Sample Ploidy)."
                    },
                    {
                        "sbg:altPrefix": "-sequence-dictionary",
                        "sbg:category": "Optional Arguments",
                        "id": "sequence_dictionary",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--sequence-dictionary",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Sequence dictionary",
                        "doc": "Use the given sequence dictionary as the master/canonical sequence dictionary. Must be a .dict file.",
                        "sbg:fileTypes": "DICT"
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "sites_only_vcf_output",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--sites-only-vcf-output",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Sites only VCF output",
                        "doc": "If true, don't emit genotype fields when writing VCF file output."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "JAVA",
                        "id": "smith_waterman",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "FASTEST_AVAILABLE",
                                    "AVX_ENABLED",
                                    "JAVA"
                                ],
                                "name": "smith_waterman"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--smith-waterman",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman",
                        "doc": "Which Smith-Waterman implementation to use, generally FASTEST_AVAILABLE is the right choice."
                    },
                    {
                        "sbg:altPrefix": "-stand-call-conf",
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "30.0",
                        "id": "standard_min_confidence_threshold_for_calling",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--standard-min-confidence-threshold-for-calling",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Standard min confidence threshold for calling",
                        "doc": "The minimum phred-scaled confidence threshold at which variants should be called. Only variant sites with QUAL equal or greater than this threshold will be called. When HaplotypeCaller is used in GVCF mode (using either -ERC GVCF or -ERC BP_RESOLUTION) the call threshold is automatically set to zero. Call confidence thresholding will then be performed in the subsequent GenotypeGVCFs command."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "use_filtered_reads_for_annotations",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--use-filtered-reads-for-annotations",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Use filtered reads for annotations",
                        "doc": "Use the contamination-filtered read maps for the purposes of annotating variants."
                    },
                    {
                        "sbg:altPrefix": "-XL",
                        "sbg:category": "Optional Arguments",
                        "id": "exclude_intervals_file",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--exclude-intervals",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Exclude intervals file",
                        "doc": "One or more genomic intervals to exclude from processing.",
                        "sbg:fileTypes": "INTERVAL_LIST, LIST, BED"
                    },
                    {
                        "sbg:category": "Execution and Platform",
                        "sbg:toolDefaultValue": "1",
                        "id": "cpu_per_job_haplotype_caller",
                        "type": "int?",
                        "label": "CPU per job",
                        "doc": "Number of CPUs to be used per job."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "vcf.gz",
                        "id": "output_extension",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "vcf",
                                    "vcf.gz"
                                ],
                                "name": "output_extension"
                            }
                        ],
                        "label": "Output VCF extension",
                        "doc": "Output VCF extension."
                    },
                    {
                        "sbg:toolDefaultValue": "10.00",
                        "sbg:category": "Optional Arguments",
                        "sbg:altPrefix": "-seconds-between-progress-updates",
                        "id": "seconds_between_progress_updates",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--seconds-between-progress-updates",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Seconds between progress updates",
                        "doc": "Output traversal statistics every time this many seconds elapse."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "dont_use_dragstr_pair_hmm_scores",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--dont-use-dragstr-pair-hmm-scores",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Do not use DRAGstr pair hmm scores",
                        "doc": "Disable DRAGstr pair-hmm score even when dragstr-params-path was provided."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Optional Arguments",
                        "id": "dragen_mode",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--dragen-mode",
                            "shellQuote": false,
                            "position": 3
                        },
                        "label": "DRAGEN mode",
                        "doc": "Single argument for enabling the bulk of DRAGEN-GATK features. NOTE: THIS WILL OVERWRITE PROVIDED ARGUMENT CHECK TOOL INFO TO SEE WHICH ARGUMENTS ARE SET)."
                    },
                    {
                        "sbg:toolDefaultValue": "2",
                        "sbg:category": "Optional Arguments",
                        "id": "dragstr_het_hom_ratio",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--dragstr-het-hom-ratio",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "DRAGstr het hom ratio",
                        "doc": "Het to hom prior ratio use with DRAGstr on."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "id": "dragstr_params_path",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--dragstr-params-path",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "DRAGstr parameters",
                        "doc": "File with the DRAGstr model parameters for STR error correction used in the Pair HMM. When provided, it overrides other PCR error correcting mechanisms.",
                        "sbg:fileTypes": "TXT"
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Optional Arguments",
                        "id": "enable_dynamic_read_disqualification_for_genotyping",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--enable-dynamic-read-disqualification-for-genotyping",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Enable dynamic read disqualification for genotyping",
                        "doc": "Will enable less strict read disqualification low base quality reads. If enabled, rather than disqualifying all reads over a threshold of minimum hmm scores we will instead choose a less strict and less aggressive cap for disqualification based on the read length and base qualities."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:altPrefix": "-gam",
                        "sbg:toolDefaultValue": "USE_PLS_TO_ASSIGN",
                        "id": "genotype_assignment_method",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "SET_TO_NO_CALL",
                                    "USE_PLS_TO_ASSIGN",
                                    "USE_POSTERIORS_ANNOTATION",
                                    "SET_TO_NO_CALL_NO_ANNOTATIONS",
                                    "BEST_MATCH_TO_ORIGINAL",
                                    "DO_NOT_ASSIGN_GENOTYPES",
                                    "USE_POSTERIOR_PROBABILITIES",
                                    "PREFER_PLS"
                                ],
                                "name": "genotype_assignment_method"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--genotype-assignment-method",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Genotype assignment method",
                        "doc": "How genotypes are assigned."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Optional Arguments",
                        "sbg:altPrefix": "-gp-qual",
                        "id": "use_posteriors_to_calculate_qual",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--use-posteriors-to-calculate-qual",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Use posteriors to calculate qual",
                        "doc": "If available, use the genotype posterior probabilities to calculate the site QUAL."
                    },
                    {
                        "sbg:toolDefaultValue": "2",
                        "sbg:category": "Advanced Arguments",
                        "id": "allele_informative_reads_overlap_margin",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--allele-informative-reads-overlap-margin",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Allele informative reads overlap margin",
                        "doc": "Likelihood and read-based annotations will only take into consideration reads that overlap the variant or any base no further than this distance expressed in base pairs."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "apply_bqd",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--apply-bqd",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Apply BQD",
                        "doc": "If enabled this argument will apply the DRAGEN-GATK BaseQualityDropout model to the genotyping model for filtering sites due to Linked Error mode."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "apply_frd",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--apply-frd",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Apply FRD",
                        "doc": "If enabled this argument will apply the DRAGEN-GATK ForeignReadDetection model to the genotyping model for filtering sites."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "disable_cap_base_qualities_to_map_quality",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable-cap-base-qualities-to-map-quality",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Disable cap base qualities to map quality",
                        "doc": "If false this disables capping of base qualities in the HMM to the mapping quality of the read."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "disable_spanning_event_genotyping",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable-spanning-event-genotyping",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Disable spanning event genotyping",
                        "doc": "If enabled this argument will disable inclusion of the '*' spanning event when genotyping events that overlap deletions."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "disable_symmetric_hmm_normalizing",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--disable-symmetric-hmm-normalizing",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Disable symmetric HMM normalizing",
                        "doc": "Toggle to revive legacy behavior of asymmetrically normalizing the arguments to the reference haplotype."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "do_not_correct_overlapping_quality",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--do-not-correct-overlapping-quality",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Do not correct overlapping quality",
                        "doc": "Disable overlapping base quality correction. Base quality is capped at half of PCR error rate for bases where read and mate overlap, to account for full correlation of PCR errors at these bases. This argument disables that correction."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "dont_use_dragstr_priors",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--dont-use-dragstr-priors",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Dont use dragstr priors",
                        "doc": "Forfeit the use of the DRAGstr model to calculate genotype priors. This argument does not have any effect in the absence of DRAGstr model parameters (--dragstr-model-params)."
                    },
                    {
                        "sbg:toolDefaultValue": "0.02",
                        "sbg:category": "Advanced Arguments",
                        "id": "expected_mismatch_rate_for_read_disqualification",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--expected-mismatch-rate-for-read-disqualification",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Expected mismatch rate for read disqualification",
                        "doc": "Error rate used to set expectation for post HMM read disqualification based on mismatches."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "floor_blocks",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--floor-blocks",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Floor blocks",
                        "doc": "Output the band lower bound for each GQ block regardless of the data it represents."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "force_active",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--force-active",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Force active",
                        "doc": "If provided, all regions will be marked as active."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "linked_de_bruijn_graph",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--linked-de-bruijn-graph",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Linked De Bruijn graph",
                        "doc": "If enabled, the Assembly Engine will construct a Linked De Bruijn graph to recover better haplotypes. Disables graph simplification into a seq graph, opts to construct a proper De Bruijn graph with potential loops NOTE: --linked-de-bruijn-graph is an experimental feature that does not directly match with the regular HaplotypeCaller. Specifically the haplotype finding code does not perform correctly at complicated sites. Use this mode at your own risk."
                    },
                    {
                        "sbg:toolDefaultValue": "20",
                        "sbg:category": "Advanced Arguments",
                        "id": "mapping_quality_threshold_for_genotyping",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--mapping-quality-threshold-for-genotyping",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Mapping quality threshold for genotyping",
                        "doc": "Control the threshold for discounting reads from the genotyper due to mapping quality after the active region detection and assembly steps but before genotyping. NOTE: this is in contrast to the --minimum-mapping-quality argument which filters reads from all parts of the HaplotypeCaller. If you would like to call genotypes with a different threshold both arguments must be set."
                    },
                    {
                        "sbg:toolDefaultValue": "0",
                        "sbg:category": "Advanced Arguments",
                        "id": "max_effective_depth_adjustment_for_frd",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-effective-depth-adjustment-for-frd",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max effective depth adjustment for FRD",
                        "doc": "Set the maximum depth to modify FRD adjustment to in the event of high depth sites (0 to disable)."
                    },
                    {
                        "sbg:toolDefaultValue": "9.210340371976184",
                        "sbg:category": "Advanced Arguments",
                        "id": "pruning_seeding_lod_threshold",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--pruning-seeding-lod-threshold",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Pruning seeding lod threshold",
                        "doc": "Ln likelihood ratio threshold for seeding subgraph of good variation in adaptive pruning algorithm."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "recover_all_dangling_branches",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--recover-all-dangling-branches",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Recover all dangling branches",
                        "doc": "Recover all dangling branches. By default, the read threading assembler does not recover dangling branches that fork after splitting from the reference. This argument tells the assembly engine to recover all dangling branches."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "soft_clip_low_quality_ends",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--soft-clip-low-quality-ends",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Soft clip low quality ends",
                        "doc": "If enabled will preserve low-quality read ends as softclips (used for DRAGEN-GATK BQD genotyper model)."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Advanced Arguments",
                        "id": "transform_dragen_mapping_quality",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--transform-dragen-mapping-quality",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Transform DRAGEN mapping quality",
                        "doc": "If enabled this argument will map DRAGEN aligner aligned reads with mapping quality <=250 to scale up to MQ 50."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "ambig_filter_bases",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--ambig-filter-bases",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Ambig filter bases",
                        "doc": "Valid only if \"AmbiguousBaseReadFilter\" is specified:\nThreshold number of ambiguous bases. If null, uses threshold fraction; otherwise, overrides threshold fraction. Cannot be used in conjuction with argument(s) ambig-filter-frac."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "0.05",
                        "id": "ambig_filter_frac",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--ambig-filter-frac",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Ambig filter frac",
                        "doc": "Valid only if \"AmbiguousBaseReadFilter\" is specified:\nThreshold fraction of ambiguous bases. Cannot be used in conjuction with argument(s) ambig-filter-bases."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "1000000",
                        "id": "max_fragment_length",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-fragment-length",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max fragment length",
                        "doc": "Valid only if \"FragmentLengthReadFilter\" is specified:\nMaximum length of fragment (insert size)."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "0",
                        "id": "min_fragment_length",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--min-fragment-length",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Min fragment length",
                        "doc": "Valid only if \"FragmentLengthReadFilter\" is specified:\nMinimum length of fragment (insert size)."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "keep_intervals",
                        "type": "string[]?",
                        "inputBinding": {
                            "prefix": "--keep-intervals",
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.keep_intervals).length; i++ ){\n        cmd += \" --keep-intervals \" + [].concat(inputs.keep_intervals)[i];\n    }    \n    return cmd;\n}\n\n\n"
                        },
                        "label": "Keep intervals",
                        "doc": "Valid only if \"IntervalOverlapReadFilter\" is specified:\nOne or more genomic intervals to keep. This argument must be specified at least once."
                    },
                    {
                        "sbg:altPrefix": "-library",
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "library",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.library).length; i++ ){\n        cmd += \" --library \" + [].concat(inputs.library)[i];\n    }    \n    return cmd;\n}\n\n\n"
                        },
                        "label": "Library",
                        "doc": "Valid only if \"LibraryReadFilter\" is specified:\nName of the library to keep. This argument must be specified at least once. Required."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "maximum_mapping_quality",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--maximum-mapping-quality",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Maximum mapping quality",
                        "doc": "Valid only if \"MappingQualityReadFilter\" is specified:\nMaximum mapping quality to keep (inclusive)."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "10",
                        "id": "minimum_mapping_quality",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--minimum-mapping-quality",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Minimum mapping quality",
                        "doc": "Valid only if \"MappingQualityReadFilter\" is specified:\nMinimum mapping quality to keep (inclusive)."
                    },
                    {
                        "sbg:toolDefaultValue": "1000",
                        "sbg:category": "Conditional Arguments for readFilter",
                        "id": "mate_too_distant_length",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--mate-too-distant-length",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Mate too distant length",
                        "doc": "Valid only if \"MateDistantReadFilter\" is specified:\nMinimum start location difference at which mapped mates are considered distant."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "false",
                        "id": "dont_require_soft_clips_both_ends",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--dont-require-soft-clips-both-ends",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Dont require soft clips both ends",
                        "doc": "Valid only if \"OverclippedReadFilter\" is specified:\nAllow a read to be filtered out based on having only 1 soft-clipped block. By default, both ends must have a soft-clipped block, setting this flag requires only 1 soft-clipped block."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "30",
                        "id": "filter_too_short",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--filter-too-short",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Filter too short",
                        "doc": "Valid only if \"OverclippedReadFilter\" is specified:\nMinimum number of aligned bases."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "platform_filter_name",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.platform_filter_name).length; i++ ){\n        cmd += \" --platform-filter-name \" + [].concat(inputs.platform_filter_name)[i];\n    }    \n    return cmd;\n}\n\n\n"
                        },
                        "label": "Platform filter name",
                        "doc": "Valid only if \"PlatformReadFilter\" is specified:\nPlatform attribute (PL) to match. This argument must be specified at least once. Required."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "black_listed_lanes",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.black_listed_lanes).length; i++ ){\n        cmd += \" --black-listed-lanes \" + [].concat(inputs.black_listed_lanes)[i];\n    }    \n    return cmd;\n}"
                        },
                        "label": "Black listed lanes",
                        "doc": "Valid only if \"PlatformUnitReadFilter\" is specified:\nPlatform unit (PU) to filter out. This argument must be specified at least once. Required."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "read_group_black_list",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.read_group_black_list).length; i++ ){\n        cmd += \" --read-group-black-list \" + [].concat(inputs.read_group_black_list)[i];\n    }    \n    return cmd;\n}\n\n\n"
                        },
                        "label": "Read group black list",
                        "doc": "Valid only if \"ReadGroupBlackListReadFilter\" is specified:\nA read group filter expression in the form \"attribute:value\", where \"attribute\" is a two character read group attribute such as \"RG\" or \"PU\". This argument must be specified at least once. Required."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "keep_read_group",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--keep-read-group",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Keep read group",
                        "doc": "Valid only if \"ReadGroupReadFilter\" is specified:\nThe name of the read group to keep. Required."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "max_read_length",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-read-length",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Max read length",
                        "doc": "Valid only if \"ReadLengthReadFilter\" is specified:\nKeep only reads with length at most equal to the specified value. Required."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "1",
                        "id": "min_read_length",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--min-read-length",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Min read length",
                        "doc": "Valid only if \"ReadLengthReadFilter\" is specified:\nKeep only reads with length at least equal to the specified value."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "read_name",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--read-name",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Read name",
                        "doc": "Valid only if \"ReadNameReadFilter\" is specified:\nKeep only reads with this read name. Required."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "keep_reverse_strand_only",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "keep_reverse_strand_only"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--keep-reverse-strand-only",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Keep reverse strand only",
                        "doc": "Valid only if \"ReadStrandFilter\" is specified:\nKeep only reads on the reverse strand. Required."
                    },
                    {
                        "sbg:altPrefix": "-sample",
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "null",
                        "id": "sample",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.sample).length; i++ ){\n        cmd += \" --sample \" + [].concat(inputs.sample)[i];\n    }    \n    return cmd;\n}\n\n\n"
                        },
                        "label": "Sample",
                        "doc": "Valid only if \"SampleReadFilter\" is specified:\nThe name of the sample(s) to keep, filtering out all others. This argument must be specified at least once. Required."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Conditional Arguments for readFilter",
                        "id": "invert_soft_clip_ratio_filter",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--invert-soft-clip-ratio-filter",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Invert soft clip ratio filter",
                        "doc": "Valid only if \"SoftClippedReadFilter\" is specified:\nInverts the results from this filter, causing all variants that would pass to fail and visa-versa."
                    },
                    {
                        "sbg:toolDefaultValue": "null",
                        "sbg:category": "Conditional Arguments for readFilter",
                        "id": "soft_clipped_leading_trailing_ratio",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--soft-clipped-leading-trailing-ratio",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Soft clipped leading trailing ratio",
                        "doc": "Valid only if \"SoftClippedReadFilter\" is specified:\nThreshold ratio of soft clipped bases (leading / trailing the cigar string) to total bases in read for read to be filtered. Cannot be used in conjunction with argument(s) soft-clipped-ratio-threshold."
                    },
                    {
                        "sbg:toolDefaultValue": "null",
                        "sbg:category": "Conditional Arguments for readFilter",
                        "id": "soft_clipped_ratio_threshold",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--soft-clipped-ratio-threshold",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Soft clipped ratio threshold",
                        "doc": "Valid only if \"SoftClippedReadFilter\" is specified:\nThreshold ratio of soft clipped bases (anywhere in the cigar string) to total bases in read for read to be filtered.  Cannot be used in conjunction with argument(s) soft-clipped-leading-trailing-ratio."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "1000",
                        "id": "max_clipped_bases",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--max-clipped-bases",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Maximum number of clipped bases on either end of a given read",
                        "doc": "Valid only if \"ExcessiveEndClippedReadFilter\" is specified:\nMaximum number of clipped bases on either end of a given read."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "12",
                        "id": "read_filter_max_hmer",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--read-filter-max-hmer",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Read filter max hmer",
                        "doc": "Valid only if \"FlowBasedTPAttributeValidReadFilter\" is specified:\nmaxHmer to use for testing in the filter."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "id": "read_filter_tag",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--read-filter-tag",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Read filter tag",
                        "doc": "Valid only if \"ReadTagValueFilter\" is specified: \nLook for this tag in read.  Required."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "0.0",
                        "id": "read_filter_tag_comp",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--read-filter-tag-comp",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Read filter tag compare",
                        "doc": "Valid only if \"ReadTagValueFilter\" is specified: \nCompare value in tag to this value."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "sbg:toolDefaultValue": "EQUAL",
                        "id": "read_filter_tag_op",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "LESS",
                                    "LESS_OR_EQUAL",
                                    "GREATER",
                                    "GREATER_OR_EQUAL",
                                    "EQUAL",
                                    "NOT_EQUAL"
                                ],
                                "name": "read_filter_tag_op"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--read-filter-tag-op",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Read filter tag operator",
                        "doc": "Valid only if \"ReadTagValueFilter\" is specified: \nCompare value in tag to value with this operator. If T is the value in the tag, OP is the operation provided, and V is the value in read-filter-tag, then the read will pass the filter iff T OP V is true."
                    },
                    {
                        "sbg:category": "Conditional Arguments for readFilter",
                        "id": "read_filter_expression",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--read-filter-expression",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Read filter expression",
                        "doc": "Valid only if \"JexlExpressionReadTagValueFilter\" is specified:\nOne or more JEXL expressions used to filter  This argument must be specified at least once. Required."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "false",
                        "sbg:altPrefix": "-OVM",
                        "id": "create_output_variant_md5",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--create-output-variant-md5",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Create output variant md5",
                        "doc": "If true, create a a MD5 digest any VCF file created."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Optional Arguments",
                        "sbg:altPrefix": "-OBM",
                        "id": "create_output_bam_md5",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--create-output-bam-md5",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Create output bam md5",
                        "doc": "If true, create a MD5 digest for any BAM/SAM/CRAM file created."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Conditional Arguments for annotation",
                        "id": "allow_old_rms_mapping_quality_annotation_data",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--allow-old-rms-mapping-quality-annotation-data",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Allow old rms mapping quality annotation data",
                        "doc": "Valid only if \"RMSMappingQuality\" is specified:\nOverride to allow old RMSMappingQuality annotated VCFs to function."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Conditional Arguments for annotation",
                        "id": "dirichlet_keep_prior_in_count",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--dirichlet-keep-prior-in-count",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Dirichlet keep prior in count",
                        "doc": "Valid only if \"AllelePseudoDept\" is specified:\nBy default we don't keep the prior use in the output counts as it makes it easier to interpret this quantity as the number of supporting reads specially in low depth sites. With this toggled the prior is included."
                    },
                    {
                        "sbg:toolDefaultValue": "1.0",
                        "sbg:category": "Conditional Arguments for annotation",
                        "id": "dirichlet_prior_pseudo_count",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--dirichlet-prior-pseudo-count",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Dirichlet prior pseudo count",
                        "doc": "Valid only if \"AllelePseudoDept\" is specified:\nPseudo-count used as prior for all alleles. The default is 1.0 resulting in a flat prior."
                    },
                    {
                        "sbg:toolDefaultValue": "1.0",
                        "sbg:category": "Conditional Arguments for annotation",
                        "id": "pseudo_count_weight_decay_rate",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--pseudo-count-weight-decay-rate",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Pseudo count weight decay rate",
                        "doc": "Valid only if \"AllelePseudoDept\" is specified:\nA what rate the weight of a read decreases base on its informativeness; e.g. 1.0 is linear decay (default), 2.0 is for quadratic decay."
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "sbg:category": "Conditional Arguments for annotation",
                        "id": "assembly_complexity_reference_mode",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--assembly-complexity-reference-mode",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Assembly complexity reference mode",
                        "doc": "Valid only if \"AssemblyComplexity\" is specified:\nIf enabled will treat the reference as the basis for assembly complexity as opposed to estimated germline haplotypes."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "keep_boundary_flows",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--keep-boundary-flows",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Keep boundary flows",
                        "doc": "Prevent spreading of boundary flows."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "PairHMM",
                        "id": "likelihood_calculation_engine",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "PairHMM",
                                    "FlowBased",
                                    "FlowBasedHMM"
                                ],
                                "name": "likelihood_calculation_engine"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--likelihood-calculation-engine",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Likelihood calculation engine",
                        "doc": "What likelihood calculation engine to use to calculate the relative likelihood of reads vs\nhaplotypes."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "id": "pair_hmm_results_file",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--pair-hmm-results-file",
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    if(inputs.pair_hmm_results_file) {\n        var tmp = inputs.pair_hmm_results_file.slice(-4);\n        if(tmp == \".txt\" || tmp == \".TXT\") {\n            return inputs.pair_hmm_results_file.slice(0, -4) + '.pairHMM.txt';\n        }\n        else {\n            return inputs.pair_hmm_results_file + '.pairHMM.txt';\n        }\n    }\n    else {\n        return null;\n    }\n}"
                        },
                        "label": "Pair HMM results file",
                        "doc": "File name to write exact pairHMM inputs/outputs to for debugging purposes. Suffix \".pairHMM.txt\" will be added to the file name."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "pileup_detection",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--pileup-detection",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Pileup detection",
                        "doc": "If enabled, the variant caller will create pileup-based haplotypes in addition to the assembly-based haplotype generation."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "30",
                        "id": "reference_model_deletion_quality",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--reference-model-deletion-quality",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Reference model deletion quality",
                        "doc": "The quality of deletion in the reference model."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "id": "flow_order_for_annotations",
                        "type": "string[]?",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 4,
                            "valueFrom": "${\n    var cmd = \"\";\n    for (var i = 0; i < [].concat(inputs.platform_filter_name).length; i++ ){\n        cmd += \" --platform-filter-name \" + [].concat(inputs.platform_filter_name)[i];\n    }    \n    return cmd;\n}\n"
                        },
                        "label": "Flow order for annotations",
                        "doc": "Flow order used for this annotations. [readGroup:]flowOrder  This argument may be specified 0 or more times."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_assembly_collapse_partial_mode",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-assembly-collapse-partial-mode",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow assembly collapse partial mode",
                        "doc": "Collapse long flow-based hmers only up to difference in reference."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_disallow_probs_larger_than_call",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-disallow-probs-larger-than-call",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow disallow probs larger than call",
                        "doc": "Cap probabilities of error to 1 relative to base call."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "0.001",
                        "id": "flow_fill_empty_bins_value",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--flow-fill-empty-bins-value",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow fill empty bins value",
                        "doc": "Value to fill the zeros of the matrix with."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_filter_alleles",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-filter-alleles",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow filter alleles",
                        "doc": "Pre-filter alleles before genotyping."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "30.0",
                        "id": "flow_filter_alleles_qual_threshold",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--flow-filter-alleles-qual-threshold",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow filter alleles qual threshold",
                        "doc": "Threshold for prefiltering alleles on quality."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "3.0",
                        "id": "flow_filter_alleles_sor_threshold",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--flow-filter-alleles-sor-threshold",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow filter alleles SOR threshold",
                        "doc": "Threshold for prefiltering alleles on SOR."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_filter_lone_alleles",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-filter-lone-alleles",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow filter lone alleles",
                        "doc": "Remove also lone alleles during allele filtering."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_lump_probs",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-lump-probs",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow lump probabilities",
                        "doc": "Should all probabilities of insertion or deletion in the flow be combined together."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "id": "flow_matrix_mods",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--flow-matrix-mods",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow matrix modifications",
                        "doc": "Modifications instructions to the read flow matrix. Format is src,dst{,src,dst}+."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "NONE",
                        "id": "flow_mode",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "NONE",
                                    "STANDARD",
                                    "ADVANCED"
                                ],
                                "name": "flow_mode"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--flow-mode",
                            "shellQuote": false,
                            "position": 3
                        },
                        "label": "Flow mode",
                        "doc": "Single argument for enabling the bulk of Flow Based features. NOTE: THIS WILL OVERWRITE PROVIDED ARGUMENT)."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "10",
                        "id": "flow_probability_scaling_factor",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--flow-probability-scaling-factor",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow probability scaling factor",
                        "doc": "Probability scaling factor for (phred=10) for probability quantization."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "0.003",
                        "id": "flow_probability_threshold",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--flow-probability-threshold",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow probability threshold",
                        "doc": "Lowest probability ratio to be used as an option."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "121",
                        "id": "flow_quantization_bins",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--flow-quantization-bins",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow quantization bins",
                        "doc": "Number of bins for probability quantization."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_remove_non_single_base_pair_indels",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-remove-non-single-base-pair-indels",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow remove non single base pair indels",
                        "doc": "Should the probabilities of more then 1 indel be used."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_remove_one_zero_probs",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-remove-one-zero-probs",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow remove one zero probabilities",
                        "doc": "Remove probabilities of basecall of zero from non-zero genome."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_report_insertion_or_deletion",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-report-insertion-or-deletion",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow report insertion or deletion",
                        "doc": "Report either insertion or deletion, probability, not both."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_retain_max_n_probs_base_format",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-retain-max-n-probs-base-format",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow retain max n probabilities base format",
                        "doc": "Keep only hmer/2 probabilities (like in base format)."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_symmetric_indel_probs",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-symmetric-indel-probs",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow symmetric indel probabilities",
                        "doc": "Should indel probabilities be symmetric in flow."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "False",
                        "id": "flow_use_t0_tag",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--flow-use-t0-tag",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Flow use t0 tag",
                        "doc": "Use t0 tag if exists in the read to create flow matrix."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "-6",
                        "id": "smith_waterman_dangling_end_gap_extend_penalty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-dangling-end-gap-extend-penalty",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman dangling end gap extend penalty",
                        "doc": "Smith-Waterman gap-extend penalty for dangling-end recovery."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "-110",
                        "id": "smith_waterman_dangling_end_gap_open_penalty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-dangling-end-gap-open-penalty",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman dangling end gap open penalty",
                        "doc": "Smith-Waterman gap-open penalty for dangling-end recovery."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "25",
                        "id": "smith_waterman_dangling_end_match_value",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-dangling-end-match-value",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman dangling end match value",
                        "doc": "Smith-Waterman match value for dangling-end recovery."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "-50",
                        "id": "smith_waterman_dangling_end_mismatch_penalty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-dangling-end-mismatch-penalty",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman dangling end mismatch penalty",
                        "doc": "Smith-Waterman mismatch penalty for dangling-end recovery."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "-11",
                        "id": "smith_waterman_haplotype_to_reference_gap_extend_penalty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-haplotype-to-reference-gap-extend-penalty",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman haplotype to reference gap extend penalty",
                        "doc": "Smith-Waterman gap-extend penalty for haplotype-to-reference alignment."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "-260",
                        "id": "smith_waterman_haplotype_to_reference_gap_open_penalty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-haplotype-to-reference-gap-open-penalty",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman haplotype to reference gap open penalty",
                        "doc": "Smith-Waterman gap-open penalty for haplotype-to-reference alignment."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "200",
                        "id": "smith_waterman_haplotype_to_reference_match_value",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-haplotype-to-reference-match-value",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman haplotype to reference match value",
                        "doc": "Smith-Waterman match value for haplotype-to-reference alignment."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "-150",
                        "id": "smith_waterman_haplotype_to_reference_mismatch_penalty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-haplotype-to-reference-mismatch-penalty",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman haplotype to reference mismatch penalty",
                        "doc": "Smith-Waterman mismatch penalty for haplotype-to-reference alignment."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "-5",
                        "id": "smith_waterman_read_to_haplotype_gap_extend_penalty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-read-to-haplotype-gap-extend-penalty",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman read to haplotype gap extend penalty",
                        "doc": "Smith-Waterman gap-extend penalty for read-to-haplotype alignment."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "-30",
                        "id": "smith_waterman_read_to_haplotype_gap_open_penalty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-read-to-haplotype-gap-open-penalty",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman read to haplotype gap open penalty",
                        "doc": "Smith-Waterman gap-open penalty for read-to-haplotype alignment."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "10",
                        "id": "smith_waterman_read_to_haplotype_match_value",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-read-to-haplotype-match-value",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman read to haplotype match value",
                        "doc": "Smith-Waterman match value for read-to-haplotype alignment."
                    },
                    {
                        "sbg:category": "Optional Arguments",
                        "sbg:toolDefaultValue": "-15",
                        "id": "smith_waterman_read_to_haplotype_mismatch_penalty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--smith-waterman-read-to-haplotype-mismatch-penalty",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Smith-Waterman read to haplotype mismatch penalty",
                        "doc": "Smith-Waterman mismatch penalty for read-to-haplotype alignment."
                    },
                    {
                        "sbg:category": "Advanced Arguments",
                        "sbg:toolDefaultValue": "false",
                        "id": "dont_use_soft_clipped_bases",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--dont-use-soft-clipped-bases",
                            "shellQuote": false,
                            "position": 4
                        },
                        "label": "Do not use soft clipped bases",
                        "doc": "Do not analyze soft clipped bases in the reads."
                    }
                ],
                "outputs": [
                    {
                        "id": "out_variants",
                        "doc": "File to which variants should be written.",
                        "label": "VCF output",
                        "type": "File",
                        "outputBinding": {
                            "glob": "${\n    var output_ext = inputs.output_extension ? inputs.output_extension : \"vcf.gz\";\n    return \"*.\" + output_ext;\n}",
                            "outputEval": "$(inheritMetadata(self, inputs.in_alignments))"
                        },
                        "secondaryFiles": [
                            {
                                "pattern": ".idx",
                                "required": false
                            },
                            {
                                "pattern": ".tbi",
                                "required": false
                            },
                            {
                                "pattern": ".md5",
                                "required": false
                            }
                        ],
                        "sbg:fileTypes": "VCF, VCF.GZ"
                    },
                    {
                        "id": "out_alignments",
                        "doc": "File to which assembled haplotypes should be written.",
                        "label": "BAM output",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "${\n    if(inputs.bam_output) {\n        return '*.bam';\n    }\n    else {\n        return null;\n    }\n}",
                            "outputEval": "$(inheritMetadata(self, inputs.in_alignments))"
                        },
                        "secondaryFiles": [
                            {
                                "pattern": "^.bai",
                                "required": false
                            },
                            {
                                "pattern": ".md5",
                                "required": false
                            }
                        ],
                        "sbg:fileTypes": "BAM"
                    },
                    {
                        "id": "out_graph",
                        "doc": "File to which assembly graph information should be written.",
                        "label": "Graph output",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "${\n    if(inputs.graph_output) {\n        return '*.graph.txt';\n    }\n    else {\n        return null;\n    }\n}",
                            "outputEval": "$(inheritMetadata(self, inputs.in_alignments))"
                        },
                        "sbg:fileTypes": "TXT"
                    },
                    {
                        "id": "out_assembly_region",
                        "doc": "Output the assembly region to this IGV formatted file.",
                        "label": "Assembly region",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "${\n    if(inputs.assembly_region_out) {\n        return '*.assembly.igv';\n    }\n    else {\n        return null;\n    }\n}",
                            "outputEval": "$(inheritMetadata(self, inputs.in_alignments))"
                        },
                        "sbg:fileTypes": "IGV"
                    },
                    {
                        "id": "out_pairhmm",
                        "doc": "File to write exact pairHMM inputs/outputs to for debugging purposes.",
                        "label": "Pair HMM results file",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "${\n    if(inputs.pair_hmm_results_file) {\n        return '*.pairHMM.txt';\n    }\n    else {\n        return null;\n    }\n}",
                            "outputEval": "$(inheritMetadata(self, inputs.in_alignments))"
                        },
                        "sbg:fileTypes": "TXT"
                    }
                ],
                "doc": "**GATK HaplotypeCaller** calls germline SNPs and indels from input BAM file(s) via local re-assembly of haplotypes [1].\n\n**GATK HaplotypeCaller** is capable of calling SNPs and indels simultaneously via local de-novo assembly of haplotypes in an active region. In other words, whenever the program encounters a region showing signs of variation, it discards the existing mapping information and completely reassembles the reads in that region. This allows the **GATK HaplotypeCaller** to be more accurate when calling regions that are traditionally difficult to call, for example when they contain different types of variants close to each other. It also makes the **GATK HaplotypeCaller** much better at calling indels than position-based callers like UnifiedGenotyper [1].\n\nIn the GVCF workflow used for scalable variant calling in DNA sequence data, **GATK HaplotypeCaller** runs per-sample to generate an intermediate GVCF (not to be used in final analysis), which can then be used in GenotypeGVCFs for joint genotyping of multiple samples in a very efficient way. The GVCF workflow enables rapid incremental processing of samples as they roll off the sequencer, as well as scaling to very large cohort sizes [1].\n\nIn addition, **HaplotypeCaller** is able to handle non-diploid organisms as well as pooled experiment data. Note however that the algorithms used to calculate variant likelihoods are not well suited to extreme allele frequencies (relative to ploidy) so its use is not recommended for somatic (cancer) variant discovery. For that purpose, use **Mutect2** instead [1].\n\nFinally, **GATK HaplotypeCaller** is also able to correctly handle splice junctions that make RNAseq a challenge for most variant callers, on the condition that the input read data has previously been processed according to [GATK RNAseq short variant discovery (SNPs + Indels)](https://gatk.broadinstitute.org/hc/en-us/articles/360035531192?id=4067) [1].\n\n*A list of **all inputs and parameters** with corresponding descriptions can be found at the bottom of this page.*\n\n***Please note that any cloud infrastructure costs resulting from app and pipeline executions, including the use of public apps, are the sole responsibility of you as a user. To avoid excessive costs, please read the app description carefully and set the app parameters and execution settings accordingly.***\n\n### Common Use Cases\n\n- Call variants individually on each sample in GVCF mode.\n\n```\n gatk --java-options \"-Xmx4g\" HaplotypeCaller  \\\n   -R Homo_sapiens_assembly38.fasta \\\n   -I input.bam \\\n   -O output.g.vcf.gz \\\n   -ERC GVCF\n```\n\n\n- Call variants individually on each sample in GVCF mode with allele-specific annotations. [Here](https://gatk.broadinstitute.org/hc/en-us/articles/360035890551?id=9622) you can read more details about allele-specific annotation and filtering.\n\n```\ngatk --java-options \"-Xmx4g\" HaplotypeCaller  \\\n   -R Homo_sapiens_assembly38.fasta \\\n   -I input.bam \\\n   -O output.g.vcf.gz \\\n   -ERC GVCF \\\n   -G Standard \\\n   -G AS_Standard\n```\n\n\n- Call variants with bamout to show realigned reads.\n\n```\n gatk --java-options \"-Xmx4g\" HaplotypeCaller  \\\n   -R Homo_sapiens_assembly38.fasta \\\n   -I input.bam \\\n   -O output.vcf.gz \\\n   -bamout bamout.bam\n```\n\n### Changes Introduced by Seven Bridges\n\n* **Include intervals** (`--intervals`) option is divided into **Include intervals file** and **Include intervals string** options.\n* **Exclude intervals** (`--exclude-intervals`) option is divided into **Exclude intervals file** and **Exclude intervals string** options.\n* **VCF output** will be prefixed using the **Output name prefix** parameter. If this value is not set, the output name will be generated based on the **Sample ID** metadata value from **Input alignments**. If the **Sample ID** value is not set, the name will be inherited from the **Input alignments** file name. In case there are multiple files on the **Input alignments** input, the files will be sorted by name and output file name will be generated based on the first file in the sorted file list, following the rules defined in the previous case. \n* The user can specify the output file format using the **Output VCF extension** argument. Otherwise, the output will be in the compressed VCF file format.\n* The following parameters were excluded from the tool wrapper: `--arguments_file`, `--cloud-index-prefetch-buffer`, `--cloud-prefetch-buffer`, `--gatk-config-file`, `--gcs-max-retries`, `--gcs-project-for-requester-pays`, `--help`, `--max-variants-per-shard`, `--QUIET`, `--read-index`, `--recover-dangling-heads` (deprecated), `--showHidden`, `--tmp-dir`, `--use-jdk-deflater`, `--use-jdk-inflater`,  `--use-new-qual-calculator` (deprecated), `--verbosity`, `--version`.\n\n### Common Issues and Important Notes\n\n*  **Memory per job [MB]** (`mem_per_job_haplotype_caller`) input allows a user to set the desired memory requirement when running a tool or adding it to a workflow. This input should be defined in MB. It is propagated to the Memory requirements part and “-Xmx” parameter of the tool. The default value is 4000 MB.\n* **Memory overhead per job [MB]** (`mem_overhead_per_job_haplotype_caller`) input allows a user to set the desired overhead memory when running a tool or adding it to a workflow. This input should be defined in MB. This amount will be added to the **Memory per job [MB]** in the Memory requirements section but it will not be added to the “-Xmx” parameter. The default value is 100 MB. \n* Note: GATK tools that take in mapped read data expect a BAM file as the primary format [2]. More on GATK requirements for mapped sequence data formats can be found [here](https://gatk.broadinstitute.org/hc/en-us/articles/360035890791-SAM-or-BAM-or-CRAM-Mapped-sequence-data-formats).\n* Note: **Alleles**, **Comparison VCF**, **dbSNP**, **Input alignments**, **Population callset** should have corresponding index files in the same folder. \n* Note: **Reference** FASTA file should have corresponding .fai (FASTA index) and .dict (FASTA dictionary) files in the same folder. \n* Note: When working with PCR-free data, be sure to set **PCR indel model** (`--pcr_indel_model`) to NONE [1].\n* Note: When running **Emit ref confidence** ( `--emit-ref-confidence`) in GVCF or in BP_RESOLUTION mode, the confidence threshold is automatically set to 0. This cannot be overridden by the command line. The threshold can be set manually to the desired level when using **GenotypeGVCFs** [1].\n* Note: It is recommended to use a list of intervals to speed up the analysis. See [this document](https://gatk.broadinstitute.org/hc/en-us/articles/360035889551?id=4133) for details [1].\n* Note: **HaplotypeCaller** is able to handle many non-diploid use cases; the desired ploidy can be specified using the `-ploidy` argument. Note however that very high ploidies (such as are encountered in large pooled experiments) may cause performance challenges including excessive slowness [1].\n* Note: These **Read Filters** (`--read-filter`) are automatically applied to the data by the Engine before processing by **HaplotypeCaller** [1]: **NotSecondaryAlignmentReadFilter**, **GoodCigarReadFilter**, **NonZeroReferenceLengthAlignmentReadFilter**, **PassesVendorQualityCheckReadFilter**, **MappedReadFilter**, **MappingQualityAvailableReadFilter**, **NotDuplicateReadFilter**, **MappingQualityReadFilter**, **WellformedReadFilter**.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"LibraryReadFilter\", the **Library** (`--library`) option must be set to some value.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"PlatformReadFilter\", the **Platform filter name** (`--platform-filter-name`) option must be set to some value.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"PlatformUnitReadFilter\", the **Black listed lanes** (`--black-listed-lanes`) option must be set to some value. \n* Note: If the **Read filter** (`--read-filter`) option is set to \"ReadGroupBlackListReadFilter\", the **Read group black list** (`--read-group-black-list`) option must be set to some value.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"ReadGroupReadFilter\", the **Keep read group** (`--keep-read-group`) option must be set to some value.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"ReadLengthReadFilter\", the **Max read length** (`--max-read-length`) option must be set to some value.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"ReadNameReadFilter\", the **Read name** (`--read-name`) option must be set to some value.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"ReadStrandFilter\", the **Keep reverse strand only** (`--keep-reverse-strand-only`) option must be set to some value.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"SampleReadFilter\", the **Sample** (`--sample`) option must be set to some value.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"IntervalOverlapReadFilter\", the **Keep intervals** (`--keep-intervals`) option must be set to some value.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"JexlExpressionReadTagValueFilter\", the **Read filter expression** (`--read-filter-expression`) option must be set to some value.\n* Note: If the **Read filter** (`--read-filter`) option is set to \"ReadTagValueFilter\", the **Read filter tag** (`--read-filter-tag`) option must be set to some value.\n* Note: The following options are valid only if the appropriate **Read filter** (`--read-filter`) is specified: **Ambig filter bases** (`--ambig-filter-bases`), **Ambig filter frac** (`--ambig-filter-frac`), **Max fragment length** (`--max-fragment-length`), **Min fragment length** (`--min-fragment-length`), **Keep intervals** (`--keep-intervals`), **Library** (`--library`), **Maximum mapping quality** (`--maximum-mapping-quality`), **Minimum mapping quality** (`--minimum-mapping-quality`),  **Mate too distant length** (`--mate-too-distant-length`), **Do not require soft clips** (`--dont-require-soft-clips-both-ends`), **Filter too short** (`--filter-too-short`), **Platform filter name** (`--platform-filter-name`), **Black listed lanes** (`--black-listed-lanes`), **Read group black list** (`--read-group-black-list`), **Keep read group** (`--keep-read-group`), **Max read length** (`--max-read-length`), **Min read length** (`--min-read-length`), **Read name** (`--read-name`), **Keep reverse strand only** (`--keep-reverse-strand-only`), **Sample** (`--sample`), **Invert soft clip ratio filter** (`--invert-soft-clip-ratio-filter`), **Soft clipped leading trailing ratio** (`--soft-clipped-leading-trailing-ratio`), **Soft clipped ratio threshold** (`--soft-clipped-ratio-threshold`), **Maximum number of clipped bases on either end of a given read** (`--max-clipped-bases`), **Read filter max hmer** (`--read-filter-max-hmer`), **Read filter tag** (`--read-filter-tag`), **Read filter tag compare** (`--read-filter-tag-comp`), **Read filter tag operator** (`--read-filter-tag-op`), **Read filter expression** (`--read-filter-expression`).  See the description of each parameter for information on the associated **Read filter**.\n* Note: The following options are valid only if the appropriate **Annotation** (`--annotation`) is specified: **RMSMappingQuality** (`--allow-old-rms-mapping-quality-annotation-data`), **AllelePseudoDepth** (`--dirichlet-keep-prior-in-count`), **AllelePseudoDepth** (`--dirichlet-prior-pseudo-count`), **AllelePseudoDepth** (`--pseudo-count-weight-decay-rate`), **AssemblyComplexity** (`--assembly-complexity-reference-mode`).  See the description of each parameter for information on the associated **Annotation**.\n* Note: Allele-specific annotations are not yet supported in the VCF mode.\n\n### Limitations\n\nThe wrapper has not been tested for the SAM file type on the **Input alignments** input port.\n\n### Performance Benchmarking\n\nBelow is a table describing the runtimes and task costs for a couple of samples with different file sizes.\n\n| Experiment type |  Input size | Paired-end | Duration | Cost (on-demand) | AWS instance type |\n|:--------------:|:------------:|:--------:|:-------:|:---------:|:----------:|:------:|:------:|:------:|\n|     RNA-Seq     | 2.5 GB |     Yes    |   56min   | 0.50$ | c4.2xlarge |\n|     RNA-Seq     | 7.5 GB |     Yes    |   1h56min   | 1.05$ | c4.2xlarge |\n|     RNA-Seq     | 12.4 GB |     Yes    |  2h58min  | 1.61$ | c4.2xlarge |\n|     RNA-Seq     | 24.5 GB |     Yes    |  5h37min  | 3.04$ | c4.2xlarge |\n\n*Cost can be significantly reduced by using **spot instances**. Visit the [knowledge center](https://docs.sevenbridges.com/docs/about-spot-instances) for more details.*\n\n###Portability\n\n**GATK HaplotypeCaller** was tested with cwltool version 3.0.20201203173111. The `output_prefix`, `create_output_variant_md5`, `mem_per_job`, `cpu_per_job`, `output_extension`, `add_output_vcf_command_line`, `include_intervals_file`, `in_alignments`, and `in_reference`, were provided in the job.yaml file and used for testing.\n\n\n### References\n[1] [GATK HaplotypeCaller](https://gatk.broadinstitute.org/hc/en-us/articles/13832687299739-HaplotypeCaller)\n\n[2] [GATK Mapped sequence data formats](https://gatk.broadinstitute.org/hc/en-us/articles/360035890791-SAM-or-BAM-or-CRAM-Mapped-sequence-data-formats)",
                "label": "GATK HaplotypeCaller",
                "arguments": [
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 0,
                        "valueFrom": "${\n    if (inputs.mem_per_job_haplotype_caller) {\n        return '\\\"-Xmx'.concat(inputs.mem_per_job_haplotype_caller, 'M') + '\\\"';\n    } else {\n        return '\\\"-Xmx4000M\\\"';\n    }\n}"
                    },
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 1,
                        "valueFrom": "HaplotypeCaller"
                    },
                    {
                        "prefix": "--output",
                        "shellQuote": false,
                        "position": 2,
                        "valueFrom": "${\n  var output_name =  \"\";\n  var count = \"\";\n  var input_files = [].concat(inputs.in_alignments);\n  var tmp_ext = inputs.output_extension ? inputs.output_extension : \"vcf.gz\";\n  \n  if(inputs.emit_ref_confidence == 'GVCF' || inputs.emit_ref_confidence == 'BP_RESOLUTION'){\n      var output_ext = 'g.' + tmp_ext;\n  } \n  else {\n      var output_ext = tmp_ext;\n      \n  }\n  \n  var extension = \".\" + output_ext;\n    \n  if (input_files.length > 1){\n        count = \".\".concat(input_files.length);\n  }\n  if (inputs.output_prefix){\n    output_name = inputs.output_prefix;\n  } else {\n    if (input_files.length > 1){\n        input_files.sort(function(file1, file2) {\n            var file1_name = file1.basename.toUpperCase();\n            var file2_name = file2.basename.toUpperCase();\n            if (file1_name < file2_name) {\n                return -1;\n            }\n            if (file1_name > file2_name) {\n                return 1;\n            }\n            return 0;\n        });\n    }\n      \n    var sample_id = \"\";\n    var in_first_file = input_files[0];\n    \n    if (in_first_file.metadata && in_first_file.metadata.sample_id){\n      sample_id = in_first_file.metadata.sample_id;\n      }\n    if (sample_id){\n      output_name = sample_id;\n    } else {\n      output_name = in_first_file.nameroot;\n    }\n  }\n  \n  // ensure there are no special characters in output_name\n  output_name = output_name.replace(/[^a-zA-Z0-9\\_\\-\\.]/g, \"\");\n  \n  return output_name + count + extension;\n}"
                    }
                ],
                "requirements": [
                    {
                        "class": "ShellCommandRequirement"
                    },
                    {
                        "class": "ResourceRequirement",
                        "ramMin": "${\n  var memory = 4000;\n  \n  if(inputs.mem_per_job_haplotype_caller) {\n  \t memory = inputs.mem_per_job_haplotype_caller;\n  }\n  if(inputs.mem_overhead_per_job_haplotype_caller) {\n\tmemory += inputs.mem_overhead_per_job_haplotype_caller;\n  }\n  else {\n      memory += 100;\n  }\n  return memory;\n}",
                        "coresMin": "${\n    return inputs.cpu_per_job_haplotype_caller ? inputs.cpu_per_job_haplotype_caller : 1;\n}"
                    },
                    {
                        "class": "DockerRequirement",
                        "dockerPull": "images.sbgenomics.com/nevenam/gatk-4-4-0-0:0"
                    },
                    {
                        "class": "InitialWorkDirRequirement",
                        "listing": []
                    },
                    {
                        "class": "InlineJavascriptRequirement",
                        "expressionLib": [
                            "\nvar setMetadata = function(file, metadata) {\n    if (!('metadata' in file)) {\n        file['metadata'] = {}\n    }\n    for (var key in metadata) {\n        file['metadata'][key] = metadata[key];\n    }\n    return file\n};\nvar inheritMetadata = function(o1, o2) {\n    var commonMetadata = {};\n    if (!o2) {\n        return o1;\n    };\n    if (!Array.isArray(o2)) {\n        o2 = [o2]\n    }\n    for (var i = 0; i < o2.length; i++) {\n        var example = o2[i]['metadata'];\n        for (var key in example) {\n            if (i == 0)\n                commonMetadata[key] = example[key];\n            else {\n                if (!(commonMetadata[key] == example[key])) {\n                    delete commonMetadata[key]\n                }\n            }\n        }\n        for (var key in commonMetadata) {\n            if (!(key in example)) {\n                delete commonMetadata[key]\n            }\n        }\n    }\n    if (!Array.isArray(o1)) {\n        o1 = setMetadata(o1, commonMetadata)\n        if (o1.secondaryFiles) {\n            o1.secondaryFiles = inheritMetadata(o1.secondaryFiles, o2)\n        }\n    } else {\n        for (var i = 0; i < o1.length; i++) {\n            o1[i] = setMetadata(o1[i], commonMetadata)\n            if (o1[i].secondaryFiles) {\n                o1[i].secondaryFiles = inheritMetadata(o1[i].secondaryFiles, o2)\n            }\n        }\n    }\n    return o1;\n};"
                        ]
                    }
                ],
                "sbg:categories": [
                    "Variant Calling",
                    "CWLtool Tested"
                ],
                "sbg:image_url": null,
                "sbg:license": "Apache License 2.0",
                "sbg:links": [
                    {
                        "id": "https://gatk.broadinstitute.org/hc/en-us",
                        "label": "Homepage"
                    },
                    {
                        "id": "https://github.com/broadinstitute/gatk",
                        "label": "Source Code"
                    },
                    {
                        "id": "https://github.com/broadinstitute/gatk/releases/tag/4.4.0.0",
                        "label": "Download"
                    },
                    {
                        "id": "https://www.biorxiv.org/content/10.1101/201178v3",
                        "label": "Publication"
                    },
                    {
                        "id": "https://gatk.broadinstitute.org/hc/en-us/articles/13832687299739-HaplotypeCaller",
                        "label": "Documentation"
                    }
                ],
                "sbg:projectName": "SBG Public Data",
                "sbg:revisionsInfo": [
                    {
                        "sbg:revision": 0,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1681138842,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 1,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1681138842,
                        "sbg:revisionNotes": "initial"
                    },
                    {
                        "sbg:revision": 2,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1681138842,
                        "sbg:revisionNotes": "added Limitations"
                    },
                    {
                        "sbg:revision": 3,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1681138842,
                        "sbg:revisionNotes": "changes after TL review"
                    }
                ],
                "sbg:toolAuthor": "Broad Institute",
                "sbg:toolkit": "GATK",
                "sbg:toolkitVersion": "4.4.0.0",
                "sbg:expand_workflow": false,
                "sbg:appVersion": [
                    "v1.2"
                ],
                "sbg:id": "admin/sbg-public-data/gatk-haplotypecaller-4-4-0-0/3",
                "sbg:revision": 3,
                "sbg:revisionNotes": "changes after TL review",
                "sbg:modifiedOn": 1681138842,
                "sbg:modifiedBy": "admin",
                "sbg:createdOn": 1681138842,
                "sbg:createdBy": "admin",
                "sbg:project": "admin/sbg-public-data",
                "sbg:sbgMaintained": false,
                "sbg:validationErrors": [],
                "sbg:contributors": [
                    "admin"
                ],
                "sbg:latestRevision": 3,
                "sbg:publisher": "sbg",
                "sbg:content_hash": "a885c09019f657aa765bc0040aa7ea0582f1805d5a83356734ca49bfb3de9e3e3",
                "sbg:workflowLanguage": "CWL"
            },
            "label": "GATK HaplotypeCaller",
            "sbg:x": 1820.897705078125,
            "sbg:y": -94.4215087890625
        },
        {
            "id": "sambamba_sort_1_0_1_cwl1_2",
            "in": [
                {
                    "id": "in_alignments",
                    "source": "bwa_mem_bundle_0_7_17/aligned_reads"
                }
            ],
            "out": [
                {
                    "id": "out_alignments"
                }
            ],
            "run": {
                "class": "CommandLineTool",
                "cwlVersion": "v1.2",
                "$namespaces": {
                    "sbg": "https://sevenbridges.com"
                },
                "id": "admin/sbg-public-data/sambamba-sort-1-0-1-cwl1-2/1",
                "baseCommand": [
                    "/opt/sambamba-1.0.1",
                    "sort"
                ],
                "inputs": [
                    {
                        "sbg:category": "Platform Options",
                        "sbg:toolDefaultValue": "1000",
                        "id": "mem_per_job",
                        "type": "int?",
                        "label": "Memory per job [MB]",
                        "doc": "Memory per job [MB]."
                    },
                    {
                        "sbg:category": "Platform Options",
                        "sbg:toolDefaultValue": "1",
                        "id": "cpu_per_job",
                        "type": "int?",
                        "label": "CPUs per job",
                        "doc": "CPUs per job."
                    },
                    {
                        "sbg:category": "File Inputs",
                        "id": "in_alignments",
                        "type": "File",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 20
                        },
                        "label": "Input alignments",
                        "doc": "BAM file to sort.",
                        "sbg:fileTypes": "BAM"
                    },
                    {
                        "sbg:altPrefix": "-t",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "Available CPUs",
                        "id": "n_threads",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--nthreads",
                            "shellQuote": false,
                            "position": 2
                        },
                        "label": "Number of threads",
                        "doc": "Number of threads to use."
                    },
                    {
                        "sbg:toolDefaultValue": "-1",
                        "sbg:category": "Config Inputs",
                        "sbg:altPrefix": "-l",
                        "id": "compression_level",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--compression-level",
                            "shellQuote": false,
                            "position": 3
                        },
                        "label": "Compression level",
                        "doc": "Level of compression for the sorted BAM file, (0 to 9)."
                    },
                    {
                        "sbg:altPrefix": "-p",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "show_progress",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--show-progress",
                            "shellQuote": false,
                            "position": 5
                        },
                        "label": "Show progress bar in STDERR",
                        "doc": "Show progress bar in STDERR."
                    },
                    {
                        "sbg:altPrefix": "-F",
                        "sbg:category": "Config Inputs",
                        "id": "filter",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--filter",
                            "shellQuote": false,
                            "position": 6
                        },
                        "label": "Filter for reads",
                        "doc": "Keep only reads that satisfy this filter."
                    },
                    {
                        "sbg:altPrefix": "-m",
                        "sbg:category": "Config Inputs",
                        "id": "memory_limit",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--memory-limit",
                            "shellQuote": false,
                            "position": 7
                        },
                        "label": "Memory limit",
                        "doc": "Approximate total memory limit for all threads (by default 2GB)."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:altPrefix": "-o",
                        "id": "prefix",
                        "type": "string?",
                        "label": "Output file name prefix",
                        "doc": "Output file name prefix."
                    },
                    {
                        "sbg:altPrefix": "-n",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "sort_by_name",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--sort-by-name",
                            "shellQuote": false,
                            "position": 9
                        },
                        "label": "Sort by name - lexicographical order",
                        "doc": "Sort by read name instead of coordinate (lexicographical order, -n). Default: False."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "sort_picard",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--sort-picard",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Sort by query name - Picard order",
                        "doc": "Sort by query name like in Picard. Default: False."
                    },
                    {
                        "sbg:altPrefix": "-N",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "natural_sort",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--natural-sort",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Natural sort - Samtools order",
                        "doc": "Sort by read name instead of coordinate ('natural' sort as in samtools). Default: False."
                    },
                    {
                        "sbg:altPrefix": "-M",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "match_mates",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--match-mates",
                            "shellQuote": false,
                            "position": 12
                        },
                        "label": "Match mates",
                        "doc": "Pull mates of the same alignment together when sorting by read name. This parameter should only be used together with --sort-by-name or --natural-sort."
                    },
                    {
                        "sbg:altPrefix": "-u",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "uncompressed_chunks",
                        "type": "boolean?",
                        "inputBinding": {
                            "prefix": "--uncompressed-chunks",
                            "shellQuote": false,
                            "position": 13
                        },
                        "label": "Write uncompressed chunks",
                        "doc": "Write sorted chunks as uncompressed BAM (default is writing with compression level 1), that might be faster in some cases but uses more disk space."
                    }
                ],
                "outputs": [
                    {
                        "id": "out_alignments",
                        "doc": "Sorted alignments.",
                        "label": "Sorted alignments",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "*.bam",
                            "outputEval": "$(inheritMetadata(self, inputs.in_alignments))"
                        },
                        "secondaryFiles": [
                            {
                                "pattern": ".bai",
                                "required": false
                            }
                        ],
                        "sbg:fileTypes": "BAM"
                    }
                ],
                "doc": "**Sambamba Sort** sorts alignments in BAM format [1,2].\n\n\n*A list of **all inputs and parameters** with corresponding descriptions can be found at the bottom of the page.*\n\n_**Please note that any cloud infrastructure costs resulting from app and pipeline executions, including the use of public apps, are the sole responsibility of you as a user. To avoid excessive costs, please read the app description carefully and set the app parameters and execution settings accordingly.**_\n\n\n### Common Use Cases\n\n**Sambamba Sort** can be used to sort BAM files (**Input alignments**). Coordinate and query-name (lexicographical `--sort-by-name`, Samtools `--natural-sort` and Picard `--sort-picard` corresponding to **Sort by name - lexicographical order**, **Natural sort - Samtools order** and **Sort by query name - Picard order** input parameters, respectively) sorting orders are supported. By default, the output will be coordinate-sorted.\n\n### Changes Introduced by Seven Bridges\n\n* The following input parameters were excluded from this wrapper: `--tmpdir` and `--help`.\n* If the **Output file name prefix** input parameter is not provided, the sorted BAM output file will be named based on the **Sample ID** metadata field of the **Input alignments** file, or, if this field is not populated, on the base name of this file.\n\n\n### Common Issues and Important Notes\n\n* **Input alignments** input is required.\n* If the output should be sorted by query name, only one of the **Sort by name - lexicographical order**, **Natural sort - Samtools order** and **Sort by query name - Picard order** input parameters should be specified, as these parameters are mutually exclusive.\n* **Match mates** (`--match-mates`) input parameter should only be used when query-name sorting with **Sort by name - lexicographical order** or **Natural sort - Samtools order** input parameters.\n\n### Performance Benchmarking\n\n| Experiment type  | Duration | Cost | Instance (AWS on-demand)|\n|-----------------------|-----------------|------------|-----------------|-------------|--------------|------------------|-------------|---------------|\n| WGS BAM (48 GB) - coordinate sort - 8 threads | 72 min | $0.48 + $0.17 | c4.2xlarge - 1024 GB EBS | \n| WGS BAM (48 GB) - coordinate sort - 32 threads | 24 min | $0.61 + $0.06 | c5.9xlarge - 1024 GB EBS | \n| WGS BAM (48 GB) - lexicographical sort - 8 threads |88 min | $0.58 + $0.20 | c4.2xlarge - 1024 GB EBS | \n| WGS BAM (48 GB) - Picard query name sort - 8 threads | 91 min | $0.60 + $0.21 | c4.2xlarge - 1024 GB EBS | \n| WGS BAM (48 GB) - natural (samtools) sort - 8 threads | 138 min | $0.92 + $0.32 | c4.2xlarge - 1024 GB EBS | \n\n*Cost can be significantly reduced by **spot instance** usage. Visit the [Knowledge Center](https://docs.sevenbridges.com/docs/about-spot-instances) for more details.*  \n\n### Portability\n\n**Sambamba Sort** was tested with cwltool version 3.1.20221018083734. The `in_alignments` input was provided in the job.yaml/job.json file and used for testing. \n\n\n### References\n\n[1] [Sambamba documentation](https://lomereiter.github.io/sambamba/docs/sambamba-view.html)\n\n[2] [Sambamba publication](https://academic.oup.com/bioinformatics/article/31/12/2032/214758)",
                "label": "Sambamba Sort",
                "arguments": [
                    {
                        "prefix": "--out",
                        "shellQuote": false,
                        "position": 8,
                        "valueFrom": "${\n    var pref = ''\n    var test = [].concat(inputs.in_alignments)[0]\n    \n    if (inputs.prefix)\n    {\n        pref = inputs.prefix.concat('.bam')\n    }\n    else if ((test.metadata) && (test.metadata['sample_id']))\n    {\n        pref = test.metadata['sample_id'].concat('.sorted.bam')\n    }\n    else\n    {\n        pref = test.nameroot.concat('.sorted.bam')\n    }\n    \n    return pref\n}"
                    }
                ],
                "requirements": [
                    {
                        "class": "ShellCommandRequirement"
                    },
                    {
                        "class": "ResourceRequirement",
                        "ramMin": "${\n    if (inputs.mem_per_job)\n    {\n        return inputs.mem_per_job\n    }\n    else\n    {\n        return 1000\n    }\n}",
                        "coresMin": "${\n    if (inputs.cpu_per_job)\n    {\n        return inputs.cpu_per_job\n    }\n    else if (inputs.n_threads)\n    {\n        return inputs.n_threads\n    }\n    else\n    {\n        return 1\n    }\n}"
                    },
                    {
                        "class": "DockerRequirement",
                        "dockerPull": "images.sbgenomics.com/jrandjelovic/sambamba-1-0-1:0"
                    },
                    {
                        "class": "InlineJavascriptRequirement",
                        "expressionLib": [
                            "\nvar setMetadata = function(file, metadata) {\n    if (!('metadata' in file)) {\n        file['metadata'] = {}\n    }\n    for (var key in metadata) {\n        file['metadata'][key] = metadata[key];\n    }\n    return file\n};\nvar inheritMetadata = function(o1, o2) {\n    var commonMetadata = {};\n    if (!o2) {\n        return o1;\n    };\n    if (!Array.isArray(o2)) {\n        o2 = [o2]\n    }\n    for (var i = 0; i < o2.length; i++) {\n        var example = o2[i]['metadata'];\n        for (var key in example) {\n            if (i == 0)\n                commonMetadata[key] = example[key];\n            else {\n                if (!(commonMetadata[key] == example[key])) {\n                    delete commonMetadata[key]\n                }\n            }\n        }\n        for (var key in commonMetadata) {\n            if (!(key in example)) {\n                delete commonMetadata[key]\n            }\n        }\n    }\n    if (!Array.isArray(o1)) {\n        o1 = setMetadata(o1, commonMetadata)\n        if (o1.secondaryFiles) {\n            o1.secondaryFiles = inheritMetadata(o1.secondaryFiles, o2)\n        }\n    } else {\n        for (var i = 0; i < o1.length; i++) {\n            o1[i] = setMetadata(o1[i], commonMetadata)\n            if (o1[i].secondaryFiles) {\n                o1[i].secondaryFiles = inheritMetadata(o1[i].secondaryFiles, o2)\n            }\n        }\n    }\n    return o1;\n};"
                        ]
                    }
                ],
                "sbg:projectName": "SBG Public Data",
                "sbg:revisionsInfo": [
                    {
                        "sbg:revision": 0,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1702904512,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 1,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1702904512,
                        "sbg:revisionNotes": "import from dev"
                    }
                ],
                "sbg:image_url": null,
                "sbg:toolkit": "Sambamba",
                "sbg:toolkitVersion": "1.0.1",
                "sbg:toolAuthor": "Artem Tarasov and Pjotr Prins",
                "sbg:license": "GNU GPL v2.0",
                "sbg:categories": [
                    "SAM/BAM Processing",
                    "CWLtool Tested"
                ],
                "sbg:links": [
                    {
                        "id": "https://lomereiter.github.io/sambamba/index.html",
                        "label": "Homepage"
                    },
                    {
                        "id": "https://github.com/biod/sambamba",
                        "label": "Source Code"
                    },
                    {
                        "id": "https://github.com/biod/sambamba/releases/tag/v1.0.1",
                        "label": "Download"
                    },
                    {
                        "id": "https://academic.oup.com/bioinformatics/article/31/12/2032/214758",
                        "label": "Publication"
                    },
                    {
                        "id": "https://lomereiter.github.io/sambamba/docs/sambamba-view.html",
                        "label": "Documentation"
                    }
                ],
                "sbg:expand_workflow": false,
                "sbg:appVersion": [
                    "v1.2"
                ],
                "sbg:id": "admin/sbg-public-data/sambamba-sort-1-0-1-cwl1-2/1",
                "sbg:revision": 1,
                "sbg:revisionNotes": "import from dev",
                "sbg:modifiedOn": 1702904512,
                "sbg:modifiedBy": "admin",
                "sbg:createdOn": 1702904512,
                "sbg:createdBy": "admin",
                "sbg:project": "admin/sbg-public-data",
                "sbg:sbgMaintained": false,
                "sbg:validationErrors": [],
                "sbg:contributors": [
                    "admin"
                ],
                "sbg:latestRevision": 1,
                "sbg:publisher": "sbg",
                "sbg:content_hash": "a0ef5eb082bfff9f6342170a334aadc3e4609fc1ce502a240a6202ec77b00f6ed",
                "sbg:workflowLanguage": "CWL"
            },
            "label": "Sambamba Sort",
            "sbg:x": 740.9340209960938,
            "sbg:y": 53.66666793823242
        },
        {
            "id": "picard_markduplicates_3_0_0_cwl1_2",
            "in": [
                {
                    "id": "in_alignments",
                    "source": [
                        "picard_mergesamfiles_1_140/merged_bam"
                    ]
                }
            ],
            "out": [
                {
                    "id": "metrics_file"
                },
                {
                    "id": "out_alignments"
                },
                {
                    "id": "out_md5_digest"
                }
            ],
            "run": {
                "class": "CommandLineTool",
                "cwlVersion": "v1.2",
                "$namespaces": {
                    "sbg": "https://sevenbridges.com"
                },
                "id": "admin/sbg-public-data/picard-markduplicates-3-0-0-cwl1-2/1",
                "baseCommand": [
                    "java"
                ],
                "inputs": [
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "<optimized capture of last three ':' separated fields as numeric values>",
                        "id": "read_name_regex",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--READ_NAME_REGEX",
                            "shellQuote": false,
                            "position": 6
                        },
                        "label": "Read name regex",
                        "doc": "MarkDuplicates can use the tile and cluster positions to estimate the rate of optical duplication in addition to the dominant source of duplication, PCR, to provide a more accurate estimation of library size. By default (with no READ_NAME_REGEX specified), MarkDuplicates will attempt to extract coordinates using a split on ':' (see Note below).  Set READ_NAME_REGEX to 'null' to disable optical duplicate detection. Note that without optical duplicate counts, library size estimation will be less accurate. If the read name does not follow a standard Illumina colon-separation convention, but does contain tile and x,y coordinates, a regular expression can be specified to extract three variables: tile/region, x coordinate and y coordinate from a read name. The regular expression must contain three capture groups for the three variables, in order. It must match the entire read name.   e.g. if field names were separated by semi-colon (';') this example regex could be specified      (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$ Note that if no READ_NAME_REGEX is specified, the read name is split on ':'. For 5 element names, the 3rd, 4th and 5th elements are assumed to be tile, x and y values. For 7 element names (CASAVA 1.8), the 5th, 6th, and 7th elements are assumed to be tile, x and y values. Default value: <optimized capture of last three ':' separated fields as numeric values>."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "0.25",
                        "id": "sorting_collections_size_ratio",
                        "type": "float?",
                        "inputBinding": {
                            "prefix": "--SORTING_COLLECTION_SIZE_RATIO",
                            "shellQuote": false,
                            "position": 7
                        },
                        "label": "Sorting collections size ratio",
                        "doc": "This number, plus the maximum RAM available to the JVM, determine the memory footprint used by some of the sorting collections. If you are running out of memory, try reducing this number. Default: 0.25."
                    },
                    {
                        "sbg:altPrefix": "-MAX_FILE_HANDLES",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "8000",
                        "id": "max_file_handles_for_read_ends_map",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--MAX_FILE_HANDLES_FOR_READ_ENDS_MAP",
                            "shellQuote": false,
                            "position": 8
                        },
                        "label": "Max file handles for read ends map",
                        "doc": "Maximum number of file handles to keep open when spilling read ends to disk. Set this number a little lower than the per-process maximum number of file that may be open. This number can be found by executing the 'ulimit -n' command on a Unix system. Default: 8000."
                    },
                    {
                        "sbg:altPrefix": "-AS",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "assume_sorted",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "assume_sorted"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--ASSUME_SORTED",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Assume sorted",
                        "doc": "If this parameter is set to true, it is assumed that the input file is coordinate sorted even if the header says otherwise.  DEPRECATED, use ASSUME_SORT_ORDER=coordinate instead. Default: false."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "remove_duplicates",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "remove_duplicates"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--REMOVE_DUPLICATES",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Remove duplicates",
                        "doc": "If true do not write duplicates to the output file instead of writing them with appropriate flags set. Default: false."
                    },
                    {
                        "sbg:altPrefix": "-CO",
                        "sbg:category": "Config Inputs",
                        "id": "comment",
                        "type": "string[]?",
                        "label": "Comments",
                        "doc": "Comment(s) to include in the output file's header. Default: null."
                    },
                    {
                        "sbg:altPrefix": "-PG_NAME",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "MarkDuplicates",
                        "id": "program_group_name",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--PROGRAM_GROUP_NAME",
                            "shellQuote": false,
                            "position": 13
                        },
                        "label": "Program group name",
                        "doc": "Value of program name (PN) tag of program group (PG) record to be created. Default: MarkDuplicates."
                    },
                    {
                        "sbg:altPrefix": "-PG_COMMAND",
                        "sbg:category": "Config Inputs",
                        "id": "program_group_command_line",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--PROGRAM_GROUP_COMMAND_LINE",
                            "shellQuote": false,
                            "position": 14
                        },
                        "label": "Program group command line",
                        "doc": "Value of command line (CL) tag of program group (PG) record to be created. If not supplied the command line will be detected automatically. Default: null."
                    },
                    {
                        "sbg:altPrefix": "-PG_VERSION",
                        "sbg:category": "Config Inputs",
                        "id": "program_group_ver",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--PROGRAM_GROUP_VERSION",
                            "shellQuote": false,
                            "position": 15
                        },
                        "label": "Program group version",
                        "doc": "Value of version number (VN) tag of program group (PG) record to be created. If not specified, the version will be detected automatically. Default: null."
                    },
                    {
                        "sbg:altPrefix": "-PG",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "MarkDuplicates",
                        "id": "program_record_id",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--PROGRAM_RECORD_ID",
                            "shellQuote": false,
                            "position": 16
                        },
                        "label": "Program record ID",
                        "doc": "The program record ID for the @PG record(s) created by this program. Set to null to disable PG record creation. This string may have a suffix appended to avoid collision with other program record IDs. Default: MarkDuplicates."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "INFO",
                        "id": "verbosity",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "ERROR",
                                    "WARNING",
                                    "INFO",
                                    "DEBUG"
                                ],
                                "name": "verbosity"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--VERBOSITY",
                            "shellQuote": false,
                            "position": 17
                        },
                        "label": "Verbosity of logging",
                        "doc": "Control verbosity of logging. Default: INFO."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "SAME AS INPUT",
                        "id": "output_type",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "BAM",
                                    "SAM",
                                    "SAME AS INPUT"
                                ],
                                "name": "output_type"
                            }
                        ],
                        "label": "Output format",
                        "doc": "Since Picard tools can output both SAM and BAM files, the users can choose the format of the output file."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "create_index",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "create_index"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--CREATE_INDEX",
                            "shellQuote": false,
                            "position": 18
                        },
                        "label": "Create index",
                        "doc": "This parameter indicates whether to create a BAM index when writing a coordinate-sorted BAM file. Default: false."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "STRICT",
                        "id": "validation_stringency",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "STRICT",
                                    "LENIENT",
                                    "SILENT"
                                ],
                                "name": "validation_stringency"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--VALIDATION_STRINGENCY",
                            "shellQuote": false,
                            "position": 20
                        },
                        "label": "Validation stringency",
                        "doc": "Validation stringency for all SAM files read by this program. Setting stringency to SILENT can improve performance when processing a BAM file in which variable-length data (read, qualities, tags) do not otherwise need to be decoded. Default: STRICT."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "5",
                        "id": "compression_level",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--COMPRESSION_LEVEL",
                            "shellQuote": false,
                            "position": 21
                        },
                        "label": "Compression level",
                        "doc": "Compression level for all compressed files created (e.g. BAM and VCF). Default: 5."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "500000",
                        "id": "max_records_in_ram",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--MAX_RECORDS_IN_RAM",
                            "shellQuote": false,
                            "position": 22
                        },
                        "label": "Maximum records in RAM",
                        "doc": "When writing files that need to be sorted, this parameter will specify the number of records stored in RAM before spilling to disk. Increasing this number reduces the number of file handles needed to sort a SAM file, and increases the amount of RAM needed. Default: 500000."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "100",
                        "id": "optical_duplicate_pixel_distance",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--OPTICAL_DUPLICATE_PIXEL_DISTANCE",
                            "shellQuote": false,
                            "position": 23
                        },
                        "label": "Optical duplicate pixel distance",
                        "doc": "The maximum offset between two duplicate clusters in order to consider them optical duplicates. The default is appropriate for unpatterned versions of the Illumina platform. For the patterned flowcell models, 2500 is more appropriate. For other platforms and models, users should experiment to find what works best. Default: 100."
                    },
                    {
                        "sbg:altPrefix": "-I",
                        "sbg:category": "File Inputs",
                        "id": "in_alignments",
                        "type": "File[]",
                        "label": "Input alignments",
                        "doc": "This parameter indicates one or more input SAM or BAM files to analyze.",
                        "sbg:fileTypes": "SAM, BAM"
                    },
                    {
                        "sbg:toolDefaultValue": "2048",
                        "sbg:category": "Platform Options",
                        "id": "mem_per_job",
                        "type": "int?",
                        "label": "Memory per job [MB]",
                        "doc": "Memory per job [MB]. Default: 2048."
                    },
                    {
                        "sbg:altPrefix": "-DS",
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "SUM_OF_BASE_QUALITIES",
                        "id": "duplicate_scoring_strategy",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "SUM_OF_BASE_QUALITIES",
                                    "TOTAL_MAPPED_REFERENCE_LENGTH",
                                    "RANDOM"
                                ],
                                "name": "duplicate_scoring_strategy"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--DUPLICATE_SCORING_STRATEGY",
                            "shellQuote": false,
                            "position": 26
                        },
                        "label": "Duplicate scoring strategy",
                        "doc": "This parameter indicates the scoring strategy for choosing the non-duplicate among candidates. Default: SUM_OF_BASE_QUALITIES."
                    },
                    {
                        "sbg:category": "Platform Options",
                        "sbg:toolDefaultValue": "128",
                        "id": "mem_overhead_per_job",
                        "type": "int?",
                        "label": "Memory overhead per job [MB]",
                        "doc": "It allows a user to set the desired overhead memory when running a tool or adding it to a workflow."
                    },
                    {
                        "sbg:category": "Platform Options",
                        "sbg:toolDefaultValue": "1",
                        "id": "cpu_per_job",
                        "type": "int?",
                        "label": "CPUs per job",
                        "doc": "CPUs per job. Default: 1."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "id": "barcode_tag",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--BARCODE_TAG",
                            "shellQuote": false,
                            "position": 27
                        },
                        "label": "Barcode SAM tag",
                        "doc": "Barcode SAM tag (ex. BC for 10X Genomics) Default: null."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "null",
                        "id": "read_one_barcode_tag",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--READ_ONE_BARCODE_TAG",
                            "shellQuote": false,
                            "position": 28
                        },
                        "label": "Read one barcode SAM tag",
                        "doc": "Read one barcode SAM tag (ex. BX for 10X Genomics) Default: null."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "null",
                        "id": "read_two_barcode_tag",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--READ_TWO_BARCODE_TAG",
                            "shellQuote": false,
                            "position": 29
                        },
                        "label": "Read two barcode SAM tag",
                        "doc": "Read two barcode SAM tag (ex. BX for 10X Genomics) Default: null."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "tag_duplicate_set_members",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "false",
                                    "true"
                                ],
                                "name": "tag_duplicate_set_members"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--TAG_DUPLICATE_SET_MEMBERS",
                            "shellQuote": false,
                            "position": 30
                        },
                        "label": "Tag duplicate set members",
                        "doc": "If a read appears in a duplicate set, add two tags. The first tag, DUPLICATE_SET_SIZE_TAG (DS), indicates the size of the duplicate set. The smallest possible DS value is 2 which occurs when two reads map to the same portion of the reference only one of which is marked as duplicate. The second tag, DUPLICATE_SET_INDEX_TAG (DI), represents a unique identifier for the duplicate set to which the record belongs. This identifier is the index-in-file of the representative read that was selected out of the duplicate set. Default: false."
                    },
                    {
                        "sbg:category": "Config inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "remove_sequencing_duplicates",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "false",
                                    "true"
                                ],
                                "name": "remove_sequencing_duplicates"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--REMOVE_SEQUENCING_DUPLICATES",
                            "shellQuote": false,
                            "position": 31
                        },
                        "label": "Remove sequencing duplicates",
                        "doc": "If true remove 'optical' duplicates and other duplicates that appear to have arisen from the sequencing process instead of the library preparation process, even if REMOVE_DUPLICATES is false. If REMOVE_DUPLICATES is true, all duplicates are removed and this option is ignored. Default: false."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "DontTag",
                        "id": "tagging_policy",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "DontTag",
                                    "OpticalOnly",
                                    "All"
                                ],
                                "name": "tagging_policy"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--TAGGING_POLICY",
                            "shellQuote": false,
                            "position": 32
                        },
                        "label": "Tagging policy",
                        "doc": "Determines how duplicate types are recorded in the DT optional attribute. Default: DontTag."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "null",
                        "sbg:altPrefix": "-ASO",
                        "id": "assume_sort_order",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "unsorted",
                                    "queryname",
                                    "coordinate",
                                    "duplicate",
                                    "unknown"
                                ],
                                "name": "assume_sort_order"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--ASSUME_SORT_ORDER",
                            "shellQuote": false,
                            "position": 33
                        },
                        "label": "Assume sort order",
                        "doc": "If not null, assume that the input file has this order even if the header says otherwise. Default: null. Cannot be used in conjunction with the option ASSUME_SORTED (AS)."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "id": "prefix",
                        "type": "string?",
                        "label": "Basename for output files",
                        "doc": "Basename for the output files that are to be written."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "true",
                        "id": "add_pg_tag_to_reads",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "add_pg_tag_to_reads"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--ADD_PG_TAG_TO_READS",
                            "shellQuote": false,
                            "position": 10
                        },
                        "label": "Add PG tag to reads",
                        "doc": "Add PG tag to each read in a SAM or BAM  Default: true."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "true",
                        "id": "clear_dt",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "clear_dt"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--CLEAR_DT",
                            "shellQuote": false,
                            "position": 11
                        },
                        "label": "Clear DT tag",
                        "doc": "Clear DT tag from input SAM records. Should be set to false if input SAM doesn't have this tag.  Default: true."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "create_md5_file",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "create_md5_file"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--CREATE_MD5_FILE",
                            "shellQuote": false,
                            "position": 12
                        },
                        "label": "Create MD5 digest file",
                        "doc": "Whether to create an MD5 digest for any BAM files created. Default: false."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "duplex_umi",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "duplex_umi"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--DUPLEX_UMI",
                            "shellQuote": false,
                            "position": 13
                        },
                        "label": "Treat UMIs as duplex stranded",
                        "doc": "Treat UMIs as being duplex stranded.  This option requires that the UMI consist of two equal length strings that are separated by a hyphen (e.g. 'ATC-GTC'). Reads are considered duplicates if, in addition to standard definition, have identical normalized UMIs.  A UMI from the 'bottom' strand is normalized by swapping its content around the hyphen (eg. ATC-GTC becomes GTC-ATC).  A UMI from the 'top' strand is already normalized as it is. Both reads from a read pair considered top strand if the read 1 unclipped 5' coordinate is less than the read 2 unclipped 5' coordinate. All chimeric reads and read fragments are treated as having come from the top strand. With this option is it required that the BARCODE_TAG hold non-normalized UMIs. Default: false."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "300000",
                        "id": "max_optical_duplicate_set_size",
                        "type": "long?",
                        "inputBinding": {
                            "prefix": "--MAX_OPTICAL_DUPLICATE_SET_SIZE",
                            "shellQuote": false,
                            "position": 14
                        },
                        "label": "Maximum optical duplicate set size",
                        "doc": "This number is the maximum size of a set of duplicate reads for which we will attempt to determine which are optical duplicates. Please be aware that if you raise this value too high and do encounter a very large set of duplicate reads, it will severely affect the runtime of this tool.  To completely disable this check, set the value to -1. Default: 300000."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "id": "molecular_identifier_tag",
                        "type": "string?",
                        "inputBinding": {
                            "prefix": "--MOLECULAR_IDENTIFIER_TAG",
                            "shellQuote": false,
                            "position": 14
                        },
                        "label": "Molecular identifier tag",
                        "doc": "SAM tag to uniquely identify the molecule from which a read was derived.  Use of this option requires that the BARCODE_TAG option be set to a non null value. Default: null."
                    },
                    {
                        "sbg:altPrefix": "-R",
                        "sbg:category": "File Inputs",
                        "id": "in_reference",
                        "type": "File?",
                        "inputBinding": {
                            "prefix": "--REFERENCE_SEQUENCE",
                            "shellQuote": false,
                            "position": 15
                        },
                        "label": "Reference sequence",
                        "doc": "Reference sequence file.",
                        "sbg:fileTypes": "FA, FASTA, FA.GZ, FASTA.GZ",
                        "secondaryFiles": [
                            {
                                "pattern": ".fai",
                                "required": false
                            },
                            {
                                "pattern": "^.dict",
                                "required": false
                            }
                        ]
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "15",
                        "id": "flow_effective_quality_threshold",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--FLOW_EFFECTIVE_QUALITY_THRESHOLD",
                            "shellQuote": false,
                            "position": 16
                        },
                        "label": "Flow effective quality threshold",
                        "doc": "Threshold for considering a quality value high enough to be included when calculating FLOW_QUALITY_SUM_STRATEGY calculation. Default: 15."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "flow_mode",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "flow_mode"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--FLOW_MODE",
                            "shellQuote": false,
                            "position": 17
                        },
                        "label": "Flow mode",
                        "doc": "Enable parameters and behavior specific to flow based reads.  Default: false."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "flow_q_is_known_end",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "flow_q_is_known_end"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--FLOW_Q_IS_KNOWN_END",
                            "shellQuote": false,
                            "position": 18
                        },
                        "label": "Flow quality is known end",
                        "doc": "Treat position of read trimming based on quality as the known end (relevant for flow based reads). Default false - if the read is trimmed on quality its end is not defined and the read is duplicate of any read starting at the same place. Default: false."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "flow_quality_sum_strategy",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "flow_quality_sum_strategy"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--FLOW_QUALITY_SUM_STRATEGY",
                            "shellQuote": false,
                            "position": 19
                        },
                        "label": "Flow quality summing strategy",
                        "doc": "Use specific quality summing strategy for flow based reads. The strategy ensures that the same (and correct) quality value is used for all bases of the same homopolymer. Default: false."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "0",
                        "id": "flow_skip_first_n_flows",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--FLOW_SKIP_FIRST_N_FLOWS",
                            "shellQuote": false,
                            "position": 20
                        },
                        "label": "Flow skip first N flows",
                        "doc": "Skip first N flows, starting from the read's start, when considering duplicates. Useful for flow based reads where sometimes there is noise in the first flows (for this argument, \"read start\" means 5' end). Default: 0."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "0",
                        "id": "unpaired_end_uncertainty",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "--UNPAIRED_END_UNCERTAINTY",
                            "shellQuote": false,
                            "position": 21
                        },
                        "label": "Unpaired end uncertainty",
                        "doc": "Maximal difference of the read end position that counted as equal. Useful for flow based reads where the end position might vary due to sequencing errors. (for this argument, \"read end\" means 3' end). Default: 0."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "use_end_in_unpaired_reads",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "use_end_in_unpaired_reads"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--USE_END_IN_UNPAIRED_READS",
                            "shellQuote": false,
                            "position": 21
                        },
                        "label": "Use end in unpaired reads",
                        "doc": "Make the end location of single end read be significant when considering duplicates, in addition to the start location, which is always significant (i.e. require single-ended reads to start andend on the same position to be considered duplicate) (for this argument, \"read end\" means 3' end). Default: false."
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "false",
                        "id": "use_unpaired_clipped_end",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "use_unpaired_clipped_end"
                            }
                        ],
                        "inputBinding": {
                            "prefix": "--USE_UNPAIRED_CLIPPED_END",
                            "shellQuote": false,
                            "position": 22
                        },
                        "label": "Use unpaired clipped end",
                        "doc": "Use position of the clipping as the end position, when considering duplicates (or use the unclipped end position) (for this argument, \"read end\" means 3' end). Default: false."
                    }
                ],
                "outputs": [
                    {
                        "id": "metrics_file",
                        "doc": "File to which the duplication metrics will be written.",
                        "label": "Metrics file",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "*.metrics",
                            "outputEval": "$(inheritMetadata(self, inputs.in_alignments))"
                        },
                        "sbg:fileTypes": "METRICS"
                    },
                    {
                        "id": "out_alignments",
                        "doc": "The output file to which marked records will be written.",
                        "label": "Deduped alignments file",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "*.deduped.?am",
                            "outputEval": "$(inheritMetadata(self, inputs.in_alignments))"
                        },
                        "secondaryFiles": [
                            {
                                "pattern": "^.bai",
                                "required": false
                            },
                            {
                                "pattern": ".bai",
                                "required": false
                            }
                        ],
                        "sbg:fileTypes": "BAM, SAM"
                    },
                    {
                        "id": "out_md5_digest",
                        "doc": "MD5 digest file.",
                        "label": "MD5 digest file",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "*.md5",
                            "outputEval": "$(inheritMetadata(self, inputs.in_alignments))"
                        },
                        "sbg:fileTypes": "MD5"
                    }
                ],
                "doc": "**Picard MarkDuplicates** marks duplicate reads in alignment files [1].\n\n*A list of **all inputs and parameters** with corresponding descriptions can be found at the bottom of the page.*\n\n_**Please note that any cloud infrastructure costs resulting from app and pipeline executions, including the use of public apps, are the sole responsibility of you as a user. To avoid excessive costs, please read the app description carefully and set the app parameters and execution settings accordingly.**_\n\n### Common Use Cases\n\n**Picard MarkDuplicates** can be used to identify duplicate reads in a SAM or BAM file [1]. \n\n\n### Changes Introduced by Seven Bridges\n\n* Parameters `--showHidden`, `--arguments_file`, `--help`, `--MAX_SEQUENCES_FOR_DISK_READ_ENDS_MAP` (obsolete), `--QUIET`, `--TMP_DIR`, `--USE_JDK_DEFLATER`, `--USE_JDK_INFLATER` and `--version` were omitted from the wrapper.\n* Outputs (`--METRICS_FILE` and `--OUTPUT`) are named based on the **Output file name prefix** input parameter. If a value for it is not provided, the **Sample ID** metadata field value of **Input alignments** is used if it exists. Otherwise, the base name of the provided **Input alignments** inputs is used to name the outputs.\n* The **Output format** input parameter was added to allow the users to select the format of the created output file.\n \n### Common Issues and Important Notes\n\n* **Input alignments** input is required.\n* If the **Input alignments** file is coordinate-sorted, supplementary/secondary alignments and unmapped mates of mapped reads are not marked as duplicates, whereas these reads are included in the duplication test if the input is query-grouped [1].\n* Optical duplicate detection can be skipped by setting the **Read name regex** (`--READ_NAME_REGEX`) input to `null`.\n* The default value of **Optical duplicate pixel distance** input parameter (100) is appropriate for unpatterned Illumina platforms; however, for patterned flowcell models 2500 is more appropriate [1].\n\n### Performance Benchmarking\n\n| Experiment type  | Duration | Cost | Instance (AWS on-demand)|\n|---------------------------|------------------------|-----------------------|--------------------------------|\n| WGS NA12878 BAM file (48.4 GB) | 233 mins | $1.55 + $0.54 | c4.2xlarge - 1024 GB EBS | \n\n*Cost can be significantly reduced by **spot instance** usage. Visit the [Knowledge Center](https://docs.sevenbridges.com/docs/about-spot-instances) for more details.*  \n\n### Portability\n\n**Picard MarkDuplicates** was tested with cwltool version 3.1.20221018083734. The `in_alignments` input was provided in the job.yaml/job.json file and used for testing.\n\n### References\n\n[1] [Picard MarkDuplicates documentation](https://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates)",
                "label": "Picard MarkDuplicates",
                "arguments": [
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 0,
                        "valueFrom": "${\n    if (inputs.mem_per_job) {\n        return '-Xmx'.concat(inputs.mem_per_job, 'M')\n    }\n    return '-Xmx2048M'\n}"
                    },
                    {
                        "shellQuote": false,
                        "position": 1,
                        "valueFrom": "-jar"
                    },
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 2,
                        "valueFrom": "/opt/picard-3.0.0/picard.jar"
                    },
                    {
                        "shellQuote": false,
                        "position": 3,
                        "valueFrom": "MarkDuplicates"
                    },
                    {
                        "prefix": "--METRICS_FILE",
                        "shellQuote": false,
                        "position": 4,
                        "valueFrom": "${\n    var files = [].concat(inputs.in_alignments);\n    \n    if(inputs.prefix)\n    {   \n        if(files.length > 1){\n            return inputs.prefix +'.'+ (files.length).toString().concat('.metrics');\n        }\n        else{\n            return inputs.prefix.concat('.metrics');\n        }\n    }\n    else{\n        var meta =[];\n        for(var i = 0;i<files.length;i++){\n            if ((files[i].metadata) && (files[i].metadata['sample_id']))\n            {\n                meta.push(files[i].metadata['sample_id']);\n            }\n        }\n\n        if(meta.length!=0){\n            meta.sort();\n            var samplename=meta[0];\n            if (meta.length > 1){\n                var str = '.';\n                str+=(meta.length).toString();\n                samplename+=str;\n            }\n            return samplename.concat('.metrics');\n\n        }\n        else{\n            files.sort()\n            var filename = files[0].basename;\n            var primename = filename.split('.sam')[0].split('.bam')[0];\n            if (files.length > 1){\n                var str = '.' + (files.length).toString();\n                primename+=str;\n            }\n            return primename.concat('.metrics');\n        }\n    }\n}"
                    },
                    {
                        "prefix": "--OUTPUT",
                        "shellQuote": false,
                        "position": 5,
                        "valueFrom": "${\n    var files = [].concat(inputs.in_alignments);\n    var ext = files[0].nameext;\n    if(inputs.prefix)\n    {   \n        if(files.length > 1){\n            return inputs.prefix +'.'+ (files.length).toString().concat('.deduped') + ext;\n        }\n        else{\n            return inputs.prefix.concat('.deduped') + ext;\n        }\n    }\n    else{\n        \n        var meta =[];\n        for(var i = 0;i<files.length;i++){\n            if ((files[i].metadata) && (files[i].metadata['sample_id']))\n            {\n                meta.push(files[i].metadata['sample_id']);\n            }\n        }\n\n        if(meta.length!=0){\n            meta.sort();\n            var samplename=meta[0];\n            if (meta.length > 1){\n                var str = '.';\n                str+=(meta.length).toString();\n                samplename+=str;\n            }\n                samplename=samplename.concat('.deduped');\n            \n                return samplename+=ext;\n\n        }\n        else{\n            files.sort()\n            var filename = files[0].basename;\n            var primename = filename.split('.bam')[0].split('.sam')[0];\n            if (files.length > 1){\n            var str = '.' + (files.length).toString();\n            primename+=str;\n            }\n                primename=primename.concat('.deduped');\n\n                return primename+=ext;\n        } \n    }\n\n}"
                    },
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 2005,
                        "valueFrom": "${\n    var input_bam = [].concat(inputs.in_alignments)\n    var files = [].concat(inputs.in_alignments)\n    var filename = input_bam[0].path\n    \n    var meta = [];\n    for(var i = 0;i<files.length;i++)\n    {\n        if ((files[i].metadata) && (files[i].metadata['sample_id']))\n        {\n            meta.push(files[i].metadata['sample_id']);\n        }\n    }\n\n    /* figuring out output file type */\n    var ext = inputs.output_type\n    if (ext === \"BAM\") \n    {\n        var out_extension = \"BAM\"\n    } \n    else if (ext === \"SAM\") \n    {\n        var out_extension = \"SAM\"\n    } \n    else \n    {\n        var out_extension = filename.split('.').slice(-1)[0].toUpperCase()\n    }\n\n    /* if exist moving .bai in bam.bai */\n    if ((inputs.create_index === 'true') && (out_extension == \"BAM\") && (inputs.prefix)) \n    {\n        var old_name = inputs.prefix.concat('.deduped.bai')\n        var new_name = inputs.prefix.concat('.deduped.bam.bai')\n        return \"; mv \" + \" \" + old_name + \" \" + new_name\n    }\n    else if ((meta.length!=0) && (inputs.create_index === 'true') && (out_extension == \"BAM\"))\n    {\n        meta.sort();\n        var samplename = meta[0];\n        if (meta.length > 1)\n        {\n            var str = '.';\n            str += (meta.length).toString();\n            samplename+=str;\n        }\n        var old_name = samplename.concat('.deduped.bai')\n        var new_name = samplename.concat('.deduped.bam.bai')\n        return \"; mv \" + \" \" + old_name + \" \" + new_name\n    }\n    else if ((inputs.create_index === 'true') && (out_extension == \"BAM\")) \n    {\n        var old_name = filename.split('.').slice(0, -1).concat('deduped.bai').join('.').replace(/^.*[\\\\\\/]/, '')\n        var new_name = filename.split('.').slice(0, -1).concat('deduped.bam.bai').join('.').replace(/^.*[\\\\\\/]/, '')\n        return \"; mv \" + \" \" + old_name + \" \" + new_name\n    }\n    else\n    {\n        return ''\n    }\n\n}"
                    },
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 6,
                        "valueFrom": "${\n    var cmd = ''\n    var test = [].concat(inputs.in_alignments)\n    for (var i=0; i < test.length; i++)\n    {\n        cmd = cmd.concat('--INPUT ', test[i].path, ' ')\n    }\n    return cmd\n}"
                    },
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 12,
                        "valueFrom": "${\n    var cmd = ''\n    if (inputs.comment)\n    {\n        var test = [].concat(inputs.comment)\n        for (var i=0; i < test.length; i++)\n        {\n            cmd = cmd.concat(' --COMMENT ', test[i])\n        }\n    }\n    else\n    {\n        cmd = ''\n    }\n    \n    return cmd\n}"
                    }
                ],
                "requirements": [
                    {
                        "class": "ShellCommandRequirement"
                    },
                    {
                        "class": "ResourceRequirement",
                        "ramMin": "${\n    if(inputs.mem_per_job && inputs.mem_overhead_per_job){\n        return inputs.mem_per_job + inputs.mem_overhead_per_job\n  }\n    else if(!inputs.mem_per_job && inputs.mem_overhead_per_job){\n        return 2048 + inputs.mem_overhead_per_job \n  }\n    else if(inputs.mem_per_job && !inputs.mem_overhead_per_job){\n        return inputs.mem_per_job + 128\n  }\n    else\n        return 2048\n}",
                        "coresMin": "${\n  if (inputs.cpu_per_job) {\n      return inputs.cpu_per_job\n  }\n  else {\n      return 1\n  }\n}\n"
                    },
                    {
                        "class": "DockerRequirement",
                        "dockerPull": "images.sbgenomics.com/jrandjelovic/picard-3-0-0:0"
                    },
                    {
                        "class": "InitialWorkDirRequirement",
                        "listing": []
                    },
                    {
                        "class": "InlineJavascriptRequirement",
                        "expressionLib": [
                            "\nvar setMetadata = function(file, metadata) {\n    if (!('metadata' in file)) {\n        file['metadata'] = {}\n    }\n    for (var key in metadata) {\n        file['metadata'][key] = metadata[key];\n    }\n    return file\n};\nvar inheritMetadata = function(o1, o2) {\n    var commonMetadata = {};\n    if (!o2) {\n        return o1;\n    };\n    if (!Array.isArray(o2)) {\n        o2 = [o2]\n    }\n    for (var i = 0; i < o2.length; i++) {\n        var example = o2[i]['metadata'];\n        for (var key in example) {\n            if (i == 0)\n                commonMetadata[key] = example[key];\n            else {\n                if (!(commonMetadata[key] == example[key])) {\n                    delete commonMetadata[key]\n                }\n            }\n        }\n        for (var key in commonMetadata) {\n            if (!(key in example)) {\n                delete commonMetadata[key]\n            }\n        }\n    }\n    if (!Array.isArray(o1)) {\n        o1 = setMetadata(o1, commonMetadata)\n        if (o1.secondaryFiles) {\n            o1.secondaryFiles = inheritMetadata(o1.secondaryFiles, o2)\n        }\n    } else {\n        for (var i = 0; i < o1.length; i++) {\n            o1[i] = setMetadata(o1[i], commonMetadata)\n            if (o1[i].secondaryFiles) {\n                o1[i].secondaryFiles = inheritMetadata(o1[i].secondaryFiles, o2)\n            }\n        }\n    }\n    return o1;\n};"
                        ]
                    }
                ],
                "sbg:categories": [
                    "CWLtool Tested",
                    "SAM/BAM Processing"
                ],
                "sbg:image_url": null,
                "sbg:cmdPreview": "java -Xmx2048M -jar /opt/picard-tools-1.140/picard.jar MarkDuplicates INPUT=input_bam.ext METRICS_FILE=input_bam.metrics OUTPUT=input_bam.deduped.bam",
                "sbg:toolkitVersion": "3.0.0",
                "sbg:license": "MIT License",
                "sbg:links": [
                    {
                        "id": "http://broadinstitute.github.io/picard/index.html",
                        "label": "Homepage"
                    },
                    {
                        "id": "https://github.com/broadinstitute/picard/tree/master/src",
                        "label": "Source Code"
                    },
                    {
                        "id": "https://github.com/broadinstitute/picard/releases/tag/3.0.0",
                        "label": "Download"
                    },
                    {
                        "id": "http://broadinstitute.github.io/picard/",
                        "label": "Documentation"
                    }
                ],
                "sbg:toolkit": "Picard",
                "sbg:toolAuthor": "Broad Institute",
                "sbg:projectName": "SBG Public Data",
                "sbg:revisionsInfo": [
                    {
                        "sbg:revision": 0,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1680079495,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 1,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1680079495,
                        "sbg:revisionNotes": "initial setup"
                    }
                ],
                "sbg:expand_workflow": false,
                "sbg:appVersion": [
                    "v1.2"
                ],
                "sbg:id": "admin/sbg-public-data/picard-markduplicates-3-0-0-cwl1-2/1",
                "sbg:revision": 1,
                "sbg:revisionNotes": "initial setup",
                "sbg:modifiedOn": 1680079495,
                "sbg:modifiedBy": "admin",
                "sbg:createdOn": 1680079495,
                "sbg:createdBy": "admin",
                "sbg:project": "admin/sbg-public-data",
                "sbg:sbgMaintained": false,
                "sbg:validationErrors": [],
                "sbg:contributors": [
                    "admin"
                ],
                "sbg:latestRevision": 1,
                "sbg:publisher": "sbg",
                "sbg:content_hash": "a4809575278835503dfc00effce24c464ad7e52c4581ca2a6f9f9999defdedb85",
                "sbg:workflowLanguage": "CWL"
            },
            "label": "Picard MarkDuplicates",
            "sbg:x": 1288.4808349609375,
            "sbg:y": 36.072967529296875
        },
        {
            "id": "picard_mergesamfiles_1_140",
            "in": [
                {
                    "id": "input_files",
                    "source": [
                        "sambamba_sort_1_0_1_cwl1_2/out_alignments"
                    ]
                }
            ],
            "out": [
                {
                    "id": "merged_bam"
                }
            ],
            "run": {
                "cwlVersion": "sbg:draft-2",
                "class": "CommandLineTool",
                "$namespaces": {
                    "sbg": "https://sevenbridges.com"
                },
                "id": "admin/sbg-public-data/picard-mergesamfiles-1-140/12",
                "label": "Picard MergeSamFiles",
                "description": "Picard MergeSamFiles merges multiple SAM or BAM files into one file.",
                "baseCommand": [
                    "java",
                    {
                        "class": "Expression",
                        "script": "{   \n  if($job.inputs.memory_per_job){\n    return '-Xmx'.concat($job.inputs.memory_per_job, 'M')\n  }   \n  \treturn '-Xmx2048M'\n}",
                        "engine": "#cwl-js-engine"
                    },
                    "-jar",
                    "/opt/picard-tools-1.140/picard.jar",
                    "MergeSamFiles"
                ],
                "inputs": [
                    {
                        "sbg:stageInput": "link",
                        "sbg:altPrefix": "I",
                        "sbg:category": "File inputs",
                        "type": [
                            {
                                "type": "array",
                                "items": "File"
                            }
                        ],
                        "inputBinding": {
                            "position": 1,
                            "prefix": "INPUT=",
                            "separate": false,
                            "sbg:cmdInclude": true
                        },
                        "label": "Input (file)",
                        "description": "SAM or BAM input file  This option must be specified at least 1 times.",
                        "sbg:fileTypes": "SAM, BAM",
                        "id": "#input_files"
                    },
                    {
                        "sbg:category": "Options",
                        "sbg:toolDefaultValue": "500000",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "MAX_RECORDS_IN_RAM=",
                            "separate": false,
                            "sbg:cmdInclude": true
                        },
                        "label": "Max records in RAM",
                        "description": "When writing SAM files that need to be sorted, this will specify the number of records stored in RAM before spilling to disk. Increasing this number reduces the number of file handles needed to sort a SAM file, and increases the amount of RAM needed. Default value: 500000. This option can be set to 'null' to clear the default value.",
                        "id": "#max_records_in_ram"
                    },
                    {
                        "sbg:category": "Options",
                        "sbg:toolDefaultValue": "5",
                        "type": [
                            "null",
                            "int"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "COMPRESSION_LEVEL=",
                            "separate": false,
                            "sbg:cmdInclude": true
                        },
                        "label": "Compression level",
                        "description": "Compression level for all compressed files created (e.g. BAM and GELI).",
                        "id": "#compression_level"
                    },
                    {
                        "sbg:category": "Options",
                        "sbg:toolDefaultValue": "SILENT",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "STRICT",
                                    "LENIENT",
                                    "SILENT"
                                ],
                                "name": "validation_stringency"
                            }
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "VALIDATION_STRINGENCY=",
                            "separate": false,
                            "valueFrom": {
                                "class": "Expression",
                                "script": "{\n  if ($job.inputs.validation_stringency)\n  {\n    return $job.inputs.validation_stringency\n  }\n  else\n  {\n    return \"SILENT\"\n  }\n}",
                                "engine": "#cwl-js-engine"
                            },
                            "sbg:cmdInclude": true
                        },
                        "label": "Validation stringency",
                        "description": "Validation stringency for all SAM files read by this program. Setting stringency to SILENT can improve performance when processing a BAM file in which variable-length data (read, qualities, tags) do not otherwise need to be decoded. Default value: STRICT. This option can be set to 'null' to clear the default value. Possible values: {STRICT, LENIENT, SILENT}.",
                        "id": "#validation_stringency"
                    },
                    {
                        "sbg:category": "Options",
                        "sbg:toolDefaultValue": "False",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "True",
                                    "False"
                                ],
                                "name": "quiet"
                            }
                        ],
                        "inputBinding": {
                            "position": 0,
                            "prefix": "QUIET=",
                            "separate": false,
                            "sbg:cmdInclude": true
                        },
                        "label": "Quiet",
                        "description": "Whether to suppress job-summary info on System.err. Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false}.",
                        "id": "#quiet"
                    },
                    {
                        "sbg:category": "Options",
                        "sbg:toolDefaultValue": "False",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "True",
                                    "False"
                                ],
                                "name": "create_index"
                            }
                        ],
                        "inputBinding": {
                            "position": 5,
                            "prefix": "CREATE_INDEX=",
                            "separate": false,
                            "sbg:cmdInclude": true
                        },
                        "label": "Create index",
                        "description": "Whether to create a BAM index when writing a coordinate-sorted BAM file. Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false}.",
                        "id": "#create_index"
                    },
                    {
                        "sbg:altPrefix": "SO",
                        "sbg:category": "Options",
                        "sbg:toolDefaultValue": "coordinate",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "unsorted",
                                    "queryname",
                                    "coordinate",
                                    "duplicate"
                                ],
                                "name": "sort_order"
                            }
                        ],
                        "inputBinding": {
                            "position": 3,
                            "prefix": "SORT_ORDER=",
                            "separate": false,
                            "sbg:cmdInclude": true
                        },
                        "label": "Sort order",
                        "description": "Sort order of output file. Possible values: {unsorted, queryname, coordinate, duplicate}.",
                        "id": "#sort_order"
                    },
                    {
                        "sbg:category": "Options",
                        "sbg:toolDefaultValue": "SAME AS INPUT",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "BAM",
                                    "SAM",
                                    "SAME AS INPUT"
                                ],
                                "name": "output_type"
                            }
                        ],
                        "label": "Output format",
                        "description": "Since Picard tools can output both SAM and BAM files, user can choose the format of the output file.",
                        "id": "#output_type"
                    },
                    {
                        "sbg:altPrefix": "AS",
                        "sbg:category": "Options",
                        "sbg:toolDefaultValue": "False",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "assume_sorted"
                            }
                        ],
                        "inputBinding": {
                            "position": 5,
                            "prefix": "ASSUME_SORTED=",
                            "separate": false,
                            "sbg:cmdInclude": true
                        },
                        "label": "Assume sorted",
                        "description": "If true, assume that the input files are in the same sort order as the requested output sort order, even if their headers say otherwise. Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false}.",
                        "id": "#assume_sorted"
                    },
                    {
                        "sbg:altPrefix": "MSD",
                        "sbg:category": "Options",
                        "sbg:toolDefaultValue": "False",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "merge_sequence_dictionaries"
                            }
                        ],
                        "inputBinding": {
                            "position": 7,
                            "prefix": "MERGE_SEQUENCE_DICTIONARIES=",
                            "separate": false,
                            "sbg:cmdInclude": true
                        },
                        "label": "Merge sequence dictionaries",
                        "description": "Merge the sequence dictionaries. Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false}.",
                        "id": "#merge_sequence_dictionaries"
                    },
                    {
                        "sbg:category": "Options",
                        "sbg:toolDefaultValue": "False",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "true",
                                    "false"
                                ],
                                "name": "use_threading"
                            }
                        ],
                        "inputBinding": {
                            "position": 8,
                            "prefix": "USE_THREADING=",
                            "separate": false,
                            "sbg:cmdInclude": true
                        },
                        "label": "Use threading",
                        "description": "Option to create a background thread to encode, compress and write to disk the output file. The threaded version uses about 20% more CPU and decreases runtime by ~20% when writing out a compressed BAM file. Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false}.",
                        "id": "#use_threading"
                    },
                    {
                        "sbg:category": "Execution options",
                        "sbg:toolDefaultValue": "2048",
                        "type": [
                            "null",
                            "int"
                        ],
                        "label": "Memory per job",
                        "description": "Amount of RAM memory to be used per job. Defaults to 2048 MB for single threaded jobs.",
                        "id": "#memory_per_job"
                    }
                ],
                "outputs": [
                    {
                        "type": [
                            "null",
                            "File"
                        ],
                        "label": "Merged BAM",
                        "description": "SAM or BAM file to write merged result to.",
                        "sbg:fileTypes": "BAM, SAM",
                        "outputBinding": {
                            "glob": {
                                "class": "Expression",
                                "script": "{\n  input_files = [].concat($job.inputs.input_files)\n  filename = input_files[0].path.split('/').slice(-1)[0];\n  ext = $job.inputs.output_type;\n  \n  if (input_files[0].metadata && input_files[0].metadata.sample_id)\n  {\n    filebase = input_files[0].metadata.sample_id + \".merged.\"\n  }\n  else\n  { \n    filebase = \"sample_unknown.merged.\" \n  } \n \n  \n  \n //filebase = filename.split('.').slice(0, -1).join('.') + '.merged.';\n  \nif (ext === \"BAM\")\n{\n    return filebase + 'bam';\n}\nelse if (ext === \"SAM\")\n{\n    return filebase + 'sam';\n}\nelse \n{\n\treturn filebase + filename.split('.').slice(-1)[0];\n}\n}",
                                "engine": "#cwl-js-engine"
                            },
                            "sbg:metadata": {
                                "__inherit__": "input_file"
                            },
                            "sbg:inheritMetadataFrom": "#input_files",
                            "secondaryFiles": [
                                "^.bai",
                                ".bai"
                            ]
                        },
                        "id": "#merged_bam"
                    }
                ],
                "requirements": [
                    {
                        "class": "ExpressionEngineRequirement",
                        "engineCommand": "cwl-engine.js",
                        "id": "#cwl-js-engine",
                        "requirements": [
                            {
                                "class": "DockerRequirement",
                                "dockerPull": "rabix/js-engine"
                            }
                        ]
                    }
                ],
                "hints": [
                    {
                        "class": "sbg:CPURequirement",
                        "value": 1
                    },
                    {
                        "class": "sbg:MemRequirement",
                        "value": {
                            "class": "Expression",
                            "script": "{\n  if($job.inputs.memory_per_job){\n  \treturn $job.inputs.memory_per_job\n  }\n  \treturn 2048\n}",
                            "engine": "#cwl-js-engine"
                        }
                    },
                    {
                        "class": "DockerRequirement",
                        "dockerImageId": "eab0e70b6629",
                        "dockerPull": "images.sbgenomics.com/mladenlsbg/picard:1.140"
                    }
                ],
                "arguments": [
                    {
                        "position": 0,
                        "prefix": "OUTPUT=",
                        "separate": false,
                        "valueFrom": {
                            "class": "Expression",
                            "script": "{\n  input_files = [].concat($job.inputs.input_files)\n  filename = input_files[0].path.split('/').slice(-1)[0];\n  ext = $job.inputs.output_type;\n  \n  if (input_files[0].metadata && input_files[0].metadata.sample_id)\n  {\n    filebase = input_files[0].metadata.sample_id + \".merged.\"\n  }\n  else\n  { \n    filebase = \"sample_unknown.merged.\" \n  } \n \n  \n  \n //filebase = filename.split('.').slice(0, -1).join('.') + '.merged.';\n  \nif (ext === \"BAM\")\n{\n    return filebase + 'bam';\n}\nelse if (ext === \"SAM\")\n{\n    return filebase + 'sam';\n}\nelse \n{\n\treturn filebase + filename.split('.').slice(-1)[0];\n}\n}",
                            "engine": "#cwl-js-engine"
                        }
                    },
                    {
                        "position": 2001,
                        "separate": true,
                        "valueFrom": {
                            "class": "Expression",
                            "script": "{\n  input_files = [].concat($job.inputs.input_files)\n  filename = input_files[0].path.split('/').slice(-1)[0];\n  ext = $job.inputs.output_type;\n  \n  if (input_files[0].metadata && input_files[0].metadata.sample_id)\n  {\n    filebase = input_files[0].metadata.sample_id + \".merged.\"\n  }\n  else\n  { \n    filebase = \"sample_unknown.merged.\" \n  } \n \n  \n  \n //filebase = filename.split('.').slice(0, -1).join('.') + '.merged.';\n  \nif (ext === \"BAM\")\n{\n  \tout_extension = \"BAM\"\n}\nelse if (ext === \"SAM\")\n{\n  \tout_extension = \"SAM\"\n}\n\nelse \n{\n  \tout_extension = filename.split('.').slice(-1)[0].toUpperCase(); \n} \n  \n  /* if exist moving .bai in bam.bai */\n  if ($job.inputs.create_index === 'True' && ($job.inputs.sort_order === 'coordinate' || typeof($job.inputs.sort_order) === \"undefined\") && out_extension == \"BAM\")\n  {\n    \n    old_name = filebase.concat('bai')\n    new_name = filebase.concat('bam.bai')\n    return \"; mv \" + \" \" + old_name + \" \" + new_name\n  }\n\n}",
                            "engine": "#cwl-js-engine"
                        }
                    }
                ],
                "sbg:categories": [
                    "SAM/BAM Processing"
                ],
                "sbg:image_url": null,
                "sbg:cmdPreview": "java -Xmx2048M -jar /opt/picard-tools-1.140/picard.jar MergeSamFiles OUTPUT=sample_unknown.merged.bam INPUT=/root/dir/example.bam INPUT=/root/dir/second_example.bam  ; mv  sample_unknown.merged.bai sample_unknown.merged.bam.bai",
                "sbg:revisionsInfo": [
                    {
                        "sbg:revision": 0,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1453799150,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 1,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1453799150,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 2,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1453799152,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 3,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1453799156,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 4,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1459163407,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 5,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1459163407,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 6,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1471539420,
                        "sbg:revisionNotes": "Added different output file naming (based on sample metadata) and input categories."
                    },
                    {
                        "sbg:revision": 7,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1471539420,
                        "sbg:revisionNotes": "Fixed output globe."
                    },
                    {
                        "sbg:revision": 8,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1471539430,
                        "sbg:revisionNotes": "Added file to list conversion in arguments (for mv option in case of indexing)."
                    },
                    {
                        "sbg:revision": 9,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1471539430,
                        "sbg:revisionNotes": "Foxed mv command for indexing."
                    },
                    {
                        "sbg:revision": 10,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1471539430,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 11,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1496419753,
                        "sbg:revisionNotes": "glob changed -  should work with inputs that contain 'merged' in their name"
                    },
                    {
                        "sbg:revision": 12,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1648046178,
                        "sbg:revisionNotes": "categories updated"
                    }
                ],
                "sbg:projectName": "SBG Public Data",
                "sbg:job": {
                    "inputs": {
                        "memory_per_job": null,
                        "assume_sorted": null,
                        "input_files": [
                            {
                                "path": "/root/dir/example.bam",
                                "secondaryFiles": []
                            },
                            {
                                "path": "/root/dir/second_example.bam",
                                "secondaryFiles": []
                            }
                        ],
                        "create_index": "True",
                        "sort_order": "coordinate"
                    },
                    "allocatedResources": {
                        "mem": 2048,
                        "cpu": 1
                    }
                },
                "sbg:toolkitVersion": "1.140",
                "sbg:license": "MIT License, Apache 2.0 Licence",
                "sbg:links": [
                    {
                        "label": "Homepage",
                        "id": "http://broadinstitute.github.io/picard/"
                    },
                    {
                        "label": "Source Code",
                        "id": "https://github.com/broadinstitute/picard/releases/tag/1.140"
                    },
                    {
                        "label": "Wiki",
                        "id": "http://broadinstitute.github.io/picard/"
                    },
                    {
                        "label": "Download",
                        "id": "https://github.com/broadinstitute/picard/zipball/master"
                    },
                    {
                        "label": "Publication",
                        "id": "http://broadinstitute.github.io/picard/"
                    }
                ],
                "sbg:toolkit": "Picard",
                "sbg:toolAuthor": "Broad Institute",
                "sbg:expand_workflow": false,
                "sbg:appVersion": [
                    "sbg:draft-2"
                ],
                "sbg:id": "admin/sbg-public-data/picard-mergesamfiles-1-140/12",
                "sbg:revision": 12,
                "sbg:revisionNotes": "categories updated",
                "sbg:modifiedOn": 1648046178,
                "sbg:modifiedBy": "admin",
                "sbg:createdOn": 1453799150,
                "sbg:createdBy": "sevenbridges",
                "sbg:project": "admin/sbg-public-data",
                "sbg:sbgMaintained": false,
                "sbg:validationErrors": [],
                "sbg:contributors": [
                    "sevenbridges",
                    "admin"
                ],
                "sbg:latestRevision": 12,
                "sbg:publisher": "sbg",
                "sbg:content_hash": "a50422aa3d3ce2a2a37ce7a9f67f542c8eb6f573b2e1c16d3fba69cbbc8ceb659",
                "sbg:workflowLanguage": "CWL"
            },
            "label": "Picard MergeSamFiles",
            "sbg:x": 1007.0430908203125,
            "sbg:y": 46.45933532714844
        },
        {
            "id": "sbg_fasta_indices",
            "in": [
                {
                    "id": "reference",
                    "source": "reference"
                }
            ],
            "out": [
                {
                    "id": "fasta_reference"
                },
                {
                    "id": "fasta_index"
                },
                {
                    "id": "fasta_dict"
                }
            ],
            "run": {
                "cwlVersion": "sbg:draft-2",
                "class": "CommandLineTool",
                "$namespaces": {
                    "sbg": "https://sevenbridges.com"
                },
                "id": "admin/sbg-public-data/sbg-fasta-indices/30",
                "label": "SBG FASTA Indices",
                "description": "Create indices for FASTA file.\n\n###**Overview**  \n\nTool allows creating FASTA dictionary and index simultaneously which is necessary for running GATK tools. This version of tool for indexing uses SAMtools faidx command (toolkit version 1.9), while for the FASTA dictionary is used CreateFastaDictionary (GATK toolkit version 4.1.0.0).\n\n\n###**Inputs**  \n\n- FASTA file \n\n###**Output**  \n\n- FASTA Reference file\n- FASTA Index file\n- FASTA Dictionary file\n\n\n###**Changes made by Seven Bridges**\n\nCreateFastaDictionary function creates a DICT file describing the contents of the FASTA file. Parameter -UR was added to the command line that sets the UR field to just the Reference file name, instead of the whole path to file. This allows Memoisation feature of the platform to work.",
                "baseCommand": [
                    "samtools",
                    "faidx"
                ],
                "inputs": [
                    {
                        "sbg:stageInput": "link",
                        "sbg:category": "Input files",
                        "type": [
                            "File"
                        ],
                        "inputBinding": {
                            "position": 0,
                            "separate": true,
                            "sbg:cmdInclude": true
                        },
                        "label": "FASTA file",
                        "description": "FASTA file to be indexed",
                        "sbg:fileTypes": "FASTA, FA, FA.GZ, FASTA.GZ",
                        "id": "#reference"
                    },
                    {
                        "sbg:category": "Execution",
                        "sbg:toolDefaultValue": "2048",
                        "type": [
                            "null",
                            "int"
                        ],
                        "label": "Memory per job",
                        "description": "Memory in megabytes required for each execution of the tool.",
                        "id": "#memory_per_job"
                    }
                ],
                "outputs": [
                    {
                        "type": [
                            "null",
                            "File"
                        ],
                        "label": "Reference",
                        "sbg:fileTypes": "FASTA",
                        "outputBinding": {
                            "glob": {
                                "script": "{\n  return $job.inputs.reference.path.split('/').pop()\n}",
                                "class": "Expression",
                                "engine": "#cwl-js-engine"
                            },
                            "sbg:inheritMetadataFrom": "#reference",
                            "secondaryFiles": [
                                ".fai",
                                "^.dict",
                                "^^.dict"
                            ]
                        },
                        "id": "#fasta_reference"
                    },
                    {
                        "type": [
                            "null",
                            "File"
                        ],
                        "label": "FASTA Index",
                        "sbg:fileTypes": "FAI",
                        "outputBinding": {
                            "glob": "*.fai"
                        },
                        "id": "#fasta_index"
                    },
                    {
                        "type": [
                            "null",
                            "File"
                        ],
                        "label": "FASTA Dictionary",
                        "sbg:fileTypes": "DICT",
                        "outputBinding": {
                            "glob": "*.dict"
                        },
                        "id": "#fasta_dict"
                    }
                ],
                "requirements": [
                    {
                        "class": "ExpressionEngineRequirement",
                        "id": "#cwl-js-engine",
                        "requirements": [
                            {
                                "dockerPull": "rabix/js-engine",
                                "class": "DockerRequirement"
                            }
                        ]
                    }
                ],
                "hints": [
                    {
                        "class": "sbg:CPURequirement",
                        "value": 1
                    },
                    {
                        "class": "sbg:MemRequirement",
                        "value": {
                            "script": "{\n  if($job.inputs.memory_per_job)return $job.inputs.memory_per_job + 500\n  else return 2548\n}",
                            "class": "Expression",
                            "engine": "#cwl-js-engine"
                        }
                    },
                    {
                        "class": "DockerRequirement",
                        "dockerImageId": "b177f5bd06db",
                        "dockerPull": "images.sbgenomics.com/vladimirk/gatk4-samtools:4.1.4.0-1.9"
                    }
                ],
                "arguments": [
                    {
                        "position": 1,
                        "prefix": "&&",
                        "separate": true,
                        "valueFrom": {
                            "class": "Expression",
                            "engine": "#cwl-js-engine",
                            "script": "{\n  memory = '2048'\n  if ($job.inputs.memory_per_job){\n    memory = $job.inputs.memory_per_job\n  }\n  filename = $job.inputs.reference.path.split('/').pop()\n  basename = filename.split('.')\n  if (filename.endsWith('.gz')){\n    basename.pop()\n  }\n  basename.pop()\n  name = basename.join('.')\n  return 'java -Xmx' + memory + 'M -jar /gatk/gatk-package-4.1.0.0-local.jar CreateSequenceDictionary -R=' + $job.inputs.reference.path + ' -O=' + name + '.dict'\n}"
                        }
                    },
                    {
                        "position": 3,
                        "prefix": "-UR=",
                        "separate": false,
                        "valueFrom": {
                            "class": "Expression",
                            "engine": "#cwl-js-engine",
                            "script": "{\n  return $job.inputs.reference.path.split('/')[ $job.inputs.reference.path.split('/').length - 1]\n}"
                        }
                    }
                ],
                "sbg:toolAuthor": "Sanja Mijalkovic, Seven Bridges Genomics, <sanja.mijalkovic@sbgenomics.com>",
                "sbg:cmdPreview": "samtools faidx  /path/to/reference.fa.gz && java -Xmx10M -jar /gatk/gatk-package-4.1.0.0-local.jar CreateSequenceDictionary -R=/path/to/reference.fa.gz -O=reference.dict -UR=reference.fa.gz",
                "sbg:toolkit": "SBGTools",
                "sbg:image_url": null,
                "sbg:job": {
                    "allocatedResources": {
                        "cpu": 1,
                        "mem": 510
                    },
                    "inputs": {
                        "reference": {
                            "secondaryFiles": [],
                            "path": "/path/to/reference.fa.gz",
                            "size": 0,
                            "class": "File"
                        },
                        "memory_per_job": 10
                    }
                },
                "sbg:projectName": "SBG Public Data",
                "sbg:categories": [
                    "Indexing"
                ],
                "sbg:revisionsInfo": [
                    {
                        "sbg:revision": 0,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1453799686,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 1,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1453799687,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 2,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1459163408,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 3,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1459163408,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 4,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1459163408,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 5,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1459163408,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 6,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1468402323,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 7,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1468402323,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 8,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1468402323,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 9,
                        "sbg:modifiedBy": "sevenbridges",
                        "sbg:modifiedOn": 1468402323,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 10,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1504629649,
                        "sbg:revisionNotes": "Removed python script. Changed docker to just samtools and picard. Wrapped both faidx and CreateSequenceDictionary and exposed memory parameter for java execution."
                    },
                    {
                        "sbg:revision": 11,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1506681301,
                        "sbg:revisionNotes": "Changed join to join('.')."
                    },
                    {
                        "sbg:revision": 12,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1521478771,
                        "sbg:revisionNotes": "Added support for FA.GZ, FASTA.GZ"
                    },
                    {
                        "sbg:revision": 13,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1521478771,
                        "sbg:revisionNotes": "Added secondary .dict support for fasta.gz"
                    },
                    {
                        "sbg:revision": 14,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1530626967,
                        "sbg:revisionNotes": "returned to rev 8"
                    },
                    {
                        "sbg:revision": 15,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1530626967,
                        "sbg:revisionNotes": "rev 7"
                    },
                    {
                        "sbg:revision": 16,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1530626967,
                        "sbg:revisionNotes": "rev 9: Added secondary .dict support"
                    },
                    {
                        "sbg:revision": 17,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1530631703,
                        "sbg:revisionNotes": "returned to rev 8"
                    },
                    {
                        "sbg:revision": 18,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1530631703,
                        "sbg:revisionNotes": "rev 7"
                    },
                    {
                        "sbg:revision": 19,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1530631703,
                        "sbg:revisionNotes": "rev 9: Added secondary .dict support"
                    },
                    {
                        "sbg:revision": 20,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1545924489,
                        "sbg:revisionNotes": "Updated version for samtools (1.9) and picard (2.18.14)"
                    },
                    {
                        "sbg:revision": 21,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1545924489,
                        "sbg:revisionNotes": "Reverted."
                    },
                    {
                        "sbg:revision": 22,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1575892942,
                        "sbg:revisionNotes": "Added URI to eliminate randomness in .dict"
                    },
                    {
                        "sbg:revision": 23,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1575892944,
                        "sbg:revisionNotes": "Added URI to remove randomness"
                    },
                    {
                        "sbg:revision": 24,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1575892944,
                        "sbg:revisionNotes": "Updated to GATK 4.1.0.0"
                    },
                    {
                        "sbg:revision": 25,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1575892944,
                        "sbg:revisionNotes": "bug fix"
                    },
                    {
                        "sbg:revision": 26,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1575892944,
                        "sbg:revisionNotes": "description"
                    },
                    {
                        "sbg:revision": 27,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1575892944,
                        "sbg:revisionNotes": "updated command line preview"
                    },
                    {
                        "sbg:revision": 28,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1630934186,
                        "sbg:revisionNotes": "Tool description update to clarify it only takes one FASTA file"
                    },
                    {
                        "sbg:revision": 29,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1648035758,
                        "sbg:revisionNotes": "Updated categories"
                    },
                    {
                        "sbg:revision": 30,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1682685143,
                        "sbg:revisionNotes": "Categories updated"
                    }
                ],
                "sbg:license": "Apache License 2.0",
                "sbg:expand_workflow": false,
                "sbg:appVersion": [
                    "sbg:draft-2"
                ],
                "sbg:id": "admin/sbg-public-data/sbg-fasta-indices/30",
                "sbg:revision": 30,
                "sbg:revisionNotes": "Categories updated",
                "sbg:modifiedOn": 1682685143,
                "sbg:modifiedBy": "admin",
                "sbg:createdOn": 1453799686,
                "sbg:createdBy": "sevenbridges",
                "sbg:project": "admin/sbg-public-data",
                "sbg:sbgMaintained": false,
                "sbg:validationErrors": [],
                "sbg:contributors": [
                    "sevenbridges",
                    "admin"
                ],
                "sbg:latestRevision": 30,
                "sbg:publisher": "sbg",
                "sbg:content_hash": "a21b3ebe8e82b8fd5100676f5de37ea9b35992d0cbbb0c97a62c7e6a8dea4d620",
                "sbg:workflowLanguage": "CWL"
            },
            "label": "SBG FASTA Indices",
            "sbg:x": 439.6169128417969,
            "sbg:y": -171.0939178466797
        },
        {
            "id": "samtools_index_1_9_cwl1_0",
            "in": [
                {
                    "id": "in_alignments",
                    "source": "picard_markduplicates_3_0_0_cwl1_2/out_alignments"
                }
            ],
            "out": [
                {
                    "id": "indexed_data_file"
                },
                {
                    "id": "out_index"
                }
            ],
            "run": {
                "class": "CommandLineTool",
                "cwlVersion": "v1.0",
                "$namespaces": {
                    "sbg": "https://sevenbridges.com"
                },
                "id": "admin/sbg-public-data/samtools-index-1-9-cwl1-0/7",
                "baseCommand": [],
                "inputs": [
                    {
                        "sbg:category": "File Inputs",
                        "id": "in_alignments",
                        "type": "File",
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 100,
                            "valueFrom": "${\n    if (inputs.in_index) {\n        var index_ext = [].concat(inputs.in_index)[0].path.substr([].concat(inputs.in_index)[0].path.lastIndexOf('.') + 1)\n        var input_ext = [].concat(inputs.in_alignments)[0].path.substr([].concat(inputs.in_alignments)[0].path.lastIndexOf('.') + 1)\n        var index_format = 'BAI'\n        if (inputs.index_file_format) {\n            index_format = inputs.index_file_format\n        }\n        if (inputs.minimum_interval_size) {\n            index_format = ''\n        }\n\n        if ((index_ext.toUpperCase() === 'CRAI' && input_ext.toUpperCase() === 'CRAM') ||\n            (index_ext.toUpperCase() === index_format && input_ext.toUpperCase() === 'BAM')) {\n            return\n        } else {\n            return inputs.in_alignments.path\n        }\n    } else {\n        return inputs.in_alignments.path\n    }\n}"
                        },
                        "label": "BAM/CRAM input file",
                        "doc": "BAM/CRAM input file.",
                        "sbg:fileTypes": "BAM, CRAM"
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "False",
                        "id": "output_indexed_data",
                        "type": "boolean?",
                        "label": "Output indexed data file",
                        "doc": "Setting this parameter to True will provide BAM file (and BAI file as secondary file) at Indexed data file output port. The default value is False."
                    },
                    {
                        "sbg:category": "File Inputs",
                        "id": "in_index",
                        "type": "File?",
                        "label": "Input index file",
                        "doc": "Input index file (CSI, CRAI, or BAI). If an input BAM/CRAM file is already indexed, index file can be provided at this port. If it is provided, the tool will just pass it through. This option is useful for workflows when it is not know in advance if the input BAM/CRAM file has accompanying index file present in the project.",
                        "sbg:fileTypes": "BAI, CSI, CRAI"
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "14",
                        "id": "minimum_interval_size",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "-m",
                            "shellQuote": false,
                            "position": 2,
                            "valueFrom": "${\n    var self\n    if (self == 0) {\n        self = null;\n        inputs.minimum_interval_size = null\n    };\n\n\n    if (inputs.minimum_interval_size) {\n        if (inputs.in_index) {\n            var index_ext = [].concat(inputs.in_index)[0].path.substr([].concat(inputs.in_index)[0].path.lastIndexOf('.') + 1)\n            var input_ext = [].concat(inputs.in_alignments)[0].path.substr([].concat(inputs.in_alignments)[0].path.lastIndexOf('.') + 1)\n            var index_format = 'BAI'\n            if (inputs.index_file_format) {\n                index_format = inputs.index_file_format\n            }\n            if (inputs.minimum_interval_size) {\n                index_format = ''\n            }\n\n            if ((index_ext.toUpperCase() === 'CRAI' && input_ext.toUpperCase() === 'CRAM') ||\n                (index_ext.toUpperCase() === index_format && input_ext.toUpperCase() === 'BAM')) {\n                return\n            } else {\n                return inputs.minimum_interval_size\n            }\n        } else {\n            return inputs.minimum_interval_size\n        }\n    } else {\n        return\n    }\n}"
                        },
                        "label": "Minimum interval size (2^INT)",
                        "doc": "Set minimum interval size for CSI indices to 2^INT. Default value is 14. Setting this value will force generating CSI index file (if the input file is BAM) regardless of the value of the parameter Format of index file (for BAM files).",
                        "default": 0
                    },
                    {
                        "sbg:category": "Config Inputs",
                        "sbg:toolDefaultValue": "BAI",
                        "id": "index_file_format",
                        "type": [
                            "null",
                            {
                                "type": "enum",
                                "symbols": [
                                    "BAI",
                                    "CSI"
                                ],
                                "name": "index_file_format"
                            }
                        ],
                        "inputBinding": {
                            "shellQuote": false,
                            "position": 1,
                            "valueFrom": "${\n    var self\n    if (self == 0) {\n        self = null;\n        inputs.index_file_format = null\n    };\n\n\n    if (inputs.index_file_format) {\n        if (inputs.in_index) {\n            var index_ext = [].concat(inputs.in_index)[0].path.substr([].concat(inputs.in_index)[0].path.lastIndexOf('.') + 1)\n            var input_ext = [].concat(inputs.in_alignments)[0].path.substr([].concat(inputs.in_alignments)[0].path.lastIndexOf('.') + 1)\n            var index_format = inputs.index_file_format\n            if (inputs.minimum_interval_size) {\n                index_format = ''\n            }\n\n            if ((index_ext.toUpperCase() === 'CRAI' && input_ext.toUpperCase() === 'CRAM') ||\n                (index_ext.toUpperCase() === index_format && input_ext.toUpperCase() === 'BAM')) {\n                return\n            } else {\n                if (inputs.index_file_format === 'BAI') {\n                    return '-b'\n                } else if (inputs.index_file_format === 'CSI') {\n                    return '-c'\n                }\n            }\n        } else {\n            if (inputs.index_file_format === 'BAI') {\n                return '-b'\n            } else if (inputs.index_file_format === 'CSI') {\n                return '-c'\n            }\n        }\n    } else {\n        return\n    }\n}"
                        },
                        "label": "Format of index file (for BAM files)",
                        "doc": "Choose which file format will be generated for index file (BAI or CSI) if the input is BAM file. In case the input is CRAM file, this will be ignored and the tool will generate CRAI file.",
                        "default": 0
                    },
                    {
                        "sbg:category": "Execution",
                        "sbg:toolDefaultValue": "1",
                        "id": "threads",
                        "type": "int?",
                        "inputBinding": {
                            "prefix": "-@",
                            "shellQuote": false,
                            "position": 1,
                            "valueFrom": "${\n    var self\n    if (self == 0) {\n        self = null;\n        inputs.threads = null\n    };\n\n\n    if (inputs.threads) {\n        if (inputs.in_index) {\n            var index_ext = [].concat(inputs.in_index)[0].path.substr([].concat(inputs.in_index)[0].path.lastIndexOf('.') + 1)\n            var input_ext = [].concat(inputs.in_alignments)[0].path.substr([].concat(inputs.in_alignments)[0].path.lastIndexOf('.') + 1)\n            var index_format = 'BAI'\n            if (inputs.index_file_format) {\n                index_format = inputs.index_file_format\n            }\n            if (inputs.minimum_interval_size) {\n                index_format = ''\n            }\n\n            if ((index_ext.toUpperCase() === 'CRAI' && input_ext.toUpperCase() === 'CRAM') ||\n                (index_ext.toUpperCase() === index_format && input_ext.toUpperCase() === 'BAM')) {\n                return\n            } else {\n                return inputs.threads\n            }\n        } else {\n            return inputs.threads\n        }\n    } else {\n        return\n    }\n}"
                        },
                        "label": "Number of threads",
                        "doc": "Number of threads.",
                        "default": 0
                    },
                    {
                        "sbg:category": "File Inputs",
                        "sbg:altPrefix": "--reference",
                        "id": "in_reference",
                        "type": "File?",
                        "label": "Reference file",
                        "doc": "A FASTA format reference file, optionally compressed by bgzip and ideally indexed by SAMtools Faidx. If an index is not present, one will be generated for you. This file is used for compression/decompression of CRAM files. Please provide reference file when using CRAM input/output file.",
                        "sbg:fileTypes": "FASTA, FA, FASTA.GZ, FA.GZ, GZ"
                    },
                    {
                        "sbg:category": "Platform Options",
                        "sbg:toolDefaultValue": "1500",
                        "id": "mem_per_job",
                        "type": "int?",
                        "label": "Memory per job",
                        "doc": "Memory per job in MB."
                    },
                    {
                        "sbg:category": "Platform Options",
                        "sbg:toolDefaultValue": "1",
                        "id": "cpu_per_job",
                        "type": "int?",
                        "label": "CPU per job",
                        "doc": "Number of CPUs per job."
                    }
                ],
                "outputs": [
                    {
                        "id": "indexed_data_file",
                        "doc": "Output BAM/CRAM, along with its index as secondary file.",
                        "label": "Indexed data file",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "${\n    if (inputs.output_indexed_data === true) {\n        return [].concat(inputs.in_alignments)[0].path.split(\"/\").pop()\n    } else {\n        return ''\n    }\n}",
                            "outputEval": "${\n    for (var i = 0; i < self.length; i++){\n        self[i] = inheritMetadata(self[i], inputs.in_alignments);\n        if (self.hasOwnProperty('secondaryFiles')){\n            for (var j = 0; j < self[i].secondaryFiles.length; j++){\n                self[i].secondaryFiles[j] = inheritMetadata(self[i].secondaryFiles[j], inputs.in_alignments);\n            }\n        }\n    }\n    return self;\n}"
                        },
                        "secondaryFiles": [
                            ".bai",
                            ".crai",
                            "^.bai",
                            "^.crai",
                            ".csi",
                            "^.csi"
                        ],
                        "sbg:fileTypes": "BAM, CRAM"
                    },
                    {
                        "id": "out_index",
                        "doc": "Generated index file (without the indexed data).",
                        "label": "Generated index file",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "${\n    var input_ext = [].concat(inputs.in_alignments)[0].path.substr([].concat(inputs.in_alignments)[0].path.lastIndexOf('.') + 1)\n    if (input_ext.toUpperCase() === 'CRAM') {\n        return '*.crai'\n    } else if (input_ext.toUpperCase() === 'BAM') {\n        var index_format = 'BAI'\n        if (inputs.index_file_format) {\n            index_format = inputs.index_file_format\n        }\n        if (inputs.minimum_interval_size) {\n            index_format = 'CSI'\n        }\n        return '*.' + index_format.toLowerCase()\n    }\n}",
                            "outputEval": "${\n    if (inputs.in_index) {\n        for (var i = 0; i < self.length; i++){\n                self[i] = inheritMetadata(self[i], inputs.in_index);\n    }\n    return self\n    }\n    else {\n    for (var i = 0; i < self.length; i++){\n                self[i] = inheritMetadata(self[i], inputs.in_alignments);\n    }\n    return self;\n    }\n}"
                        },
                        "sbg:fileTypes": "BAI, CRAI, CSI"
                    }
                ],
                "doc": "**SAMtools Index** tool is used to index a coordinate-sorted BAM or CRAM file for fast random access. Note that this does not work with SAM files even if they are bgzip compressed — to index such files, use tabix instead. This index is needed when region arguments are used to limit **SAMtools View** and similar commands to particular regions of interest. For a CRAM file aln.cram, index file aln.cram.crai will be created; for a BAM file aln.bam, either aln.bam.bai or aln.bam.csi will be created, depending on the index format selected [1].\n\n*A list of **all inputs and parameters** with corresponding descriptions can be found at the bottom of the page.*\n\n###Common Use Cases \n\n- When using this tool as a standalone tool, **Input index file** should not be provided. This input is given as an option that is convenient to use in workflows. \n- When using this tool in a workflow, **Input index file** can be provided. In case it is provided, tool execution will be skipped and it will just pass the inputs through. This is useful for workflows which use tools that require an index file when it is not known in advance if the input BAM/CRAM file will have accompanying index file present in the project. If the next tool in the workflow requires an index file as a secondary file, parameter **Output indexed data file** should be set to True. This will provide a BAM/CRAM file at the **Indexed data file** output port along with its index file (BAI/CSI/CRAI) as the secondary file.\n- If a CRAM file is provided at the **BAM/CRAM input file** port, the tool will generate a CRAI index file. If a BAM file is provided, the tool will generate a BAI or CSI index file depending on the parameter **Format of index file (for BAM files)** (`-b/-c`). If no value is set, the tool will generate a BAI index file. Setting the parameter **Minimum interval size (2^INT)** (`-m`) will force the CSI format regardless of the value of the parameter **Format of index file (for BAM files)**.\n\n###Changes Introduced by Seven Bridges\n\n- Parameter **Output filename** is omitted from the wrapper. For a CRAM file aln.cram, output filename will be aln.cram.crai; for a BAM file aln.bam, it will be either aln.bam.bai or aln.bam.csi, depending on the index format selected.\n- Parameter **Output indexed data file** and file input **Input index file** are added to provide additional options for integration with other tools within a workflow. \n\n###Common Issues and Important Notes\n\n- **BAM/CRAM input file** should be sorted by coordinates, not by name. Otherwise, the task will fail.\n- **When using this tool in a workflow, if the next tool in the workflow requires index file as a secondary file, parameter Output indexed data file should be set to True. This will provide BAM/CRAM file at Indexed data file output port along with its index file (BAI/CSI/CRAI) as secondary file.**\n\n###Performance Benchmarking\n\nMultithreading can be enabled by setting parameter **Number of threads** (`-@`). In the following table you can find estimates of **SAMtools Index** running time and cost.\n\n*Cost can be significantly reduced by using **spot instances**. Visit the [Knowledge Center](https://docs.sevenbridges.com/docs/about-spot-instances) for more details.*  \n\n| Input type | Input size | # of reads | Read length |  # of threads | Duration | Cost | Instance (AWS)|\n|---------------|--------------|---------------|------------------|---------------------|-------------|--------|-------------|\n|  BAM | 5.26 GB | 71.5M | 76 | 1 | 4min. | \\$0.04 | c4.2xlarge |\n|  BAM | 11.86 GB | 161.2M | 101| 1 | 10min. | \\$0.09 | c4.2xlarge |\n|  BAM | 18.36 GB | 179M | 76 | 1 | 12min. | \\$0.11 | c4.2xlarge |\n|  BAM | 58.61 GB | 845.6M | 150 | 1 | 36min. | \\$0.32 | c4.2xlarge |\n|  BAM | 5.26 GB | 71.5M | 76 | 8 | 3min. | \\$0.03 | c4.2xlarge |\n|  BAM | 11.86 GB | 161.2M | 101| 8 | 9min. | \\$0.08 | c4.2xlarge |\n|  BAM | 18.36 GB | 179M | 76 | 8 | 11min. | \\$0.10 | c4.2xlarge |\n|  BAM | 58.61 GB | 845.6M | 150 | 8 | 30min. | \\$0.27 | c4.2xlarge |\n\n###References\n\n[1] [SAMtools documentation](http://www.htslib.org/doc/samtools-1.9.html)",
                "label": "Samtools Index CWL1.0",
                "arguments": [
                    {
                        "prefix": "",
                        "shellQuote": false,
                        "position": 0,
                        "valueFrom": "${\n    if (inputs.in_index) {\n        var index_ext = [].concat(inputs.in_index)[0].path.substr([].concat(inputs.in_index)[0].path.lastIndexOf('.') + 1)\n        var input_ext = [].concat(inputs.in_alignments)[0].path.substr([].concat(inputs.in_alignments)[0].path.lastIndexOf('.') + 1)\n        var index_format = 'BAI'\n        if (inputs.index_file_format) {\n            index_format = inputs.index_file_format\n        }\n        if (inputs.minimum_interval_size) {\n            index_format = ''\n        }\n\n        if ((index_ext.toUpperCase() === 'CRAI' && input_ext.toUpperCase() === 'CRAM') ||\n            (index_ext.toUpperCase() === index_format && input_ext.toUpperCase() === 'BAM')) {\n            return \"echo Skipping index step because an index file is provided on the input.\"\n        } else {\n            return \"/opt/samtools-1.9/samtools index\"\n        }\n    } else {\n        return \"/opt/samtools-1.9/samtools index\"\n    }\n}"
                    },
                    {
                        "shellQuote": false,
                        "position": 1001,
                        "valueFrom": "&& echo $REF_PATH"
                    }
                ],
                "requirements": [
                    {
                        "class": "ShellCommandRequirement"
                    },
                    {
                        "class": "ResourceRequirement",
                        "ramMin": "${\n    if (inputs.mem_per_job) {\n        return inputs.mem_per_job\n    }\n    else {\n        return 1500\n    }\n}",
                        "coresMin": "${\n    if (inputs.cpu_per_job) {\n        return inputs.cpu_per_job\n    }\n    else {\n    var threads = 1\n    if (inputs.threads) {\n        threads = inputs.threads\n    }\n\n    if (inputs.in_index) {\n        var index_ext = [].concat(inputs.in_index)[0].path.substr([].concat(inputs.in_index)[0].path.lastIndexOf('.') + 1)\n        var input_ext = [].concat(inputs.in_alignments)[0].path.substr([].concat(inputs.in_alignments)[0].path.lastIndexOf('.') + 1)\n        var index_format = 'BAI'\n        if (inputs.index_file_format) {\n            index_format = inputs.index_file_format\n        }\n        if (inputs.minimum_interval_size) {\n            index_format = ''\n        }\n\n        if ((index_ext.toUpperCase() === 'CRAI' && input_ext.toUpperCase() === 'CRAM') ||\n            (index_ext.toUpperCase() === index_format && input_ext.toUpperCase() === 'BAM')) {\n            return 1\n        } else {\n            return threads\n        }\n    } else {\n        return threads\n    }\n    }\n}"
                    },
                    {
                        "class": "DockerRequirement",
                        "dockerImageId": "2fb927277493",
                        "dockerPull": "images.sbgenomics.com/jrandjelovic/samtools-1-9:1"
                    },
                    {
                        "class": "InitialWorkDirRequirement",
                        "listing": [
                            "$(inputs.in_alignments)",
                            "$(inputs.in_index)",
                            "$(inputs.in_reference)"
                        ]
                    },
                    {
                        "class": "InlineJavascriptRequirement",
                        "expressionLib": [
                            "var setMetadata = function(file, metadata) {\n    if (!('metadata' in file)) {\n        file['metadata'] = {}\n    }\n    for (var key in metadata) {\n        file['metadata'][key] = metadata[key];\n    }\n    return file\n};\n\nvar inheritMetadata = function(o1, o2) {\n    var commonMetadata = {};\n    if (!o2) {\n        return o1;\n    };\n    if (!Array.isArray(o2)) {\n        o2 = [o2]\n    }\n    for (var i = 0; i < o2.length; i++) {\n        var example = o2[i]['metadata'];\n        for (var key in example) {\n            if (i == 0)\n                commonMetadata[key] = example[key];\n            else {\n                if (!(commonMetadata[key] == example[key])) {\n                    delete commonMetadata[key]\n                }\n            }\n        }\n        for (var key in commonMetadata) {\n            if (!(key in example)) {\n                delete commonMetadata[key]\n            }\n        }\n    }\n    if (!Array.isArray(o1)) {\n        o1 = setMetadata(o1, commonMetadata)\n    } else {\n        for (var i = 0; i < o1.length; i++) {\n            o1[i] = setMetadata(o1[i], commonMetadata)\n        }\n    }\n    return o1;\n};\n"
                        ]
                    }
                ],
                "hints": [
                    {
                        "class": "sbg:saveLogs",
                        "value": "path.log"
                    },
                    {
                        "class": "sbg:saveLogs",
                        "value": "job.tree.log"
                    }
                ],
                "stdout": "path.log",
                "sbg:toolAuthor": "Heng Li (Sanger Institute), Bob Handsaker (Broad Institute), Jue Ruan (Beijing Genome Institute), Colin Hercus, Petr Danecek",
                "sbg:toolkit": "SAMtools",
                "sbg:image_url": null,
                "sbg:toolkitVersion": "1.9",
                "sbg:cmdPreview": "/opt/samtools-1.9/samtools index /path/to/file.bam",
                "sbg:links": [
                    {
                        "id": "http://www.htslib.org/",
                        "label": "Homepage"
                    },
                    {
                        "id": "https://github.com/samtools/samtools",
                        "label": "Source Code"
                    },
                    {
                        "id": "https://github.com/samtools/samtools/wiki",
                        "label": "Wiki"
                    },
                    {
                        "id": "https://sourceforge.net/projects/samtools/files/",
                        "label": "Download"
                    },
                    {
                        "id": "http://www.ncbi.nlm.nih.gov/pubmed/19505943",
                        "label": "Publication"
                    },
                    {
                        "id": "http://www.htslib.org/doc/samtools-1.9.html",
                        "label": "Documentation"
                    }
                ],
                "sbg:license": "MIT License",
                "sbg:categories": [
                    "Utilities",
                    "SAM/BAM Processing"
                ],
                "sbg:projectName": "SBG Public Data",
                "sbg:revisionsInfo": [
                    {
                        "sbg:revision": 0,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1576244126,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 1,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1576244282,
                        "sbg:revisionNotes": "Final version"
                    },
                    {
                        "sbg:revision": 2,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1576244282,
                        "sbg:revisionNotes": "Description and tool default values edited."
                    },
                    {
                        "sbg:revision": 3,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1576244282,
                        "sbg:revisionNotes": "English edited and CWL1.0 tag added."
                    },
                    {
                        "sbg:revision": 4,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1576244282,
                        "sbg:revisionNotes": "Set default value for index_file_format"
                    },
                    {
                        "sbg:revision": 5,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1576244283,
                        "sbg:revisionNotes": "Description edited - references put before full stop"
                    },
                    {
                        "sbg:revision": 6,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1576244283,
                        "sbg:revisionNotes": "Categories edited"
                    },
                    {
                        "sbg:revision": 7,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1648038713,
                        "sbg:revisionNotes": "categories update"
                    }
                ],
                "sbg:expand_workflow": false,
                "sbg:appVersion": [
                    "v1.0"
                ],
                "sbg:id": "admin/sbg-public-data/samtools-index-1-9-cwl1-0/7",
                "sbg:revision": 7,
                "sbg:revisionNotes": "categories update",
                "sbg:modifiedOn": 1648038713,
                "sbg:modifiedBy": "admin",
                "sbg:createdOn": 1576244126,
                "sbg:createdBy": "admin",
                "sbg:project": "admin/sbg-public-data",
                "sbg:sbgMaintained": false,
                "sbg:validationErrors": [],
                "sbg:contributors": [
                    "admin"
                ],
                "sbg:latestRevision": 7,
                "sbg:publisher": "sbg",
                "sbg:content_hash": "a6633cffcabea34ecfa3d5e317cf7fc0868606440efc20537a0aa024a556c24b8",
                "sbg:workflowLanguage": "CWL"
            },
            "label": "Samtools Index CWL1.0",
            "sbg:x": 1573.8148193359375,
            "sbg:y": 25.38715934753418
        }
    ],
    "requirements": [
        {
            "class": "InlineJavascriptRequirement"
        },
        {
            "class": "StepInputExpressionRequirement"
        }
    ],
    "sbg:projectName": "testproject",
    "sbg:revisionsInfo": [
        {
            "sbg:revision": 0,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709084989,
            "sbg:revisionNotes": null
        },
        {
            "sbg:revision": 1,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709085329,
            "sbg:revisionNotes": ""
        },
        {
            "sbg:revision": 2,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709087793,
            "sbg:revisionNotes": "v1.0"
        },
        {
            "sbg:revision": 3,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709090272,
            "sbg:revisionNotes": "v1.0"
        },
        {
            "sbg:revision": 4,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709090341,
            "sbg:revisionNotes": ""
        },
        {
            "sbg:revision": 5,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709102264,
            "sbg:revisionNotes": ""
        },
        {
            "sbg:revision": 6,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709102270,
            "sbg:revisionNotes": ""
        },
        {
            "sbg:revision": 7,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709102317,
            "sbg:revisionNotes": "2"
        },
        {
            "sbg:revision": 8,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709172668,
            "sbg:revisionNotes": ""
        },
        {
            "sbg:revision": 9,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709182365,
            "sbg:revisionNotes": ""
        },
        {
            "sbg:revision": 10,
            "sbg:modifiedBy": "global-product-center/wangxuehan",
            "sbg:modifiedOn": 1709191630,
            "sbg:revisionNotes": ""
        }
    ],
    "sbg:image_url": "https://igor.sbgenomics.com/ns/brood/images/global-product-center/testproject/test/10.png",
    "sbg:appVersion": [
        "v1.2",
        "sbg:draft-2",
        "v1.0",
        "v1.1"
    ],
    "id": "https://api.sbgenomics.com/v2/apps/global-product-center/testproject/test/10/raw/",
    "sbg:id": "global-product-center/testproject/test/10",
    "sbg:revision": 10,
    "sbg:revisionNotes": "",
    "sbg:modifiedOn": 1709191630,
    "sbg:modifiedBy": "global-product-center/wangxuehan",
    "sbg:createdOn": 1709084989,
    "sbg:createdBy": "global-product-center/wangxuehan",
    "sbg:project": "global-product-center/testproject",
    "sbg:sbgMaintained": false,
    "sbg:validationErrors": [],
    "sbg:contributors": [
        "global-product-center/wangxuehan"
    ],
    "sbg:latestRevision": 10,
    "sbg:publisher": "sbg",
    "sbg:content_hash": "af3179f0be5acdece0c5d71759f3830b357611f7120873b47c599f8508c8297b5",
    "sbg:workflowLanguage": "CWL"
}
