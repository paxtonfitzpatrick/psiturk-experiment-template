# `psiturk-experiment-template`

A template behavioral experiment ready to be run locally or deployed on [Amazon Mechanical Turk](https://www.mturk.com/).  Slides from the accompanying tutorial are in [`slides/`](https://github.com/paxtonfitzpatrick/psiturk-experiment-template/tree/master/slides).

## Commands


## Resources
### Relevant docs
- [psiTurk](https://psiturk.readthedocs.io/en/latest/)
    - [Getting setup with psiturk.org](https://psiturk.readthedocs.io/en/latest/psiturk_org_setup.html)
    - [Getting setup with Amazon Mechanical Turk](https://psiturk.readthedocs.io/en/latest/amt_setup.html)
    - [Guide to `config.txt` fields](https://psiturk.readthedocs.io/en/latest/configuration.html#local-configuration-file)    
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
    -

-
## Notes
- Paring down the template for exclusively in-person experiments
    - The provided template will work for both in-person and online deployment. However, if you know you will only be collecting in-person data and want to reduce the size of your experiment, you can cut out the three support services (`nginx`, `MySQL`, `Adminer`) and run
