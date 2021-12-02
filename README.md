## Environments
Environment collection for running the service

### Quick start
1. Clone this repository
```
git clone https://github.com/macnuget/environment
```
2. Cd into the repository and run docker compose
```
cd environment
docker compose up
```

### Edit DB schema
The database schema is loaded into postgres during boot, to make changes to it edit `psql-scripts/init-db.sh` file.
