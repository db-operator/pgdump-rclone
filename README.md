# Postgres backup container for DB Operator

Small docker container for creating a backup of a psql database and uploading it to an external storage using rclone.

Every backup is uploaded twice, once with a **timestamp** and once as **latest**. So you can always download the latest backup.

There is no clean-up logic, please take care of old backups using external tools, for example bucket retention policies.

## How to restore

This script is simply taking a database backup using `pg_dump`, you can restore it by setting env variables and running the following command:

```shell
$ export PGHOST=<Database host>
$ export PGPORT=<Database port>
$ export PGUSER=<Admin user>
$ export PGDATABASE=postgres
$ export PGPASSWORD=<Admin password>
$ pg_restore --no-owne:wr --no-privileges -d <Target database>  --role <Target username> -Fc <Backup file path> --clean
```

## How to use

This container is supposed to be used by the DB Operator for setting up backup CronJobs. 

To backup a postgres database using this container you need to pass env variables for `pg_dump` and for `rclone`:

**pg_dump** variables:

- **DB_NAME**: A name of a database to back up
- **DB_HOST**: A database server host
- **DB_PASSWORD_FILE**: A path to a file with a database password (file must be mounted to the container)
- **DB_USER**: User that should perform the backup

**rclone** variables:

- **STORAGE_BUCKET**: A name of a bucket/directory that should be used for uploading the backup

For the rest, please check here: <https://rclone.org/docs/#environment-variables>.

The backend name is hardcoded to 'storage', so your env vars should be prefixed by `RCLONE_CONFIG_STORAGE_`

## Monitoring

Simple curl pushing some basic parameter to a prometheus push gateway.

### metrics
* timestamp
* duration
* size

### labels
* job = pgdump-rclone
* source_type = postgresql
* source_name = `${DB_NAME}`
