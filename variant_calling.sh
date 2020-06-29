java -jar /projects/home/agombolay3/data/bin/GenomeAnalysisTK.jar -T GenotypeGVCFs --variant YS486.g.vcf --variant CM3.g.vcf --variant CM6.g.vcf --variant CM9.g.vcf --variant CM10.g.vcf --variant CM11.g.vcf --variant CM12.g.vcf --variant CM41.g.vcf -R /projects/home/agombolay3/data/repository/Variant-Calling/References/sacCer3.fa -o Variants.vcf

java -Xmx4g -jar /projects/home/agombolay3/data/bin/snpEff/snpEff.jar Saccharomyces_cerevisiae Variants.vcf > Variants-Annotated.vcf

cat Variants-Annotated.vcf | java -jar /projects/home/agombolay3/data/bin/snpEff/SnpSift.jar filter "((QUAL >= 30) && (DP >= 25))" > Variants1.vcf

cat Variants1.vcf | sed "s/CM10-sample/CM10_sample/g" | sed "s/CM11-sample/CM11_sample/g" | sed "s/CM12-sample/CM12_sample/g" | sed "s/CM3-sample/CM3_sample/g" | sed "s/CM41-sample/CM41_sample/g" | sed "s/CM6-sample/CM6_sample/g" | sed "s/CM9-sample/CM9_sample/g" | sed "s/YS486-sample/YS486_sample/g" > Variants2.vcf

java -jar /projects/home/agombolay3/data/bin/snpEff/SnpSift.jar extractFields Variants2.vcf "CHROM" "POS" "REF" "ALT" "GEN[CM10_sample].GT" "GEN[CM11_sample].GT" "GEN[CM12_sample].GT" "GEN[CM3_sample].GT" "GEN[CM41_sample].GT" "GEN[CM6_sample].GT" "GEN[CM9_sample].GT" "GEN[YS486_sample].GT" "EFF[*].EFFECT" "EFF[*].IMPACT" "EFF[*].GENE" > Variants3.tab

awk -F'\t' '$12!=$5||$12!=$6||$12!=$7||$12!=$8||$12!=$9||$12!=$10||$12!=$11 {print $0}' Variants3.tab > Variants4.tab
