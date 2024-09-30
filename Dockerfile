# Etapa 1: Escolher uma imagem base do Python
FROM python:3.9-slim

# Etapa 2: Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libbz2-dev \
    liblzma-dev \
    libssl-dev \
    libncurses5-dev \
    libncursesw5-dev \
    zlib1g-dev \
    libsqlite3-dev \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Etapa 3: Instalar bibliotecas Python (snakemake, flask, e outras)
RUN pip install --upgrade pip
RUN pip install snakemake flask requests

# Etapa 4: Adicionar o diretório do projeto
WORKDIR /app

# Etapa 5: Copiar o código do projeto para o Docker
COPY . /app

# Etapa 6: Definir o comando inicial do container (ex: rodar o pipeline ou iniciar o Flask)
CMD ["python", "app.py"]
