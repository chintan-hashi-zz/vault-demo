
echo "Enable AWS Secret Engine"
vault secrets enable -path=aws aws

aws_access_key_id="$(cat ~/.aws/credentials  | grep access_key_id | awk '{print $3}')"

aws_secret_access_key="$(cat ~/.aws/credentials  | grep secret_access | awk '{print $3}')"

echo "Attach access_key and secret_key to AWS Secret Engine"
vault write aws/config/root access_key=$aws_access_key_id secret_key=$aws_secret_access_key region=us-west-1

echo "Attach IAM permissions for new AWS Credentials"
vault write aws/roles/my-role credential_type=iam_user policy_document=@aws-ec2-policy.pol

echo "Request dynamic AWS Credentials"
vault read aws/creds/my-role

read -n 1
echo "Make sure you run - vault lease revoke aws/creds/my-role/<lease-id> to revoke AWS credentials"

