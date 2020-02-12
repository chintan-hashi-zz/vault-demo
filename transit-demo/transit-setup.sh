
echo "Enable Transit Secret Engine"
echo "############################"
vault secrets enable transit
read -n 1


echo "Create Encryption key orders - default is AES256"
echo "################################################"
vault write -f transit/keys/orders
read -n 1


echo "Encrypt Plaintext data 4111 1111 1111 1111"
echo "##########################################"
vault write transit/encrypt/orders plaintext=$(base64 <<< "4111 1111 1111 1111")
read -n 1

