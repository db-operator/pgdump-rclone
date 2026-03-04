# pgdump-gcs

Small docker container for creating a backup of a psql database and upload the dump to an external storage using rclone.

## How to use
TO BE DONE ... 

## monitoring

Simple curl pushing some basic parameter to a prometheus push gateway.

### metrics
* timestamp
* duration
* size

### labels
* job = pgdump-gcs
* source_type = postgresql
* source_name = `${DB_NAME}`
