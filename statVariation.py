#!/usr/bin/env python 
# -*- coding:utf-8 -*-
from __future__ import division
import os
import argparse
import sys
import re
import collections
from argparse import RawTextHelpFormatter

###Name:    statVariation.py
###Author:    Zheng Yabiao
###Usage:    Aims to statistics SNP/InDel/SV/CNV information from variation result and annotation files.
###Data:    2016.11.29

parser = argparse.ArgumentParser(description="vcf counts", formatter_class=RawTextHelpFormatter)
parser.add_argument('--snp', help="snp result list. One line has three parts, *filter.snp.vcf,*snp.avinput.variant_function,*snp.avinput.exonic_variant_function")
parser.add_argument('--indel', help="indel result list. One line has three parts, *filter.indel.vcf,*indel.avinput.variant_function,*indel.avinput.exonic_variant_function")
parser.add_argument('--sv', help="sv result list for breakdancer. One line has three parts, *filted.ctx,*avinput.variant_function,*avinput.exonic_variant_function") 
parser.add_argument('--cnv', help="cnv result list for cnvnator. One line has three parts, *cnv,*avinput.variant_function,*avinput.exonic_variant_function")
parser.add_argument('--maxRdSup', help='the max value of a variation support reads used to plot',default="60")
parser.add_argument('--maxQual', help='the max value of a variation quality used to plot',default="600")
parser.add_argument('--maxDis', help='the max distance of neighboring SNPs',default="300")
parser.add_argument('--refleng', help='the length of reference genome without N',required=True)
parser.add_argument('--odir', help='out dir')
argv = vars(parser.parse_args())

snp = argv['snp']
indel = argv['indel']
sv = argv['sv']
cnv = argv['cnv']
refleng = argv['refleng'].strip()
maxRdSup = argv['maxRdSup'].strip()
maxQual = argv['maxQual'].strip()
maxDis = argv['maxDis'].strip()

if not snp and not indel and not sv and not cnv:
    sys.exit(1)

if argv['odir']:
    odir = argv['odir']
else:
    odir = os.getcwd()

if not os.path.exists(odir):
    assert not os.makedirs(odir)

def safe_open(file_name,mode):
    try:
        if not file_name.endswith('.gz'):
            return open(file_name,mode)
        else:
            import gzip
            return gzip.open(file_name,mode)
    except IOError:
        print file_name + ' does not exist!'

def isTs(ref,alt):
    geno = ref.upper()+alt.upper()
    if re.match("^[AG]+$",geno) or re.match("^[CT]+$",geno):
        return 1
    else:
        return 0

def list_append(list,seq):
    if not seq in list:
        list.append(seq)

def dict_add(dict,key,value,initial):
    if dict.has_key(key):
        dict[key] += value
    else:
        dict[key] = initial

def dict_initial(key,*dicts):
    for dict in dicts:
        dict[key] = {}

def accum_ratio(dict,query_dict,sam_list,max,total_num_list):
    for i in range(1,int(max)+1):
        dict_initial(i,dict)
    for s in sam_list:
        ratio = 0
        for i in range(1,int(max)+1):
            if query_dict[s].has_key(i):
                ratio += query_dict[s][i]/total_num_list[s]*100
            
            dict[i][s] = ratio

def ratio_write(outfile,title,samples,dict,list):
    with safe_open(outfile,"w") as result:
        result.writelines(title+"\t"+"\t".join(samples)+"\n")
        for value in list:
            result.writelines(str(value))
            for sam in samples:
                result.writelines("\t"+str(dict[value][sam]))
            result.writelines("\n")
    result.close()

def plotSNPdist(input,name,main,xlab,ylab,output,type=""):
    if type == "fre":
        code = '''library("ggplot2")
library(scales)
cols<-c(brewer_pal(palette="Set2")(8),brewer_pal(palette="Set3")(12),brewer_pal(palette="Accent")(8),brewer_pal(palette="Paired")(12))
data <- read.table("%s.data", header=T)
p<-ggplot(data, aes(x=X,y=Y,fill=factor(Sample)))+geom_bar(position = 'dodge', stat='identity')+coord_flip()+labs(list(title="%s",x="%s",y="%s"))+scale_color_manual(values=cols)+guides(color=guide_legend(title="Sample",nrow = 24))+theme(panel.grid.major =element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line=element_line())
ggsave(filename="%s.png", type='cairo',plot=p)
ggsave(filename="%s.pdf",plot=p)
''' %(input,main,xlab,ylab,input,input)
    else:
        code = '''library(ggplot2)
library(reshape2)
library(scales)
cols<-c(brewer_pal(palette="Set2")(8),brewer_pal(palette="Set3")(12),brewer_pal(palette="Accent")(8),brewer_pal(palette="Paired")(12))
data <- read.table("%s",header=T)
change <- melt(data,id=c("%s"))
p<-ggplot(change,aes(x=%s,y=value,colour=factor(variable)))+geom_line(stat = "identity")+labs(list(title="%s",x="%s",y="%s"))+scale_color_manual(values=cols)+guides(color=guide_legend(title="Sample",nrow = 24))+theme(panel.grid.major =element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line=element_line())
ggsave(filename="%s.png", type='cairo',plot=p)
ggsave(filename="%s.pdf",plot=p)
''' %(input,name,name,main,xlab,ylab,input,input)
    
    with safe_open(output,"w") as shell:
        shell.writelines(code+"\n")
    shell.close()
    os.system("R -f %s" %(output))

