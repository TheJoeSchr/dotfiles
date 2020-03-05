#!/bin/bash

# mkdir pg4admin
cd pg4admin

docker volume create --driver local --name=pga4volume

cat << EOF > pgadmin-env.list
PGADMIN_DEFAULT_EMAIL=clearing
PGADMIN_DEFAULT_PASSWORD=1234
PGADMIN_LISTEN_PORT=5050
EOF

docker run --publish 5050:5050 \
  --volume=pga4volume:/var/lib/pgadmin \
  --env-file=pgadmin-env.list \
  --name="pgadmin4" \
  --hostname="pgadmin4" \
  --network="default" \
dpage/pgadmin4
