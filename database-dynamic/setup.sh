
echo "Enable Database Secret Engine"
vault secrets enable database

echo "Create postgres connection string"
vault write database/config/postgresql plugin_name=postgresql-database-plugin allowed_roles=readonly connection_url=postgresql://postgres:vormetric@10.2.0.37:5432/postgres?sslmode=disable

echo "Create a vault role with SQL statements"
vault write database/roles/readonly db_name=postgresql creation_statements=@readonly.sql default_ttl=1h max_ttl=24h

echo "Create app policy that can initiate new database credential"
vault policy write apps apps-policy.hcl

echo "Create a token with app policy"
app_token="$(vault token create -policy="apps" -format=json | jq -r '.auth.client_token')"

echo "Request new Postgres credential with token"
VAULT_TOKEN=$app_token vault read database/creds/readonly
