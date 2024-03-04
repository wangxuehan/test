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
                        "fastp_0_20_1/out_trimmed_reads"
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
        }
