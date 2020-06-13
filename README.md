# psiturk-experiment-template

## `deploy-local`

This branch provides a template setup for **local deployment** of a psiTurk experiment.  The experiment is housed in
 a single, lightweight Docker container and saves participant data to a 
 [SQLite](https://www.sqlite.org/index.html) database. For easily accessing the data, I recommend downloading the 
 [DB Browser for SQLite](https://sqlitebrowser.org/) app, or if you'd rather parse it directly with Python, 
 [SQLAlchemy](https://www.sqlalchemy.org/) is an excellent library.