def plotSNPfreq(input,output,outdir):
    wclor = open(os.path.join(outdir,"cols.txt"),"w")
    colors = ["#036EB8","#539A34","#666464","#1FA1A0","#9F3075","#BC5C1D","#EEAA1E","#D1282C","#4F3D87","#007431","#004077","#632C16","#543005","#8C510A","#BF812D","#DFC27D","#F6E8C3","#F5F5F5","#C7EAE5","#80CDC1","#35978F","#01665E","#003C30","#8E0152","#C51B7D","#DE77AE","#F1B6DA","#FDE0EF","#F7F7F7","#E6F5D0","#B8E186","#7FBC41","#4D9221","#276419","#40004B","#762A83","#9970AB","#C2A5CF","#E7D4E8","#F7F7F7","#D9F0D3","#A6DBA0","#5AAE61","#1B7837","#00441B","#7F3B08","#B35806","#E08214","#FDB863","#FEE0B6","#F7F7F7","#D8DAEB","#B2ABD2","#8073AC","#542788","#2D004B","#67001F","#B2182B","#D6604D","#F4A582","#FDDBC7","#F7F7F7","#D1E5F0","#92C5DE","#4393C3","#2166AC","#053061","#67001F","#B2182B","#D6604D","#F4A582","#FDDBC7","#FFFFFF","#E0E0E0","#BABABA","#878787","#4D4D4D","#1A1A1A","#A50026","#D73027","#F46D43","#FDAE61","#FEE090","#FFFFBF","#E0F3F8","#ABD9E9","#74ADD1","#4575B4","#313695","#A50026","#D73027","#F46D43","#FDAE61","#FEE08B","#FFFFBF","#D9EF8B","#A6D96A","#66BD63","#1A9850","#006837","#9E0142","#D53E4F","#F46D43","#FDAE61","#FEE08B","#FFFFBF","#E6F598","#ABDDA4","#66C2A5","#3288BD","#5E4FA2","#7FC97F","#BEAED4","#FDC086","#FFFF99","#386CB0","#F0027F","#BF5B17","#666666","#1B9E77","#D95F02","#7570B3","#E7298A","#66A61E","#E6AB02","#A6761D","#666666","#A6CEE3","#1F78B4","#B2DF8A","#33A02C","#FB9A99","#E31A1C","#FDBF6F","#FF7F00","#CAB2D6","#6A3D9A","#FFFF99","#B15928","#FBB4AE","#B3CDE3","#CCEBC5","#DECBE4","#FED9A6","#FFFFCC","#E5D8BD","#FDDAEC","#F2F2F2","#B3E2CD","#FDCDAC","#CBD5E8","#F4CAE4","#E6F5C9","#FFF2AE","#F1E2CC","#CCCCCC","#E41A1C","#377EB8","#4DAF4A","#984EA3","#FF7F00","#FFFF33","#A65628","#F781BF","#999999","#66C2A5","#FC8D62","#8DA0CB","#E78AC3","#A6D854","#FFD92F","#E5C494","#B3B3B3","#8DD3C7","#FFFFB3","#BEBADA","#FB8072","#80B1D3","#FDB462","#B3DE69","#FCCDE5","#D9D9D9","#BC80BD","#CCEBC5","#FFED6F","#F7FBFF","#DEEBF7","#C6DBEF","#9ECAE1","#6BAED6","#4292C6","#2171B5","#08519C","#08306B","#F7FCFD","#E5F5F9","#CCECE6","#99D8C9","#66C2A4","#41AE76","#238B45","#006D2C","#00441B","#F7FCFD","#E0ECF4","#BFD3E6","#9EBCDA","#8C96C6","#8C6BB1","#88419D","#810F7C","#4D004B","#F7FCF0","#E0F3DB","#CCEBC5","#A8DDB5","#7BCCC4","#4EB3D3","#2B8CBE","#0868AC","#084081","#F7FCF5","#E5F5E0","#C7E9C0","#A1D99B","#74C476","#41AB5D","#238B45","#006D2C","#00441B","#FFFFFF","#F0F0F0","#D9D9D9","#BDBDBD","#969696","#737373","#525252","#252525","#000000","#FFF5EB","#FEE6CE","#FDD0A2","#FDAE6B","#FD8D3C","#F16913","#D94801","#A63603","#7F2704","#FFF7EC","#FEE8C8","#FDD49E","#FDBB84","#FC8D59","#EF6548","#D7301F","#B30000","#7F0000","#FFF7FB","#ECE7F2","#D0D1E6","#A6BDDB","#74A9CF","#3690C0","#0570B0","#045A8D","#023858","#FFF7FB","#ECE2F0","#D0D1E6","#A6BDDB","#67A9CF","#3690C0","#02818A","#016C59","#014636","#F7F4F9","#E7E1EF","#D4B9DA","#C994C7","#DF65B0","#E7298A","#CE1256","#980043","#67001F","#FCFBFD","#EFEDF5","#DADAEB","#BCBDDC","#9E9AC8","#807DBA","#6A51A3","#54278F","#3F007D","#FFF7F3","#FDE0DD","#FCC5C0","#FA9FB5","#F768A1","#DD3497","#AE017E","#7A0177","#49006A","#FFF5F0","#FEE0D2","#FCBBA1","#FC9272","#FB6A4A","#EF3B2C","#CB181D","#A50F15","#67000D","#FFFFE5","#F7FCB9","#D9F0A3","#ADDD8E","#78C679","#41AB5D","#238443","#006837","#004529","#FFFFD9","#EDF8B1","#C7E9B4","#7FCDBB","#41B6C4","#1D91C0","#225EA8","#253494","#081D58","#FFFFE5","#FFF7BC","#FEE391","#FEC44F","#FE9929","#EC7014","#CC4C02","#993404","#662506","#FFFFCC","#FFEDA0","#FED976","#FEB24C","#FD8D3C","#FC4E2A","#E31A1C","#BD0026","#800026"]
    for c in colors:
        wclor.write('"'+c+'"\n')
    code = '''library("ggplot2")
library(scales)
library(grid)
cols <- read.table("%s/cols.txt",stringsAsFactors = F)[,1]
data <- read.table('%s', header=T)
p<-ggplot(data, aes(x=X,y=Y,fill=factor(Sample)))+geom_bar(position = 'dodge', stat='identity')+coord_flip()+labs(list(title="SNP mutation type Distribution",x="Mutation type",y="SNP number"))+scale_fill_manual(values=cols)+guides(color=guide_legend(title="Sample",nrow = 40))+theme(legend.text = element_text(size = rel(0.5)), legend.key.size=unit(0.225,'cm'))+theme(panel.grid.major=element_line(colour=NA),panel.background = element_rect(fill = "transparent",colour = NA),plot.background = element_rect(fill = "transparent",colour = NA),panel.grid.minor = element_blank(),axis.line=element_line())
ggsave(filename="%s/SNP.frequency.xls.png", type='cairo',plot=p)
ggsave(filename="%s/SNP.frequency.xls.pdf",plot=p)
bjt <- read.table("%s", header=T, row.names=1)
a<-t(bjt)
b<-a/rowSums(a)
bar_dat <- data.matrix(b)
samples<-rownames(bar_dat)
rownames(bar_dat)<-NULL
fcol<-read.table("%s/cols.txt",stringsAsFactors = F)[,1]
png("%s/SNP.frequency.xls.barplot.png",type='cairo-png',height=480,width=max(480,nrow(bar_dat)*20+120))
par(mar=c(5,4,4,5),xpd=T)
barplot(t(bar_dat),col=fcol,space=0,beside=F,ylab="Fraction of Mutations",xlab="",border='white',main="Mutation Spectrum",cex.axis=1,cex.lab=1,cex.main=1.5,ylim=c(0,1),names.arg=rep('',nrow(bar_dat)))
text(1:length(samples),-0.015,labels=samples,srt=60,pos=2,xpd=T,cex=0.8)
legend(nrow(bar_dat),0.8,legend=colnames(bar_dat),cex=0.8,horiz=F,bty="n",fill=fcol,inset=c(-0.15,0))
pdf("%s/SNP.frequency.xls.barplot.pdf",height=5,width=max(5,nrow(bar_dat)*0.2+0.12))
''' %(outdir,input,outdir,outdir,input[:-5],outdir,outdir,outdir)
    
    with safe_open(output,"w") as shell:
        shell.writelines(code+"\n")
    shell.close()
    #os.system("R -f %s" %(output))

