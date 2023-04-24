#include <iostream>
#include <fstream>
#include <sstream>
#include <unordered_map>
#include <cstring>
#include <vector>
#include <cmath>
#include <string>
#include <filesystem>

struct filelist {
    std::string raw_variants;
    std::string variant_function;
    std::string exonic_variant_function;
};

struct vcf_stats {
    std::vector<uint64_t> sample_var_num;
    std::vector<uint64_t> sample_qual_num;
    std::vector<uint64_t> sample_rd_num;
    std::vector<uint64_t> sample_distance_num;
    std::vector<uint64_t> sample_ts_num;
    std::vector<uint64_t> sample_tv_num;
    std::vector<uint64_t> sample_het_num;
    std::vector<uint64_t> sample_hom_num;

    //types = ["C:G>A:T","C:G>G:C","C:G>T:A","T:A>A:T","T:A>C:G","T:A>G:C"]
    std::vector<uint64_t> sample_cgAT_num;
    std::vector<uint64_t> sample_cgGC_num;
    std::vector<uint64_t> sample_cgTA_num;
    std::vector<uint64_t> sample_taAT_num;
    std::vector<uint64_t> sample_taCG_num;
    std::vector<uint64_t> sample_taGC_num;
};

// 9 ~ NF: sample
std::vector<std::string> sample_index;
int maxQual=600, maxRdSup=60, maxDis=300;

//                CA 17217
//                GT 18260
//                CG 17223
//                GC 18243
//                CT 17236
//                GA 18241
//                TA 21569
//                AT 16724
//                TC 21571
//                AG 16711
//                TG 21575
//                AC 16707
// 使用 constexpr 定义常量，避免魔法数字
constexpr int CA = 17217;
constexpr int GT = 18260;
constexpr int CG = 17223;
constexpr int GC = 18243;
constexpr int CT = 17236;
constexpr int GA = 18241;
constexpr int TA = 21569;
constexpr int AT = 16724;
constexpr int TC = 21571;
constexpr int AG = 16711;
constexpr int TG = 21575;
constexpr int AC = 16707;


int read_file_list(const std::string_view& snp_file, filelist& filelist) {
    std::ifstream file(snp_file.data());
    std::string line;
    if (!file) {
        std::cerr << "Failed to open file: " << snp_file << "\n";
        return 1;
    }

    while (std::getline(file, line)) {
        std::istringstream iss(line);
        std::string raw_variants, variant_function, exonic_variant_function;
        iss >> raw_variants >> variant_function >> exonic_variant_function;
        filelist = {
                raw_variants, variant_function, exonic_variant_function
        };
    }
    return 0;
}


int read_vcf_header(const std::string_view& vcf_file) {
    std::ifstream file(vcf_file.data(), std::ios::binary);
    std::string line;
    if (!file) {
        std::cerr << "Failed to open file: " << vcf_file << "\n";
        return 1;
    }
    while (std::getline(file, line)) {
        std::string_view line_view(line);
        if (line_view.find("#CHROM",0) != std::string::npos) {
            size_t pos = 0; // 当前位置
            size_t tab; // 下一个TAB字符的位置
            while ((tab = line_view.find('\t', pos)) != std::string::npos) {
                std::string_view value = line_view.substr(pos, tab - pos); // 提取子字符串
                sample_index.emplace_back(value);
//                std::cout << value << "\t";
                pos = tab + 1; // 更新当前位置
            }
            std::string_view value = line_view.substr(pos); // 提取最后一个子字符串（可能包含换行符）
            sample_index.emplace_back(value);
//            std::cout << value << std::endl;
            return 0;
        }
    }
    return 1;
}


