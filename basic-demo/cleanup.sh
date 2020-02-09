echo "Cleaning up Basic Demo Setup...."

vault secrets disable engineering/
vault secrets disable devops/


vault policy delete engineering-secret
vault policy delete devops-secret

vault delete auth/userpass/users/bob
vault delete auth/userpass/users/ellen
vault auth disable userpass
