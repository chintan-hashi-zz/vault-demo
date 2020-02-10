
vault delete database/config/postgresql
vault delete database/roles/readonly
vault policy delete apps

sleep 5

vault secrets disable database