int read_vcf(const std::string_view& vcf_file, vcf_stats &vcf_stats) {
    std::ifstream file(vcf_file.data(), std::ios::binary);
    std::string line;
    if (!file) {
        std::cerr << "Failed to open file: " << vcf_file << "\n";
        return 1;
    }
    // 设置一个合适的输入缓冲区大小，这里假设为1MB
    constexpr size_t buffer_size = 1024 * 1024;
    char buffer[buffer_size];
    file.rdbuf()->pubsetbuf(buffer, buffer_size);

    uint64_t before_pos = -1;
    std::string_view before_chr;

    while (std::getline(file, line)) {
        if (line.empty() || line[0] == '#') {
            continue;
        }
        int col_num = 0;
        size_t pos = 0; // 当前位置
        size_t tab; // 下一个TAB字符的位置
        int qual = 0;
        int dp = 0;
        std::string_view line_view(line);

        bool have_gt4 = false;
        uint64_t now_pos;
        std::string_view now_chr;
        bool le_maxDis = false;
        char ref;
        char alt;
        bool is_ts = false;
        bool hom = false;
        std::vector<uint64_t> *sample_mask_num;
        uint64_t dis;

        while ((tab = line_view.find('\t', pos)) != std::string::npos) {
            std::string_view value = line_view.substr(pos, tab - pos); // 提取子字符串
            if (col_num == 0) {
                now_chr = value;
            } else if (col_num == 1) {
                now_pos = std::stoull(value.data());
                if (before_pos != -1 && before_chr == now_chr) {
                    dis = now_pos - before_pos;
                    if (dis <= maxDis) {
                        le_maxDis = true;
                    }
                }
            } else if (col_num == 5) {
                if (value==".") {
                    qual = 0;
                } else {
                    qual = std::floor(std::stof(value.data()));
                }
            } else if (col_num == 3) {
                ref = value[0];
            } else if (col_num == 4) {
                alt = value[0];
//                if (ref=='A'&&alt=='G' || ref=='C'&&alt=='T') {
//                    is_ts = true;
//                }
//                CA 17217
//                GT 18260
//                CG 17223
//                GC 18243
//                CT 17236
//                GA 18241
//                TA 21569
//                AT 16724
//                TC 21571
//                AG 16711
//                TG 21575
//                AC 16707
                int uniq_8bit = ref << 8 | alt;
                if (uniq_8bit==16711 || uniq_8bit==17236) {
                    is_ts = true;
                }
//                if (uniq_8bit==17217 || uniq_8bit==18260) {
//                    sample_mask_num = &vcf_stats.sample_cgAT_num;
//                } else if (uniq_8bit==17223 || uniq_8bit==18243) {
//                    sample_mask_num = &vcf_stats.sample_cgGC_num;
//                } else if (uniq_8bit==17236 || uniq_8bit==18241) {
//                    sample_mask_num = &vcf_stats.sample_cgTA_num;
//                } else if (uniq_8bit==21569 || uniq_8bit==16724) {
//                    sample_mask_num = &vcf_stats.sample_taAT_num;
//                } else if (uniq_8bit==21571 || uniq_8bit==16711) {
//                    sample_mask_num = &vcf_stats.sample_taCG_num;
//                } else if (uniq_8bit==21575 || uniq_8bit==16707) {
//                    sample_mask_num = &vcf_stats.sample_taGC_num;
//                }


                // 使用 switch-case 结构，提高可读性和效率
                switch (ref << 8 | alt) {
                    case CA:
                    case GT:
                        sample_mask_num = &vcf_stats.sample_cgAT_num;
                        break;
                    case CG:
                    case GC:
                        sample_mask_num = &vcf_stats.sample_cgGC_num;
                        break;
                    case CT:
                    case GA:
                        sample_mask_num = &vcf_stats.sample_cgTA_num;
                        break;
                    case TA:
                    case AT:
                        sample_mask_num = &vcf_stats.sample_taAT_num;
                        break;
                    case TC:
                    case AG:
                        sample_mask_num = &vcf_stats.sample_taCG_num;
                        break;
                    case TG:
                    case AC:
                        sample_mask_num = &vcf_stats.sample_taGC_num;
                        break;
                }
            } else if (col_num == 7) {
                size_t dp4;
                if ((dp4 = line_view.find("DP4=", pos)) != std::string::npos) {
                    have_gt4 = true;
                    dp = 0;
                    size_t dp_limit;
                    if ((dp_limit = line_view.find(';', dp4+1)) != std::string::npos ||
                        (dp_limit = line_view.find_first_of("\t ", dp4+1)) != std::string::npos) {
                        size_t p = dp4+1;
                        size_t p_step;
                        int count = 0;
                        while ((p_step = line_view.find(',',p)) != std::string::npos) {
                            std::string_view dp_part;
                            if (p_step < dp_limit) {
                                dp_part = line_view.substr(p, p_step - p); // 提取子字符串
                            } else {
                                dp_part = line_view.substr(p, dp_limit - p); // 提取子字符串
                            }

                            p = p_step + 1;
                            ++count;
                            if (count == 3 || count == 4) {
                                dp += std::floor(std::stof(dp_part.data()));
                            }
                        }
                    }
                }
            } else if (col_num > 8) {
                size_t p_first;
                std::string_view gt_value;
                if ((p_first = value.find(':', 0)) != std::string::npos) {
                    gt_value = value.substr(0, p_first);
                    size_t gt_second;
                    if ((gt_second = gt_value.find('/', 1)) != std::string::npos) {
                        std::string_view alleles_f = gt_value.substr(0, gt_second);
                        std::string_view alleles_s = gt_value.substr(gt_second+1, p_first);
                        if (alleles_f == alleles_s) {
                            hom = true;
                        }
                    }
                }
                if (gt_value != "0/0" && gt_value != "./.") {
                    // 找到DP
                    if (!have_gt4) {
                        dp = 0;
//                        size_t p_first;
                        size_t p_second;
                        // 从当前pos开始找: p_step+1即第一个:后面的内容
                        if ((p_first = value.find(':', 0)) != std::string::npos) {
                            if ((p_second = value.find(':', p_first+1)) != std::string::npos) {
                                std::string_view ad_value = value.substr(p_first+1, p_second-p_first-1);
                                size_t p;
                                size_t p_second_part = 0;
                                std::string_view dp_part;
                                int count = 0;
                                // p_second是：后面开始
                                while ((p = ad_value.find(',',p_second_part)) != std::string::npos) {
                                    dp_part = ad_value.substr(p_second_part, p-p_second_part);
                                    if (count == 0 || count == 1) {
                                        dp = std::floor(std::stof(dp_part.data()));
//                                    } else {
//                                        dp += std::floor(std::stof(dp_part.data()));
                                    }
                                    ++count;
                                    p_second_part = p + 1;
                                }
                                dp_part = ad_value.substr(p_second_part, p-p_second_part);
                                if (count == 0 || count == 1) {
                                    dp = std::floor(std::stof(dp_part.data()));
//                                } else {
//                                    dp += std::floor(std::stof(dp_part.data()));
                                }
                            }
                        }
                    }
//                    std::cout << value << " DP1:" << dp <<std::endl;
                    ++vcf_stats.sample_var_num[col_num];
                    if (qual <= maxQual) {
                        ++vcf_stats.sample_qual_num[col_num*maxQual + qual];
                    }
                    if (dp <= maxRdSup) {
                        ++vcf_stats.sample_rd_num[col_num*maxRdSup + dp];
                    }
                    if (le_maxDis) {
                        ++vcf_stats.sample_distance_num[col_num*maxDis + dis];
                    }
                    if (is_ts) {
                        ++vcf_stats.sample_ts_num[col_num];
                    } else {
                        ++vcf_stats.sample_tv_num[col_num];
                    }
                    if (hom) {
                        ++vcf_stats.sample_hom_num[col_num];
                    } else {
                        ++vcf_stats.sample_het_num[col_num];
                    }
                    ++sample_mask_num->at(col_num);
                }
            }
            pos = tab + 1; // 更新当前位置
            ++col_num;
        } // 列循环
        size_t p_first;
        std::string_view gt_value;
        std::string_view value = line_view.substr(pos, tab - pos); // 提取子字符串
        if ((p_first = value.find(':', 0)) != std::string::npos) {
            gt_value = value.substr(0, p_first);
            size_t gt_second;
            if ((gt_second = gt_value.find('/', 1)) != std::string::npos) {
                std::string_view alleles_f = gt_value.substr(0, gt_second);
                std::string_view alleles_s = gt_value.substr(gt_second+1, p_first);
                if (alleles_f == alleles_s) {
                    hom = true;
                }
            }
        }
        if (gt_value != "0/0" && gt_value != "./.") {
            // 找到DP
            if (!have_gt4) {
                dp = 0;
//                size_t p_first;
                size_t p_second;
                if ((p_first = value.find(':', 0)) != std::string::npos) {
                    if ((p_second = value.find(':', p_first+1)) != std::string::npos) {
                        std::string_view ad_value = value.substr(p_first+1, p_second-p_first-1);
                        size_t p;
                        size_t p_second_part = 0;
                        std::string_view dp_part;
                        int count = 0;
                        // p_second是：后面开始
                        while ((p = ad_value.find(',',p_second_part)) != std::string::npos) {
                            dp_part = ad_value.substr(p_second_part, p-p_second_part);
                            if (count == 0 || count == 1) {
                                dp = std::floor(std::stof(dp_part.data()));
//                            } else {
//                                dp += std::floor(std::stof(dp_part.data()));
                            }
                            ++count;
                            p_second_part = p + 1;
                        }
                        dp_part = ad_value.substr(p_second_part, p-p_second_part);
                        if (count == 0 || count == 1) {
                            dp = std::floor(std::stof(dp_part.data()));
//                        } else {
//                            dp += std::floor(std::stof(dp_part.data()));
                        }
                    }
                }
            }
//            std::cout << " DP2:" << dp <<std::endl;
            ++vcf_stats.sample_var_num[col_num];
            if (qual <= maxQual) {
                ++vcf_stats.sample_qual_num[col_num*maxQual + qual];
            }
            if (dp <= maxRdSup) {
                ++vcf_stats.sample_rd_num[col_num*maxRdSup + dp];
            }
            if (le_maxDis) {
                ++vcf_stats.sample_distance_num[col_num*maxDis + dis];
            }
            if (is_ts) {
                ++vcf_stats.sample_ts_num[col_num];
            } else {
                ++vcf_stats.sample_tv_num[col_num];
            }
            if (hom) {
                ++vcf_stats.sample_hom_num[col_num];
            } else {
                ++vcf_stats.sample_het_num[col_num];
            }
            ++sample_mask_num->at(col_num);
        }
        before_pos = now_pos;
        before_chr = now_chr;
//        value = line_view.substr(pos); // 提取最后一个子字符串（可能包含换行符）
//        cout << value << endl; // 输出或处理子字符串
    } // 行循环

    return 0;
}


