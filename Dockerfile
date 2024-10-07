# Use an official lightweight Linux base
FROM ubuntu:20.04

# Set non-interactive mode for tzdata installation to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for Conda and configure time zone in non-interactive mode
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*  # Cleanup for reduced image size

# Download Miniconda and cache it
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh \
    && bash /miniconda.sh -b -p /opt/conda \
    && rm /miniconda.sh \
    && /opt/conda/bin/conda clean -ya  # Clean to reduce image size

# Set path to conda
ENV PATH=/opt/conda/bin:$PATH

# Install Snakemake, Pysam, and clean conda caches
RUN conda install -c conda-forge -c bioconda snakemake pysam \
    && conda clean --all -y  # Clean conda cache to reduce image size

# Set up working directory (this is where your vcf_pipeline repo will go)
WORKDIR /app

# Expose any relevant ports if needed (optional)
EXPOSE 3000

# Default command to keep the container running or open bash for development
CMD [ "/bin/bash" ]
