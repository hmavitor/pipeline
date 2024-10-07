# Definições globais
VCF_FILE = "input_data/NIST.vcf"
OUTPUT_DIR = "results"

# Rule para filtrar variantes
rule filter_vcf:
    input:
        vcf=VCF_FILE
    output:
        filtered_vcf=os.path.join(OUTPUT_DIR, "filtered.vcf")
    script:
        "scripts/filter_vcf.py"

# Rule para anotar variantes
rule annotate_variants:
    input:
        filtered_vcf=os.path.join(OUTPUT_DIR, "filtered.vcf")
    output:
        annotated_vcf=os.path.join(OUTPUT_DIR, "annotated.vcf")
    script:
        "scripts/annotate_variants.py"

# Rule para extrair informações
rule extract_info:
    input:
        annotated_vcf=os.path.join(OUTPUT_DIR, "annotated.vcf")
    output:
        final_report=os.path.join(OUTPUT_DIR, "final_report.txt")
    script:
        "scripts/extract_info.py"

# Defina a regra final
rule all:
    input:
        os.path.join(OUTPUT_DIR, "final_report.txt")