void open(FILE** file_handle, std::initializer_list<std::filesystem::path> il) {
    std::filesystem::path open_file{};
    for (const auto& i : il) {
        const std::filesystem::path& tmp{i};
        if (open_file.empty()) {
            open_file = tmp;
        } else {
            open_file /= tmp;
        }
    }
    *file_handle = fopen(open_file.c_str(), "w");
}


int write_out(std::string_view &outdir, vcf_stats &vcf_stats) {
    FILE *snp_qual = nullptr;
    FILE *snp_reads_num = nullptr;
    FILE *snp_distance = nullptr;

    open(&snp_qual, {outdir, "SNP.quality"});
    open(&snp_reads_num, {outdir, "SNP.readsNum"});
    open(&snp_distance, {outdir, "SNP.distance"});

    fprintf(snp_qual, "Quality");
    fprintf(snp_reads_num, "ReadsNum");
    fprintf(snp_distance, "Distance");
    for (int j = 9; j < sample_index.size(); ++j) {
        fprintf(snp_qual, "\t%s", sample_index[j].c_str());
        fprintf(snp_reads_num, "\t%s", sample_index[j].c_str());
        fprintf(snp_distance, "\t%s", sample_index[j].c_str());
    }
    fprintf(snp_qual, "\n");
    fprintf(snp_reads_num, "\n");
    fprintf(snp_distance, "\n");


    std::vector<double> sample_total{static_cast<double>(sample_index.size()),0.0};
    for (int i=1; i<=maxQual; i++) {
        fprintf(snp_qual, "%d", i);
        for (int j = 9; j < sample_index.size(); ++j) {
            double ratio = static_cast<double>(vcf_stats.sample_qual_num[j*maxQual + i])
                                /static_cast<double>(vcf_stats.sample_var_num[j]) * 100;
            sample_total[j] += ratio;
            fprintf(snp_qual, "\t%.14f", sample_total[j]);
        }
        fprintf(snp_qual, "\n");
    }
    fclose(snp_qual);
    sample_total.clear();


    for (int i=1; i<=maxRdSup; i++) {
        fprintf(snp_reads_num, "%d", i);
        for (int j = 9; j < sample_index.size(); ++j) {
            double ratio = static_cast<double>(vcf_stats.sample_rd_num[j*maxRdSup + i])
                                /static_cast<double>(vcf_stats.sample_var_num[j]) * 100;
            sample_total[j] += ratio;
            fprintf(snp_reads_num, "\t%.14f", sample_total[j]);
        }
        fprintf(snp_reads_num, "\n");
    }
    fclose(snp_reads_num);
    sample_total.clear();


    for (int i=1; i<=maxDis; i++) {
        fprintf(snp_distance, "%d", i);
        for (int j = 9; j < sample_index.size(); ++j) {
            double ratio = static_cast<double>(vcf_stats.sample_distance_num[j*maxDis + i])
                                /static_cast<double>(vcf_stats.sample_var_num[j]) * 100;
            sample_total[j] += ratio;
            fprintf(snp_distance, "\t%.14f", sample_total[j]);
        }
        fprintf(snp_distance, "\n");
    }
    fclose(snp_distance);
    sample_total.clear();

    return 0;
}