def plotInDelLen(input):
    code = '''library(ggplot2)
library(scales)
library(grid)
library(RColorBrewer)
colorNames <- rownames(brewer.pal.info)[c(1:3,10:17)]
colorNums <- brewer.pal.info[,1][c(1:3,10:17)]
colsx <- vector()
for(n in 1:11){
    colsx <- c(colsx,brewer.pal(colorNums[n],colorNames[n]))
}
cols <- sample(colsx,300,replace=T,set.seed(1927))
data <- read.table('%s.data', header=T)
if(length(data[,1])<40 && length(data[1,])<40){
    library(scales)
    cols<-c("#036EB8","#539A34","#666464","#1FA1A0")
}
p<-ggplot(data, aes(x=X,y=Y,fill=factor(Sample)))+scale_x_continuous(breaks=seq(0,21,1),limits=c(0.5,21.5))+geom_bar(stat='identity',position="dodge")+theme(panel.grid.minor=element_blank())+coord_flip()+labs(list(title="CDS InDel length Distribution",x="Length(bp)",y="Percentage(%%)"))+scale_fill_manual(values=cols)+guides(fill=guide_legend(title="Sample"))+theme(legend.text = element_text(size = rel(0.5)), legend.key.size=unit(0.225,'cm'))+theme(panel.grid.major =element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line=element_line())
ggsave(filename="%s.png", type='cairo',plot=p)
ggsave(filename="%s.pdf", plot=p)
''' %(input,input,input)

    with safe_open(input+".R","w") as shell:
        shell.writelines(code+"\n")
    shell.close()
    os.system("R -f %s" %(input+".R"))

def plotSVLen(input):

    code = '''library(ggplot2)
library(scales)
library(grid)
data <- read.table('%s.data', header=T)
data <- data[which(data$Sample %%in%% head(sort(unique(data$Sample)),4)),]
cols<-c("#036EB8","#539A34","#666464","#1FA1A0")
data$X <- factor(data$X, levels = data$X, ordered = TRUE)
p<-ggplot(data, aes(x=X,y=Y,fill=factor(Sample)))+geom_bar(position = 'dodge', stat='identity')+coord_flip()+labs(list(title="SV length Distribution",x="SV length(bp)",y="Percentage of SVs(%%)"))+scale_fill_manual(values=cols)+guides(fill=guide_legend(title="Sample"))+theme(legend.text = element_text(size = rel(0.5)), legend.key.size=unit(0.225,'cm'))+theme(panel.grid.major =element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line=element_line())
ggsave(filename="%s.png", type='cairo',plot=p)
ggsave(filename="%s.pdf", plot=p)
''' %(input,input,input)

    with safe_open(input+".R","w") as shell:
        shell.writelines(code+"\n")
    shell.close()
    os.system("R -f %s" %(input+".R"))
    
def plotSVtype(input):
    code = '''
    #lllll
library(methods)
library(ggplot2)
library(grid)
SVtable <- as.matrix(read.table("%s/SV.table.xls",header = F,sep = "\t"))

for(i in 2:ncol(SVtable)){
  sample <- data.frame(samplename=rep(SVtable[1,i],times = 5),TYPE=SVtable[9:13,1],Freq=SVtable[9:13,i],per=as.numeric(SVtable[9:13,i])/as.numeric(SVtable[14,i]))
  if(i==2){
    table = sample
  }else{
    table = rbind(table,sample)
  }
}

cols <- c("#036EB8","#539A34","#666464","#1FA1A0","#BC5C1D")
name = as.character(unique(table[,1]))
graph_out <- ggplot(table,aes(x=samplename,y=per,fill=TYPE)) +
    geom_bar(stat="identity") +
    theme_bw() + 
    scale_fill_manual(values = cols) +
    theme(panel.border = element_blank(),panel.grid.major = element_blank(),panel.grid.minor = element_blank(),axis.line = element_line(colour = "black"))+
    theme(axis.text.x = element_text(angle = 45,vjust = 1,hjust = 1))
ggsave("%s/SV_ann_Variation_type_statistics_distribution.pdf",graph_out)
ggsave(filename="%s/SV_ann_Variation_type_statistics_distribution.png",type="cairo-png",plot=graph_out)
    '''%(input,input,input)

    with safe_open(os.path.join(input,"SVtype.R"),"w") as shell:
        shell.writelines(code+"\n")
    shell.close()
    os.system("R -f %s" %(os.path.join(input,"SVtype.R")))
    
def plotCNVDis(input):
    code = '''library(ggplot2)
library(scales)
library(grid)
cols<-c("#036EB8","#539A34","#666464","#1FA1A0","#9F3075","#BC5C1D")
data <- read.table('%s.data', header=T)
p<-ggplot(data, aes(x=Sample, y=Number, fill = Category)) + geom_bar(position = 'dodge', stat='identity') + labs(title = 'CNV distribution')+scale_fill_manual(values=cols)+theme(axis.text.x=element_text(angle=60,size=rel(0.5),hjust=1),legend.text = element_text(size = rel(0.65)), legend.key.size=unit(0.35,'cm'))+theme(panel.grid.major =element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),axis.line=element_line())
ggsave(filename="%s.png", type='cairo',plot=p)
ggsave(filename="%s.pdf", plot=p)
''' %(input,input,input)

    with safe_open(input+".R","w") as shell:
        shell.writelines(code+"\n")
    shell.close()
    os.system("R -f %s" %(input+".R"))

def plotCNVtype(input):
    code = '''
#lllll
library(methods)
library(ggplot2)
library(grid)
CNVtable <- as.matrix(read.table("%s/CNV.table.xls",header = F,sep = "\t"))

for(i in 2:ncol(CNVtable)){
  sample <- data.frame(samplename=rep(CNVtable[1,i],times = 2),TYPE=c("Dup","Del"),Freq=CNVtable[8:9,i],per=as.numeric(CNVtable[8:9,i])/as.numeric(CNVtable[12,i]))
  if(i==2){
    table = sample
  }else{
    table = rbind(table,sample)
  }
}

cols <- c("#036EB8","#539A34")
name = as.character(unique(table[,1]))
graph_out <- ggplot(table,aes(x=samplename,y=per,fill=TYPE)) + 
    geom_bar(stat="identity") + scale_fill_manual(values = cols) +  theme_bw() + theme(panel.border = element_blank(),panel.grid.major = element_blank(),panel.grid.minor = element_blank(),axis.line = element_line(colour = "black")) + theme(axis.text.x = element_text(angle = 45,vjust = 1,hjust = 1))

ggsave("%s/CNV_ann_Variation_type_statistics_distribution.pdf",graph_out)
ggsave(filename="%s/CNV_ann_Variation_type_statistics_distribution.png",type="cairo-png",plot=graph_out)

    '''%(input,input,input)
    with safe_open(os.path.join(input,"CNVtype.R"),"w") as shell:
        shell.writelines(code+"\n")
    shell.close()
    os.system("R -f %s" %(os.path.join(input,"CNVtype.R")))
    
def table_out(dict,samples,name,outfile,key=""):
    with safe_open(outfile,"a") as result:
        result.writelines(name)
        for sam in samples:
            if key:
                if dict[sam].has_key(key):
                    result.writelines("\t%s" %(dict[sam][key]))
                else:
                    result.writelines("\t0")
            else:
                if dict.has_key(sam):
                    result.writelines("\t%s" %(dict[sam]))
                else:
                    result.writelines("\t0")
        result.writelines("\n")


