#vault delete database/roles/readonly
#vault delete database/config/postgresql
vault policy delete apps

sleep 5

vault secrets disable database
