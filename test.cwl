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
