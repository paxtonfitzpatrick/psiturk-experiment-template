# DOCKERFILE FOR PSITURK IMAGE - DEPLOY-LOCAL
# ========================================
#
# The "FROM" instruction specifies the base image on top of which we'll build our image. We'll use a "minbase"
# (i.e., small, efficient, bare-bones) version of Debian 9 (a.k.a. "stretch")
FROM debian:stretch

# "LABEL" adds metadata to your image. It's helpful to include if you plan on distributing your image for others' use
LABEL maintainer="Paxton Fitzpatrick <Paxton.C.Fitzpatrick@Dartmouth.edu>" version="1.0"

# ========================================

# "RUN" executes a command in the container's shell. Combining multiple *related* commands into one
# RUN instruction can help keep your image small, since Docker creates a new "layer" for each.

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

# Delete apt list files, which can take up a surprising amount of space
RUN rm -rf /var/lib/apt/lists/*

# ========================================

# Next, install the necessary Python packages. Add any extra packages your experiment needs.
# (Note: Setuptools will sometimes fail to install packages with files containing non-ASCII characters. Setting the
# locale to UTF-8 fixes this.
ENV LANG C.UTF-8
RUN pip install --upgrade pip \
    setuptools \
    requests \
    requests-oauthlib \
    psiturk==2.2.8 \
    joblib \
    sqlalchemy

# "WORKDIR" sets the working directory inside the container. We'll set it to the psiTurk experiment directory
WORKDIR /exp

# This environment variable tells psiTurk where to look for your .psiturkconfig file
ENV PSITURK_GLOBAL_CONFIG_LOCATION=/exp

# "EXPOSE" tells Docker that your container will listen on the specified port. This allows you to access the experiment
# from a web browswer outside the container
EXPOSE 22363