if snp:
    samples = []
    quality = {} ##sample->quality=num
    quality_ratio = {} ##quality->sample=ratio
    support_reads = {}
    support_reads_ratio = {}
    distance = {}
    distance_ratio = {}
    tstv = collections.OrderedDict()
    tstv_ratio = collections.OrderedDict()
    hetero = {}
    hetero_ratio = collections.OrderedDict()
    total_num = {"Number of SNPs":0}
    mutation_type = {}
    anno_type = {}
    #only for samtools and joint call, detect by file position in the dir of JointGenotype yyd
    anno_joint_type = {}
    for line in safe_open(snp,'r'):
        files = line.strip().split()
        vcf_location = {} ##samples location and name in vcf files
        av_location = {}  ##ssamples location and name in variant_function files
        exonic_location = {} ##ssamples location and name in exonic_variant_function files
        #vcf
        start = 0
        chr = "0"
        start_tmp = 0
        for site in safe_open(files[0],'r'):
            if site.startswith("#CHROM"):
                heads = site.strip().split("\t")
                for record in range(9,len(heads)):
                    vcf_location[record] = heads[record]
                    #revised:zhangshouwei:11
                    av_location[record+11] = heads[record]
                    exonic_location[record+11] = heads[record]
                    list_append(samples,heads[record])
                    dict_initial(heads[record],quality,support_reads,distance,tstv,hetero,mutation_type)
                    total_num[heads[record]] = 0
            # def dict_add(dict,key,value,initial):
            #     if dict.has_key(key):
            #         dict[key] += value
            #     else:
            #         dict[key] = initial
            elif not site.startswith("#"):
                seq = site.strip().split("\t")
                start = start_tmp
                total_num["Number of SNPs"] += 1
                for i in sorted(vcf_location.keys()):
                    if not seq[int(i)].startswith('./.') and not seq[int(i)].startswith('0/0'):
                        total_num[vcf_location[i]] += 1
                        ##quality distribution
                        if int(float(seq[5])) <= maxQual:
                            dict_add(quality[vcf_location[i]],int(float(seq[5])),1,1)
                        ##support reads distribution
                        dp = re.search(r'DP4=(\d+),(\d+),(\d+),(\d+);',site)
                        if dp:
                            reads = int(dp.group(3))+int(dp.group(4))
                        else:
                            if len(seq[int(i)].split(":")[1].split(",")) > 1:
                                reads = seq[int(i)].split(":")[1].split(",")[1]
                            else:
                                reads = seq[int(i)].split(":")[1]
                        if reads <= maxRdSup:
                            dict_add(support_reads[vcf_location[i]],int(reads),1,1)
                        ##neighboring snp distance distribution
                        if not seq[0] == chr: 
                            chr = seq[0]
                        else:
                            dis = int(seq[1])-int(start)
                            if dis <= maxDis:
                                dict_add(distance[vcf_location[i]],int(dis),1,1)
                            start_tmp = seq[1]
                        ##ts/tv
                        ref = seq[3].split(",")[0] 
                        alt = seq[4].split(",")[0] 
                        if isTs(ref,alt):
                            dict_add(tstv[vcf_location[i]],"ts",1,1)
                        else:
                            dict_add(tstv[vcf_location[i]],"tv",1,1)
                        ##heterozygous
                        alleles=seq[int(i)].split(":")[0].split("/")
                        if not alleles[0] == alleles[1]:
                            dict_add(hetero[vcf_location[i]],"hete",1,1)
                        elif alleles[0] == alleles[1]:
                            dict_add(hetero[vcf_location[i]],"homo",1,1)
                        ##SNP mutation type distribution
                        bases = seq[4].split(",")
                        bases.insert(0,seq[3])
                       # type = bases[int(alleles[0])]+bases[int(alleles[1])]
                        type = bases[0]+bases[1]
                        dict_add(mutation_type[vcf_location[i]],type,1,1)
    
        #snp.avinput.variant_function
        #revised:zhangshouwei
        lastchr = ""
        lastpos = ""
        for site in safe_open(files[1],'r'):
            if site.startswith("#"):
                continue   
            seq = site.strip().split("\t")
            if not anno_type.has_key(seq[1]):
                anno_type[seq[1]] = {}
                anno_joint_type[seq[1]] = {}
            for i in sorted(av_location.keys()):
                if not seq[int(i)].startswith('./.') and not seq[int(i)].startswith('0/0') and not(seq[11] == lastchr and seq[12] ==lastpos):
                #if not seq[int(i)].startswith('./.') and not seq[int(i)].startswith('0/0'):
                    dict_add(anno_type[seq[1]],av_location[i],1,1)
                    dict_add(anno_joint_type[seq[1]],av_location[i],1,1)

            if re.search("/VarDetect/SnpInDel/JointGenotype/",files[1]) and not(seq[11] == lastchr and seq[12] ==lastpos):
                dict_add(anno_joint_type[seq[1]],"Number of SNPs",1,1)
            lastchr = seq[11]
            lastpos = seq[12]

        #snp.exonic_variant_function
        ##revised:zhangshouwei
        lastchr = ""
        lastpos = ""
        for site in safe_open(files[2],'r'):
            if site.startswith("#"):
                continue             
            seq = site.strip().split("\t")
            if not anno_type.has_key(seq[1]):
                anno_type[seq[1]] = {}
                anno_joint_type[seq[1]] = {}
            for i in sorted(exonic_location.keys()):
                if not seq[int(i)].startswith('./.') and not seq[int(i)].startswith('0/0') and not(seq[11] == lastchr and seq[12] ==lastpos):
                    dict_add(anno_type[seq[1]],exonic_location[i],1,1)
            if re.search("/VarDetect/SnpInDel/JointGenotype/",files[2]) and not(seq[11] == lastchr and seq[12] ==lastpos):
                dict_add(anno_joint_type[seq[1]],"Number of SNPs",1,1)
            lastchr = seq[11]
            lastpos = seq[12]
                    
    ##process rates including het rate, ts/tv, quality, reads number, neighbor snp distance.
    ###quality,reads number,distance
    snpdir = os.path.join(odir,"SNP")
    if not os.path.exists(snpdir):
        assert not os.makedirs(snpdir)

# def dict_initial(key,*dicts):
#     for dict in dicts:
#         dict[key] = {}

# def accum_ratio(dict,query_dict,sam_list,max,total_num_list):
#     for i in range(1,int(max)+1):
#         dict_initial(i,dict)
#     for s in sam_list:
#         ratio = 0
#         for i in range(1,int(max)+1):
#             if query_dict[s].has_key(i):
#                 ratio += query_dict[s][i]/total_num_list[s]*100
            
