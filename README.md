# psiturk-experiment-template

## `deploy-local`

This branch provides a template setup for **local deployment** of a [psiTurk](https://psiturk.org/) experiment. The 
experiment is housed in a single, lightweight Docker container and saves participant data to a 
[SQLite](https://www.sqlite.org/index.html) database. For easily accessing the data, I recommend downloading the 
[DB Browser for SQLite](https://sqlitebrowser.org/) app, or if you'd rather parse it directly with Python, 
[SQLAlchemy](https://www.sqlalchemy.org/) is an excellent library.

####NOTE:
If you're going to be running any analyses on your collected data, it's a good idea to isolate your environment for 
that task as well. Importantly, *this should be separate from your experiment environment* to make 
sure any packages you install don't interfere with psiTurk's any of dependencies. 
[Conda](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) environments are 
great for this, checkout this 
[GitHub gist](https://gist.github.com/paxtonfitzpatrick/f00dfcce1293bede0b9c1f87b456e1b6) for a template Docker 
container configured for reproducible Python analyses in [Jupyter notebooks](https://jupyter.org/).