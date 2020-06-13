# DOCKERFILE FOR PSITURK IMAGE
# A Dockerfile is a list of instructions for building a Docker image.
# 
# ========================================
# 
# The "FROM" instruction specifies the "base image" on top of which we'll build our image.
# We'll use a "minbase" (i.e., small, efficient, bare-bones) version of Debian 9 (a.k.a."stretch")
FROM debian:stretch

# The "LABEL" instruction adds metadata to your image. 
# It's helpful to include if you plan on distributing your image for others' use
LABEL maintainer="Paxton Fitzpatrick <Paxton.C.Fitzpatrick@Dartmouth.edu>" version="1.0"

# ========================================

# The "RUN" instruction allows you to run commands using the shell inside the container. 
# It's often a good idea to combine multiple *related* commands into one RUN instruction, 
# as each instruction adds a new "layer" on top of the last, increasing the size of your 
# container and the time needed to build it.
# First, update apt-get and install some basic stuff on top of minbase Debian
RUN apt-get update --fix-missing && apt-get install -y eatmydata
RUN eatmydata apt-get install -y \
    python-dev \
    default-libmysqlclient-dev \
    python-pip \
    procps \
    git \
    yasm \
    vim

# This deletes all the apt list files, which saves space and forces the later apt-get update command to happen
RUN rm -rf /var/lib/apt/lists/*

# ========================================

# Next, install our necessary Python packages. Add any extra packages your experiment needs.
# NOTE: Pip/setuptools will sometimes fail to install packages whose setup/description files contain certain 
# characters. Un-commenting the next line often helps this.
# ENV LANG C.UTF-8
RUN pip install --upgrade pip \
    setuptools \
    requests \
    requests-oauthlib \
    psiturk==2.2.3 \
    joblib \
    mysql-python \
    sqlalchemy

# NOTE: if your experiment entails heavy computations between trials, you'll probably want to replace
# `psiturk==2.2.3` with `git+https://github.com/ContextLab/psiTurk.git@expose-gunicorn-timeout-parameter`, 
# a branch of our lab's PsiTurk fork where the time before the experiment server times out can be easily increased

# NOTE: if your experiment entails automatic speech transcription, you'll probably want to do a few things:
#   - add `quail` and/or `pydub` to the set of pip-installed packages
#   - un-comment the next instruction to install FFmpeg
# RUN git clone https://github.com/FFmpeg/FFmpeg && cd FFmpeg && ./configure --enable-gpl && make && make install && ldconfig


# add experiment and data folders
COPY memory-dynamics/exp /exp
COPY memory-dynamics/data /data
COPY memory-dynamics/code /code

# add stimuli folder
# COPY video-stims /exp/video-stims

# setup working directory
WORKDIR /exp

# set up psiturk to use the .psiturkconfig in /
ENV PSITURK_GLOBAL_CONFIG_LOCATION=/

# expose port to access psiturk from outside
EXPOSE 22363