#             dict[i][s] = ratio

    accum_ratio(quality_ratio,quality,samples,maxQual,total_num)
    accum_ratio(support_reads_ratio,support_reads,samples,maxRdSup,total_num)
    accum_ratio(distance_ratio,distance,samples,maxDis,total_num)
    
    ratio_write(snpdir+"/SNP.quality","Quality",samples,quality_ratio,range(1,int(maxQual)+1))
    ratio_write(snpdir+"/SNP.readsNum","ReadsNum",samples,support_reads_ratio,range(1,int(maxRdSup)+1))
    ratio_write(snpdir+"/SNP.distance","Distance",samples,distance_ratio,range(1,int(maxDis)+1))
    #plotSNPdist(snpdir+"/SNP.quality","Quality","SNP quality distribution", "Quality", "SNP Percent(%)",snpdir+"/SNP.quality.R")
    #plotSNPdist(snpdir+"/SNP.readsNum","ReadsNum","SNP support reads number distribution", "Support reads number", "SNP percent(%)",snpdir+"/SNP.readsNum.R")
    #plotSNPdist(snpdir+"/SNP.distance","Distance","Neighboring SNP distance distribution","Neighboring SNP distance(bp)","SNP Percent(%)",snpdir+"/SNP.distance.R")
    ###ts/tv,het ratio
    for sam in samples:
        if not "ts" in tstv[sam] or not "tv" in tstv[sam]:
            tstv_ratio[sam] = "-"
        else:
            tstv_ratio[sam] = "%0.3f" %(tstv[sam]["ts"]/tstv[sam]["tv"]) 
        hetero_ratio[sam] = "%0.3f" %(hetero[sam].get("hete",0)*1000/int(refleng)) 
    ###mutation type result and plot
    types = ["C:G>A:T","C:G>G:C","C:G>T:A","T:A>A:T","T:A>C:G","T:A>G:C"]
    with safe_open(snpdir+"/SNP.frequency.xls","w") as result:
        result.writelines("\t"+"\t".join(samples)+"\n")
        for type in types:
            a = re.split(":|>",type)
            result.writelines(type)
            for sam in samples:
                result.writelines("\t%d" %(mutation_type[sam].get(a[0]+a[2],0)+mutation_type[sam].get(a[1]+a[3],0)))
            result.writelines("\n")

    with safe_open(snpdir+"/SNP.frequency.xls.data","w") as result:
        result.writelines("X\tY\tSample\n")
        for type in types:
            a = re.split(":|>",type)
            for sam in samples:
                result.writelines(type)
                result.writelines("\t%d\t%s\n" %(mutation_type[sam].get(a[0]+a[2],0)+mutation_type[sam].get(a[1]+a[3],0),sam))

#    plotSNPdist(snpdir+"/SNP.frequency.xls","","SNP mutation type Distribution","Mutation type","SNP number",snpdir+"/SNP.frequency.R","fre")
    #plotSNPfreq(snpdir+"/SNP.frequency.xls.data",snpdir+"/SNP.frequency.R",snpdir) #by Shouwei Zhang

    ##SNP.table.xls
    items = ["Upstream","missense","Exonic Stop gain","Exonic Stop loss","Exonic Synonymous","Exonic Non-synonymous","Exonic unknowns","Intronic","Splicing","Downstream","upstream/downstream","Intergenic"]
    itemsName = ["upstream","missense","stopgain","stoploss","synonymous SNV","nonsynonymous SNV","unknown","intronic","splicing","downstream","upstream;downstream","intergenic"]#"ts","tv","ts;tv","Hetrate","Total_SNP"]
    with safe_open(snpdir+"/SNP.table.xls","w") as result:
        result.writelines("Category\t"+"\t".join(samples)+"\n")
        for n1,n2 in zip(items,itemsName):
            result.writelines(n1)
            for sam in samples:
                if anno_type.has_key(n2) and anno_type[n2].has_key(sam):
                    result.writelines("\t%d" %(anno_type[n2][sam]))
                else:
                    result.writelines("\t0")
            result.writelines("\n")
        result.writelines("Others")
        for sam in samples:
            others = 0
            for k in  anno_type.keys():
                if k not in itemsName and k != "exonic":
                    others =   others + anno_type[k].get(sam,0)
            result.writelines("\t%d" %(others))
        result.writelines("\n")

    table_out(tstv,samples,"ts",snpdir+"/SNP.table.xls","ts")
    table_out(tstv,samples,"tv",snpdir+"/SNP.table.xls","tv")
    table_out(tstv_ratio,samples,"ts/tv",snpdir+"/SNP.table.xls")
    table_out(hetero_ratio,samples,"Het rate(‰)",snpdir+"/SNP.table.xls")
    table_out(total_num,samples,"Total",snpdir+"/SNP.table.xls")

    #for GN report data file
    with open(snpdir+"/SNP.table.xls","r") as snptabler:
         allsampleSNPtabledata = snptabler.readlines()

    allSNPtabledata = []

    items = ["Upstream","missense","Exonic Stop gain","Exonic Stop loss","Exonic Synonymous","Exonic Non-synonymous","Exonic unknowns","Intronic","Splicing","Downstream","upstream/downstream","Intergenic"]
    itemsName = ["upstream","missense","stopgain","stoploss","synonymous SNV","nonsynonymous SNV","unknown","intronic","splicing","downstream","upstream;downstream","intergenic"]#"ts","tv","ts;tv","Hetrate","Total_SNP"]
    #for GN jointcall total result
    if re.search("/VarDetect/SnpInDel/JointGenotype/",files[0]):
    #joint计算others
        jointothers = 0
        for k,v in anno_joint_type.items():
            if k not in itemsName and anno_joint_type[k]["Number of SNPs"] and k!= "exonic":
                jointothers = jointothers + anno_joint_type[k]["Number of SNPs"]

        jointtotalsnp = ["Number of SNPs"]
        for n1,n2 in zip(items,itemsName):
            if anno_joint_type.has_key(n2) and anno_joint_type[n2].has_key("Number of SNPs"):
                jointtotalsnp.append(anno_joint_type[n2]["Number of SNPs"])
            else:
                jointtotalsnp.append("0")
        jointtotalsnp.extend(["-","-","-","-","-",str(total_num["Number of SNPs"])])
        jointtotalsnp[13] = jointothers
        for snp,joint in zip(allsampleSNPtabledata,jointtotalsnp):
            allSNPtabledata.append(snp.strip("\n")+"\t"+str(joint)+"\n")
    else:
        allSNPtabledata = allsampleSNPtabledata

    gnshowdata = []
    indexname = []
    with safe_open(snpdir+"/snp_fun.xls","w") as result:
        for j in range(len(allSNPtabledata[0].strip("\n").split("\t"))):
            onesampleexonic = 0
            onesampleshowdata = []
            for i in range(len(allSNPtabledata)):
                if j == 0:
                    indexname.append(allSNPtabledata[i].strip("\n").split("\t")[j])
                else:
                    if allSNPtabledata[i].startswith("Exonic"):
                        onesampleexonic = onesampleexonic + int(allSNPtabledata[i].strip("\n").split("\t")[j])
                    onesampleshowdata.append(allSNPtabledata[i].strip("\n").split("\t")[j])
            if j != 0:
                onesampleshowdata.insert(3,onesampleexonic)
                gnshowdata.append(onesampleshowdata)

        indexname.insert(3,"Exonic")
        for b in [0,3,4,5,6,7,8,9,10,1,11,12,13,14,19]:
            name = indexname[b]
            writedata = [name]
            for a in range(len(gnshowdata)):
                writedata.append(str(gnshowdata[a][b]))
            result.write("\t".join(writedata)+"\n")


