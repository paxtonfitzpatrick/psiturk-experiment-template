FROM debian:stretch

LABEL maintainer="Paxton Fitzpatrick <Paxton.C.Fitzpatrick@Dartmouth.edu>" version="1.0"

ARG experiment_dir="/exp"

ENV PSITURK_GLOBAL_CONFIG_LOCATION $experiment_dir

WORKDIR $experiment_dir

RUN apt-get update --fix-missing \
    && apt-get install -y eatmydata \
    && eatmydata apt-get install -y --no-install-recommends \
        procps \
        python3.6 \
        vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip install \
        psiturk==2.3.11 \
        pymysql==0.10.0 \
    && rm -rf ~/.cache/pip