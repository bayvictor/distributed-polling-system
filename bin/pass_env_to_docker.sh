echo "You can pass environment variables to your containers with the -e flag.

example from a startup script
"

sudo docker run -d -t -i -e REDIS_NAMESPACE='staging' \ 
-e POSTGRES_ENV_POSTGRES_PASSWORD='foo' \
-e POSTGRES_ENV_POSTGRES_USER='bar' \
-e POSTGRES_ENV_DB_NAME='mysite_staging' \
-e POSTGRES_PORT_5432_TCP_ADDR='docker-db-1.hidden.us-east-1.rds.amazonaws.com' \
-e SITE_URL='staging.mysite.com' \
-p 80:80 \
--link redis:redis \  
--name container_name dockerhub_id/image_name

echo "

or, if you don't want to have the value on the command-line where it will be displayed by ps, etc., -e can pull in the value from the current environment if you just give it without the =:

sudo PASSWORD='foo' docker run  [...] -e PASSWORD [...]
share
"

