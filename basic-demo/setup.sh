
echo "Enable Key/Value Secret Engine for Engineering and Devops"
vault secrets enable -path=engineering/ kv-v2
vault secrets enable -path=devops/ kv-v2
vault kv put engineering/secret db_password="abcd-1234-pqrs-5678"
vault kv put devops/secret db_password="AXY786345"

echo "Creating Engineering and Devops Policies"
vault policy write engineering-secret engineering-secret.hcl
vault policy write devops-secret devops-secret.hcl

echo "Enable Auth method username/password to login to Vault"
vault auth enable userpass

echo "Create Users bob (Engineering) and ellen (DevOps)"
vault write auth/userpass/users/bob password="training" policies="engineering-secret"
vault write auth/userpass/users/ellen password="training" policies="devops-secret"