if indel:
    samples = []
    hetero = {}
    hetero_ratio = collections.OrderedDict()
    total_num = {"Number of InDels":1}
    total_num_CDS = {} #revised:20180314
    total_num_genome = {}
    indel_type = collections.OrderedDict()
    indel_length = {}
    indel_genome_length = {}
    indel_length_ratio = {} #revised:20180314
    indel_genome_length_ratio = {}
    anno_type = {}
    #only for samtools and joint call, detect by file position in the dir of JointGenotype yyd
    anno_joint_type = {}
    indel_type["Number of InDels"]={"Insertion":1}
    indel_type["Number of InDels"]={"Deletion":1}

    for line in safe_open(indel,'r'):
        vcf_location = {}
        av_location = {}
        exonic_location = {}
        files = line.strip().split()
        ##revised:zhangshouwei:11
        for site in safe_open(files[0],'r'):  ##vcf
            if site.startswith("#CHROM"):
                heads = site.strip().split("\t")
                for record in range(9,len(heads)):
                    vcf_location[record] = heads[record]
                    av_location[record+11] = heads[record]
                    exonic_location[record+11] = heads[record]
                    list_append(samples,heads[record])
                    dict_initial(heads[record],hetero,indel_type) 
                    #total_num[heads[record]] = 0
            elif not site.startswith("#"):
                seq = site.strip().split("\t")
                total_num["Number of InDels"] += 1
                for i in sorted(vcf_location.keys()):
                    if not seq[int(i)].startswith('./.') and not seq[int(i)].startswith('0/0'):
                        dict_add(total_num,vcf_location[i],1,1)
                        ##heterozygous
                        alleles=seq[int(i)].split(":")[0].split("/")
                        if not alleles[0] == alleles[1]:
                            dict_add(hetero[vcf_location[i]],"hete",1,1)
                        elif alleles[0] == alleles[1]:
                            dict_add(hetero[vcf_location[i]],"homo",1,1)
                        ##insertion/deletion 
                        bases = seq[4].split(",")
                        bases.insert(0,seq[3])
                        if len(bases[int(alleles[0])])+len(bases[int(alleles[1])])>2*len(seq[3]):
                            dict_add(indel_type[vcf_location[i]],"Insertion",1,1)
                        elif len(bases[int(alleles[0])])+len(bases[int(alleles[1])])<2*len(seq[3]):
                            dict_add(indel_type[vcf_location[i]],"Deletion",1,1)
                if re.search("/VarDetect/SnpInDel/JointGenotype/",files[0]):
                    if len(bases[int(alleles[0])])+len(bases[int(alleles[1])])>2*len(seq[3]):
                        dict_add(indel_type["Number of InDels"],"Insertion",1,1)
                    elif len(bases[int(alleles[0])])+len(bases[int(alleles[1])])<2*len(seq[3]):
                        dict_add(indel_type["Number of InDels"],"Deletion",1,1)
        #indel.variant_function
        ##revised:zhangshouwei
        lastchr = ""
        lastpos = ""
        lastannotype = ""
        for site in safe_open(files[1],'r'):
            if site.startswith("#"):
                continue
            seq = site.strip().split("\t")
            if not anno_type.has_key(seq[1]):
                anno_type[seq[1]] = {}
                anno_joint_type[seq[1]] = {}
            for i in sorted(av_location.keys()):
                if not seq[int(i)].startswith('./.') and not seq[int(i)].startswith('0/0') and not(seq[11] == lastchr and seq[12] == lastpos and seq[1] == lastannotype):
                    dict_add(anno_type[seq[1]],av_location[i],1,1)
                    dict_add(total_num_genome,av_location[i],1,1) #revised:20180314
                    indlen = len(seq[6]+seq[7])-1
                    if not indel_genome_length.has_key(indlen):
                        indel_genome_length[indlen] = {}
                    dict_add(indel_genome_length[indlen],av_location[i],1,1)
                    if not indel_genome_length_ratio.has_key(indlen):
                        dict_initial(indlen,indel_genome_length_ratio)
                    if indel_genome_length_ratio.has_key(indlen) and not indel_genome_length_ratio[indlen].has_key(av_location[i]):
                        dict_initial(av_location[i],indel_genome_length_ratio[indlen])
            if re.search("/VarDetect/SnpInDel/JointGenotype/",files[2]) and not(seq[11] == lastchr and seq[12] == lastpos and seq[1] == lastannotype):
                dict_add(anno_joint_type[seq[1]],"Number of InDels",1,1)
            lastchr = seq[11]
            lastpos = seq[12]
            lastannotype = seq[1]
        #indel.exonic_variant_function
        ##revised:zhangshouwei
        lastchr = ""
        lastpos = ""
        lastannotype = ""
        for site in safe_open(files[2],'r'):
            if site.startswith("#"):
                continue
            seq = site.strip().split("\t")
            if not anno_type.has_key(seq[1]):
                anno_type[seq[1]] = {}
                anno_joint_type[seq[1]] = {}
            for i in sorted(exonic_location.keys()):
                if not seq[int(i)].startswith('./.') and not seq[int(i)].startswith('0/0') and not(seq[11] == lastchr and seq[12] == lastpos and seq[1] == lastannotype):
                    dict_add(anno_type[seq[1]],exonic_location[i],1,1)
                    dict_add(total_num_CDS,exonic_location[i],1,1) #revised:20180314
                    indlen = len(seq[6]+seq[7])-1
                    if not indel_length.has_key(indlen):
                        indel_length[indlen] = {}
                    dict_add(indel_length[indlen],exonic_location[i],1,1)
                    if not indel_length_ratio.has_key(indlen):
                        dict_initial(indlen,indel_length_ratio)
                    if indel_length_ratio.has_key(indlen) and not indel_length_ratio[indlen].has_key(exonic_location[i]):
                        dict_initial(exonic_location[i],indel_length_ratio[indlen])
            if re.search("/VarDetect/SnpInDel/JointGenotype/",files[2]) and not(seq[11] == lastchr and seq[12] == lastpos and seq[1] == lastannotype):
                dict_add(anno_joint_type[seq[1]],"Number of InDels",1,1) 
            lastchr = seq[11]
            lastpos = seq[12]  
            lastannotype = seq[1]              
    ##process rates including het rate.
    ###quality,reads number,distance
    indeldir = os.path.join(odir,"InDel")
    if not os.path.exists(indeldir):
        assert not os.makedirs(indeldir)
    for sam in samples:
        hetero_ratio[sam] = "%0.3f" %(hetero[sam].get("hete",0)*1000/int(refleng))

    #obtain the length ratio in terms of indel number:20180314
    for i in sorted(indel_length.keys()):
        for sam in samples:
            if indel_length_ratio[i].has_key(sam):
                indel_length_ratio[i][sam] = str(indel_length[i][sam]*100/float(total_num_CDS[sam]))
            else:
                indel_length_ratio[i][sam] = "0"
                
    for i in sorted(indel_genome_length.keys()):
        for sam in samples:
            if indel_genome_length_ratio[i].has_key(sam):
                indel_genome_length_ratio[i][sam] = str(indel_genome_length[i][sam]*100/float(total_num_genome[sam]))
            else:
                indel_genome_length_ratio[i][sam] = "0"

    items = ["Upstream","Exonic Stop gain","Exonic Stop loss","Exonic Frameshift deletion","Exonic Frameshift insertion","Exonic Non-frameshift deletion","Exonic Non-frameshift insertion","Intronic","Splicing","Downstream","Upstream/Downstream","Intergenic"]

    itemsName = ["upstream","stopgain","stoploss","frameshift deletion","frameshift insertion","nonframeshift deletion","nonframeshift insertion","intronic","splicing","downstream","upstream;downstream","intergenic"]

    with safe_open(indeldir+"/InDel.table.xls","w") as result:
        result.writelines("Category\t"+"\t".join(samples)+"\n")
        for n1,n2 in zip(items,itemsName):
            result.writelines(n1)
            for sam in samples:
                if anno_type.has_key(n2) and anno_type[n2].has_key(sam):
                    result.writelines("\t%d" %(anno_type[n2][sam]))
                else:
                    result.writelines("\t0")
            result.writelines("\n")
        result.writelines("Others")
        for sam in samples:
            others = 0
            for k in  anno_type.keys():
                if k not in itemsName and not k.startswith("exonic"):
                    others =   others + anno_type[k].get(sam,0)
            result.writelines("\t%d" %(others))
        result.writelines("\n")

    table_out(indel_type,samples,"Insertion",indeldir+"/InDel.table.xls","Insertion")
    table_out(indel_type,samples,"Deletion",indeldir+"/InDel.table.xls","Deletion")
    table_out(hetero_ratio,samples,"Het rate(‰)",indeldir+"/InDel.table.xls")
    table_out(total_num,samples,"Total",indeldir+"/InDel.table.xls")
 
    #for GN report data file
    with open(indeldir+"/InDel.table.xls","r") as indeltabler:
         allsampleindeltabledata = indeltabler.readlines()
         
    allindeltabledata = []
    #for GN jointcall total result
    if re.search("/VarDetect/SnpInDel/JointGenotype/",files[0]):
        jointtotalindel = ["Number of InDels"]
        jointothers = 0
        for k,v in anno_joint_type.items():
            if k not in itemsName and anno_joint_type[k]["Number of InDels"] and not k.startswith("exonic"):
                jointothers = jointothers + anno_joint_type[k]["Number of InDels"]
        for n1,n2 in zip(items,itemsName):
            if anno_joint_type.has_key(n2) and anno_joint_type[n2].has_key("Number of InDels"):
                jointtotalindel.append(anno_joint_type[n2]["Number of InDels"])
            else:
                jointtotalindel.append("0")
        jointtotalindel.extend(["-",str(indel_type["Number of InDels"]["Insertion"]),str(indel_type["Number of InDels"]["Deletion"]),"-",str(total_num["Number of InDels"])])
        jointtotalindel[13] = jointothers
        for indel,joint in zip(allsampleindeltabledata,jointtotalindel):
            allindeltabledata.append(indel.strip("\n")+"\t"+str(joint)+"\n")
    else:
        allindeltabledata = allsampleindeltabledata

    gnshowdata = []
    indexname = []
    with safe_open(indeldir+"/indel_fun.xls","w") as result:
        for j in range(len(allindeltabledata[0].strip("\n").split("\t"))):
            onesampleexonic = 0
            onesampleshowdata = []
            for i in range(len(allindeltabledata)):
                if j == 0:
                    indexname.append(allindeltabledata[i].strip("\n").split("\t")[j])
                else:
                    if allindeltabledata[i].startswith("Exonic"):
                        onesampleexonic = onesampleexonic + int(allindeltabledata[i].strip("\n").split("\t")[j])
                    onesampleshowdata.append(allindeltabledata[i].strip("\n").split("\t")[j])
            if j != 0:
                onesampleshowdata.insert(3,onesampleexonic)
                gnshowdata.append(onesampleshowdata)

        indexname.insert(3,"Exonic")
        for b in [0,3,2,4,5,6,7,8,1,9,10,11,12,13,14,18]:
            name = indexname[b]
            writedata = [name]
            for a in range(len(gnshowdata)):
                writedata.append(str(gnshowdata[a][b]))
            result.write("\t".join(writedata)+"\n")

   # with safe_open(indeldir+"/InDel.CDSpercentage.xls","w") as result:
   #     result.writelines("\t"+"\t".join(samples)+"\n")
   #     for i in sorted(indel_length.keys()):
   #         result.write(str(i))
   #         for sam in samples:
   #             if indel_length[i].has_key(sam):
   #                 result.writelines("\t%d" %(indel_length[i][sam]))
   #             else:
   #                 result.writelines("\t0")
   #         result.writelines("\n")

    with safe_open(indeldir+"/InDel.CDSpercentage.xls","w") as result:
        result.writelines("\t"+"\t".join(samples)+"\n")
        for i in sorted(indel_length_ratio.keys()):
            result.write(str(i))
            for sam in samples:
                if indel_length_ratio[i].has_key(sam):
                    result.writelines("\t%s" %(indel_length_ratio[i][sam]))     
                else:             
                    result.writelines("\t0")
            result.writelines("\n")              

    with safe_open(indeldir+"/InDel.GENOMEpercentage.xls","w") as result:
        result.writelines("\t"+"\t".join(samples)+"\n")
        for i in sorted(indel_genome_length_ratio.keys()):
            result.write(str(i))
            for sam in samples:
                if indel_genome_length_ratio[i].has_key(sam):
                    result.writelines("\t%s" %(indel_genome_length_ratio[i][sam]))     
                else:             
                    result.writelines("\t0")
            result.writelines("\n") 

