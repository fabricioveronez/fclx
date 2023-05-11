#!/bin/bash

sleep 120

migrate -path=sql/ -database "mysql://$DB_USER:$DB_PASSWORD@tcp($DB_HOST:3306)/$DB_NAME" -verbose up

./chatservice