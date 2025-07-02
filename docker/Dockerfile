FROM docker.io/continuumio/miniconda3

RUN apt-get update && \
    apt-get install -y openscad libgl1-mesa-glx gcc bash && \
    rm -rf /var/lib/apt/lists/*

RUN conda update -n base -c defaults conda

# Create the environment:
WORKDIR /app
COPY environment.yaml .
COPY build.sh .
RUN conda env create -f environment.yaml && (rm /opt/conda/pkgs/cache/* || true)
RUN conda run -n dactyl-manuform /bin/bash -c "pip3 install solidpython"