#    with safe_open(indeldir+"/InDel.CDSpercentage.xls.data","w") as result:
#        result.writelines("X\tY\tSample\n")
#        for length in sorted(indel_length.keys()):
#            for sam in samples:
#                result.writelines(str(length))
#                if indel_length[length].has_key(sam):
#                    result.writelines("\t%d\t%s\n" %(indel_length[length][sam],sam))
#                else:
#                    result.writelines("\t0\t%s\n" %(sam))
    
    with safe_open(indeldir+"/InDel.CDSpercentage.xls.data","w") as result:
        result.writelines("X\tY\tSample\n")
        for length in sorted(indel_length_ratio.keys()):
            for sam in samples:
                result.writelines(str(length))
                if indel_length_ratio[length].has_key(sam):
                    result.writelines("\t%s\t%s\n" %(indel_length_ratio[length][sam],sam))
                else:
                    result.writelines("\t0\t%s\n" %(sam))    

    with safe_open(indeldir+"/InDel.GENOMEpercentage.xls.data","w") as result:
        result.writelines("X\tY\tSample\n")
        for length in sorted(indel_genome_length_ratio.keys()):
            for sam in samples:
                result.writelines(str(length))
                if indel_genome_length_ratio[length].has_key(sam):
                    result.writelines("\t%s\t%s\n" %(indel_genome_length_ratio[length][sam],sam))
                else:
                    result.writelines("\t0\t%s\n" %(sam))                     
    #plotInDelLen(indeldir+"/InDel.CDSpercentage.xls")

