
echo "Enable Auth method username/password to login to Vault"
echo "######################################################"
vault auth enable userpass
read -n 1


echo "Create Users bob (Engineering) and ellen (DevOps)"
echo "#################################################"
vault write auth/userpass/users/bob password="training" policies="engineering-secret"
vault write auth/userpass/users/ellen password="training" policies="devops-secret"
read -n 1


echo "Creating Engineering and Devops Policies"
echo "########################################"
vault policy write engineering-secret engineering-secret.hcl
vault policy write devops-secret devops-secret.hcl
read -n 1



echo "Enable Key/Value Secret Engine for Engineering and Devops"
echo "#########################################################"
vault secrets enable -path=engineering/ kv-v2
vault secrets enable -path=devops/ kv-v2
read -n 1


echo "Write KV secret to Engineering and Devops engines"
echo "#################################################"
vault kv put engineering/secret db_password="abcd-1234-pqrs-5678"
vault kv put devops/secret db_password="AXY786345"
read -n 1

