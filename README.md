# `psiturk-experiment-template`

A template behavioral experiment ready to be run locally or deployed on [Amazon Mechanical Turk](https://www.mturk.com/).  Slides from the accompanying tutorial are in [`slides/`](https://github.com/paxtonfitzpatrick/psiturk-experiment-template/tree/master/slides).

## Commands
### Starting the experiment server
1. Start the Docker containers:
    ```shell
    $ docker-compose up -d
    Creating network "psiturk-experiment-template_default" with the default driver
    Creating my-experiment-adminer ... done
    Creating my-experiment-nginx   ... done
    Creating my-experiment         ... done
    Creating my-experiment-db      ... done
    ```
    When run for the first time, Docker will build the psiTurk image from `Dockerfile` and pull the others from Docker Hub.

2. Attach standard input, output, and error to the psiTurk container:
    ```shell
    $ docker attach my-experiment
    root@dfeef3fee90e:/exp#
    ```
    If your shell prompt begins with `root@`, you're now inside the psiTurk container

3. Launch the psiTurk shell:
    ```
    root@dfeef3fee90e:/exp# psiturk

    https://psiturk.org
     ______   ______     __     ______   __  __     ______     __  __
    /\  == \ /\  ___\   /\ \   /\__  _\ /\ \/\ \   /\  == \   /\ \/ /
    \ \  _-/ \ \___  \  \ \ \  \/_/\ \/ \ \ \_\ \  \ \  __<   \ \  _"-.
     \ \_\    \/\_____\  \ \_\    \ \_\  \ \_____\  \ \_\ \_\  \ \_\ \_\
      \/_/     \/_____/   \/_/     \/_/   \/_____/   \/_/ /_/   \/_/\/_/

                 an open platform for science on Amazon Mechanical Turk

    --------------------------------------------------------------------

    Due to a recent Amazon API deprecation, you need to install psiturk version 2.3.0 or later.

    v2.3.0 is python2 only, while versions of v2.3.x >= v2.3.1 support both python2 and python3.

    Check https://github.com/NYUCCL/psiTurk or https://psiturk.org for more info.
    psiTurk version 2.3.8
    Type "help" for more information.
    ```

4. Switch the server on:
    ```
    [psiTurk server:off mode:sdbx #HITs:0]$ server on
    Experiment server launching...
    Now serving on http://0.0.0.0:22362
    ```

### Running your experiment locally
With the experiment server *on*, run:
```
[psiTurk server:on mode:sdbx #HITs:0]$ debug
Launching browser pointed at your randomized debug link, feel free to request another.
	http://127.0.0.1:80/ad?assignmentId=debugXXXXXX&hitId=debugXXXXXX&workerId=debugXXXXXX&mode=debug
```
Note that the browswer will not launch automatically because the server is running inside the Docker container. Copy/paste the generated link into a browser.

### Testing your experiment in the MTurk sandbox
First, ensure that you're running in sandbox mode (the shell prompt should read "`mode:sdbx`").  With the experiment server *on*, run:
```
[psiTurk server:on mode:sdbx #HITs:0]$ hit create 1 0.01 1
*****************************
    Max workers: 1
    Reward: $0.01
    Duration: 1.0 hours
    Fee: $0.00
    ________________________
    Total: $0.01
Create sandbox HIT [y/n]? y
*****************************
  Created sandbox HIT
    HITid: 3BFF0DJK8YIPHERZLJFXL1DWL23TS0
    Max workers: 1
    Reward: $0.01
    Duration: 1.0 hours
    Fee: $0.00
    ________________________
    Total: $0.01
  Ad URL: https://sandbox.ad.psiturk.org/view/SskxbA8SWCGw3opFDiWEAW?assignmentId=debug63PAWI&hitId=debugVR03DZ&workerId=debugIJ3Q5T
Note: This url cannot be used to run your full psiTurk experiment.  It is only for testing your ad.
  MTurk URL: https://workersandbox.mturk.com/projects?filters%5Bsearch_term%5D=Example+MTurk+experiment
Hint: In OSX, you can open a terminal link using cmd + click
Note: This sandboxed ad will expire from the server in 16 days.
```
to create **1** sandbox HIT paying $**0.01** (in fake money), available for **1** hour. Copy/paste the generated `MTurk URL` into a browser to view your MTurk listing and test your HIT, or use the `Ad URL` to test your HIT's advertisement. Note: the `hit create` command can also be run interactively by passing no parameters.

### Posting live HITs for your experiment
First, ensure that you're running in live mode (the shell prompt should read "`mode:live`").  If you're running in sandbox (`sdbx`) mode, enter `mode live` and confirm when prompted to restart the server and switch to live mode.  Then, create your HIT(s) with the `hit create` command as in [sandbox mode](#testing-your-experiment-in-the-mturk-sandbox)

### Approving, rejecting, and bonusing workers
see the psiTurk docs page on [worker commands](https://psiturk.readthedocs.io/en/latest/command_line/worker.html?highlight=approv#worker-command-subcommands) for a full guide to managing completed HITs

### Shutting down the experiment server
1. Switch the psiTurk server off
    ```
    [psiTurk server:on mode:sdbx #HITs:0]$ server off
    Shutting down experiment server at pid b'XXX'...
    Please wait. This could take a few seconds.
    Killed
    ```
2. exit the psiTurk shell
    ```
    [psiTurk server:off mode:sdbx #HITs:0]$ exit
    ```
3. exit the psiTurk container
    ```shell
    root@dfeef3fee90e:/exp# exit
    exit
    ```


## Resources
### Relevant documentation
- [psiTurk](https://psiturk.readthedocs.io/en/latest/)
    - [Getting setup with psiturk.org](https://psiturk.readthedocs.io/en/latest/psiturk_org_setup.html)
    - [Getting setup with Amazon Mechanical Turk](https://psiturk.readthedocs.io/en/latest/amt_setup.html)
    - [Guide to `config.txt` fields](https://psiturk.readthedocs.io/en/latest/configuration.html#local-configuration-file)
- [jsPsych](https://www.jspsych.org/)
    - [core library API](https://www.jspsych.org/core_library/jspsych-core/)
    - [plugins](https://www.jspsych.org/plugins/overview/)
    - [creating experiments: the timeline](https://www.jspsych.org/overview/timeline/)
- [Docker](https://docs.docker.com/)
    - [installation](https://docs.docker.com/get-docker/)
    - [`Dockerfile` reference](https://docs.docker.com/engine/reference/builder/)
    - [`docker-compose` command reference](https://docs.docker.com/compose/reference/overview/)
        - [subcommands](https://docs.docker.com/compose/reference/)
    - [`docker-compose.yml` file reference](https://docs.docker.com/compose/compose-file/)
- [nginx](https://www.nginx.com/)
    - [Docker image reference](https://hub.docker.com/_/nginx)
    - [docs](https://nginx.org/en/docs/)
    - [configuration file guide](http://nginx.org/en/docs/beginners_guide.html#conf_structure)
    - [example configurations](https://www.nginx.com/resources/wiki/start/index.html#pre-canned-configurations)
- [MySQL](https://www.mysql.com/)
    - [Docker image reference](https://hub.docker.com/_/mysql)
    - [v5.7 docs](https://dev.mysql.com/doc/refman/5.7/en/)
    - [v5.7 error reference](https://dev.mysql.com/doc/mysql-errors/5.7/en/)
    - [v5.7 SQL statement syntax](https://dev.mysql.com/doc/refman/5.7/en/sql-statements.html)
- [Adminer](https://www.adminer.org/)
    - [Docker image reference](https://hub.docker.com/_/adminer)
    - [plugins bundled with image](https://github.com/vrana/adminer/tree/master/plugins)
    - [plugin docs](https://www.adminer.org/plugins/)

### Other resources
- [DB Browser for SQLite](https://sqlitebrowser.org/)
    - If you don't plan on posting your experiment on MTurk and a
- `CDL-docker-stacks`
    - a repository of lightweight, hierarchically built Docker images for common neuroscience/data science uses
    - [pre-built images are available on Docker Hub](https://hub.docker.com/u/contextlab)
    - [Source code is available on GitHub](https://github.com/ContextLab/CDL-docker-stacks)
- [psiTurk experiment exchange](https://psiturk.org/ee/)


## Notes
- Paring down the template for exclusively in-person experiments
    - The provided template will work for both in-person and online deployment. However, if you know you will only be collecting in-person data and want to reduce the size of your experiment, you can cut out the three support services (`nginx`, `MySQL`, `Adminer`) and run