if sv: 
    samples = []
    sv_types = {}
    sv_length = collections.OrderedDict()
    sv_lenratio = collections.OrderedDict()
    sv_dis = ["0-100","100-200","200-300","300-400","400-500","500-600","600-700","700-800","800-900","900-1000","1000-1100","1100-1200"]
    sv_dis_a = ["0-100","100-200","200-300","300-400","400-500","500-600","600-700","700-800","800-900","900-1000","1000-1100","1100-1200",">1200"]
    for line in safe_open(sv,'r'):
        files = line.strip().split()
        #sample = re.split("/|\.",files[0])[-3]
        sample = files[0].split("/")[-1].split(".")[0]
        list_append(samples,sample)
        dict_initial(sample,sv_types,sv_length,sv_lenratio)
        for seq in safe_open(files[0],'r'):
            if seq.startswith("#"):
                continue
            parts = seq.split()
            dict_add(sv_types[sample],parts[6],1,1)  ##SV TYPE colomn
            dict_add(sv_types[sample],"Total",1,1)
            flag = 0
            if parts[0] == parts[3]:
                length = abs(int(parts[7]))
                for i in sv_dis:
                    ii = i.split("-")
                    if int(ii[0]) < length and length <= int(ii[1]):
                        dict_add(sv_length[sample],i,1,1)
                        flag = 1
                        break
                if flag == 0 and length > 1200:
                    dict_add(sv_length[sample],">1200",1,1)
                dict_add(sv_length[sample],"Total",1,1)
        ##revised:zhangshouwei 
        for seq in safe_open(files[1],'r'):
            parts = seq.split()
            dict_add(sv_types[sample],parts[1],1,1)

        ##don't use exonic_variant_function result
        
    svdir = os.path.join(odir,"SV")
    if not os.path.exists(svdir):
        assert not os.makedirs(svdir)
    for sam in samples:
        for i in sv_dis_a:
            if sv_length[sam].has_key(i):
                sv_lenratio[sam][i] = str(sv_length[sam][i]*100/float(sv_length[sam]["Total"]))
            else:
                sv_lenratio[sam][i] = 0
    with safe_open(svdir+"/SV.len.rate","w") as result:
        result.writelines("\t"+"\t".join(samples)+"\n")
    with safe_open(svdir+"/SV.len.num","w") as result:
        result.writelines("\t"+"\t".join(samples)+"\n")
    with safe_open(svdir+"/SV.len.rate.data","w") as result:
        result.writelines("X\tY\tSample\n")
    for i in sv_dis_a:
        table_out(sv_length,samples,i,svdir+"/SV.len.num",i)
        table_out(sv_lenratio,samples,i,svdir+"/SV.len.rate",i)
        for sam in samples:
            with safe_open(svdir+"/SV.len.rate.data","a") as result:
                result.writelines("%s\t%s\t%s\n" %(i,sv_lenratio[sam][i],sam))
    #plotSVLen(svdir+"/SV.len.rate")

    items = ["Upstream","Exonic","Downstream","Intronic","Upstream/Downstream","Intergenic","Splicing","Others","INS","DEL","INV","ITX","CTX","Total"]
    itemsName = ["upstream","exonic","downstream","intronic","upstream;downstream","intergenic","splicing","Others","INS","DEL","INV","ITX","CTX","Total"]      
    for sam in samples:
        others = 0
        for k in  sv_types[sam].keys():
            if k not in itemsName and k !="ANNO_REGION":
                others =   others + sv_types[sam].get(k,0)
        sv_types[sam].update({"Others":others})

    with safe_open(svdir+"/SV.table.xls","w") as result:
        result.writelines("Category\t"+"\t".join(samples)+"\n")
        for it in range(0,len(itemsName)):
            result.writelines(items[it])
            for sam in samples:
                if sv_types[sam].has_key(itemsName[it]):
                    result.writelines("\t%d" %(sv_types[sam][itemsName[it]]))
                else:
                    result.writelines("\t0")
            result.writelines("\n")


    #plotSVtype(svdir)

if cnv:
    samples = []
    cnv_types = {}
    for line in safe_open(cnv,'r'):
        files = line.strip().split()
        sample = files[0].split("/")[-1].split(".")[0]
        list_append(samples,sample)
        dict_initial(sample,cnv_types)
        if files[0].endswith("CNVs"):
            for seq in safe_open(files[0],'r'):
                parts = seq.split()
                length = float(parts[2])-float(parts[1])
                dict_add(cnv_types[sample],parts[4],1,1)
                dict_add(cnv_types[sample],parts[4]+"Len",int(length),int(length))
                dict_add(cnv_types[sample],"Total",1,1)

            for seq in safe_open(files[1],'r'):
                parts = seq.split()
                dict_add(cnv_types[sample],parts[1],1,1)

            cnvdir = os.path.join(odir,"CNV")
            if not os.path.exists(cnvdir):
                assert not os.makedirs(cnvdir)
            items = ["Upstream","Exonic","Intronic","Downstream", "Upstream/Downstream","Intergenic","Others","Gain number","Loss number","Gain length(bp)","Loss length(bp)","Total"]
            itemsName = ["upstream","exonic","intronic","downstream","upstream;downstream","intergenic","Others","gain","loss","gainLen","lossLen","Total"]
        else:
            for seq in safe_open(files[0],'r'):
                parts = seq.split()
                dict_add(cnv_types[sample],parts[0],1,1)
                dict_add(cnv_types[sample],parts[0]+"Len",int(float(parts[2])),int(float(parts[2])))
                dict_add(cnv_types[sample],"Total",1,1)
            ##revised:zhangshouwei
            for seq in safe_open(files[1],'r'):
                parts = seq.split()
                dict_add(cnv_types[sample],parts[1],1,1)

            ##don't use exonic_variant_function result
            cnvdir = os.path.join(odir,"CNV")
            if not os.path.exists(cnvdir):
                assert not os.makedirs(cnvdir)
            items = ["Upstream","Exonic","Intronic","Downstream", "Upstream/Downstream","Intergenic","Others","Duplication number","Deletion number","Duplication length(bp)","Deletion length(bp)","Total"]
            itemsName = ["upstream","exonic","intronic","downstream","upstream;downstream","intergenic","Others","duplication","deletion","duplicationLen","deletionLen","Total"]

    for sam in samples:
        others = 0
        for k in  cnv_types[sam].keys():
            if k not in itemsName and k !="ANNO_REGION":
                others =   others + cnv_types[sam].get(k,0)
        cnv_types[sam].update({"Others":others})
    with safe_open(cnvdir+"/CNV.table.xls","w") as result:
        result.writelines("Category\t"+"\t".join(samples)+"\n")
        for it in range(0,len(itemsName)):
            result.writelines(items[it])
            for sam in samples:
                if cnv_types[sam].has_key(itemsName[it]):
                    result.writelines("\t%d" %(cnv_types[sam][itemsName[it]]))
                else:
                    result.writelines("\t0")
            result.writelines("\n")
    with safe_open(cnvdir+"/CNV.table.xls.data","w") as result:
        result.writelines("Sample\tNumber\tCategory\n")
        for it in range(0,5):
            for sam in samples:
                if cnv_types[sam].has_key(itemsName[it]):
                    result.writelines("%s\t%d\t%s\n" %(sam,cnv_types[sam][itemsName[it]],items[it]))
                else:
                    result.writelines("%s\t%d\t%s\n" %(sam,0,items[it]))


    #plotCNVDis(cnvdir+"/CNV.table.xls")
    #plotCNVtype(cnvdir) 