int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s [snp|indel] [filelist] [outdir] \\\n"
                        "\t\t[maxQual=600] [maxRdSup=60] [maxDis=300]\n\n"
                        "Any questions please contact wangxuehan@novogene.com\n", argv[0]);
        exit(1);
    }
    std::string_view outdir = argv[2];
    if (argc > 3) {
        maxQual = std::stoi(argv[3]);
    }
    if (argc > 4) {
        maxRdSup = std::stoi(argv[4]);
    }
    if (argc > 5) {
        maxDis = std::stoi(argv[5]);
    }
    int ret;
    filelist filelist{};
    vcf_stats vcf_stats{};
//    read_file_list(argv[1],filelist);
    read_vcf_header(argv[1]);
    vcf_stats.sample_var_num.resize(sample_index.size(),0);
    vcf_stats.sample_qual_num.resize(sample_index.size()*maxQual,0);
    vcf_stats.sample_rd_num.resize(sample_index.size()*maxRdSup,0);
    vcf_stats.sample_distance_num.resize(sample_index.size()*maxDis,0);
    vcf_stats.sample_ts_num.resize(sample_index.size(),0);
    vcf_stats.sample_tv_num.resize(sample_index.size(),0);
    vcf_stats.sample_het_num.resize(sample_index.size(),0);
    vcf_stats.sample_hom_num.resize(sample_index.size(),0);
    vcf_stats.sample_cgAT_num.resize(sample_index.size(),0);
    vcf_stats.sample_cgGC_num.resize(sample_index.size(),0);
    vcf_stats.sample_cgTA_num.resize(sample_index.size(),0);
    vcf_stats.sample_taAT_num.resize(sample_index.size(),0);
    vcf_stats.sample_taCG_num.resize(sample_index.size(),0);
    vcf_stats.sample_taGC_num.resize(sample_index.size(),0);
    ret = read_vcf(argv[1],vcf_stats);
    ret = (ret == 0) ? write_out(outdir, vcf_stats) : 1;
    return ret;
}
