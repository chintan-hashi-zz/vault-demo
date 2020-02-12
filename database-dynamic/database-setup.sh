
echo "Enable Database Secret Engine"
echo "#############################"
vault secrets enable database
read -n 1


echo "Create postgres connection string"
echo "#################################"
vault write database/config/postgresql plugin_name=postgresql-database-plugin allowed_roles=readonly connection_url=postgresql://postgres:vormetric@10.2.0.37:5432/postgres?sslmode=disable
read -n 1


echo "Create a vault role with SQL statements"
echo "#######################################"
vault write database/roles/readonly db_name=postgresql creation_statements=@readonly.sql default_ttl=1h max_ttl=24h
read -n 1


echo "Create app policy that can initiate new database credential"
echo "###########################################################"
vault policy write apps apps-policy.hcl
read -n 1

echo "Create a token with app policy"
echo "##############################"
app_token="$(vault token create -policy="apps" -format=json | jq -r '.auth.client_token')"
read -n 1


echo "Request new Postgres credential with token"
echo "###########################################"
VAULT_TOKEN=$app_token vault read database/creds/readonly
