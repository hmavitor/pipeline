# scripts/filter_vcf.py

import sys
import pysam

def filter_vcf(input_vcf, output_vcf):
    # Lógica para filtrar variantes
    with pysam.VariantFile(input_vcf) as vcf_in, pysam.VariantFile(output_vcf, 'w', header=vcf_in.header) as vcf_out:
        for rec in vcf_in:
            if rec.qual >= 30:  # Exemplo de filtragem por qualidade
                vcf_out.write(rec)

if __name__ == "__main__":
    input_vcf = sys.argv[1]
    output_vcf = sys.argv[2]
    filter_vcf(input_vcf, output_vcf)
