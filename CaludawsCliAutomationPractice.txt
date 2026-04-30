Great questions! Let me give you clear, practical answers. 🎯

---

## Connecting AWS CLI to AWS API

### The Simple Truth First

```
AWS CLI is just a tool that talks
to the AWS API on your behalf.

To do that it needs to know:
1. WHO you are (credentials)
2. WHERE to connect (region)

You set this up ONCE.
Not every day. Just once.
```

---

## Step 1 — Create IAM User (NOT root)

```
IMPORTANT SECURITY RULE:
Never use your root account
for CLI access. Ever.

Root account = the master key
to your entire AWS account.
If credentials leak = everything gone.

Instead create an IAM user
with only the permissions needed.

HOW TO DO IT:
1. Login to AWS Console
2. Go to IAM service
3. Click Users → Create User
4. Give it a name: cli-user
5. Attach policy: AdministratorAccess
   (for learning only — in real job
    use least privilege)
6. Click: Create Access Key
7. Choose: CLI
8. DOWNLOAD the CSV file immediately
   You CANNOT see the secret key again!

The CSV contains:
→ Access Key ID (like a username)
→ Secret Access Key (like a password)
```

---

## Step 2 — Configure AWS CLI (Done Once)

```
Open Git Bash and type:

aws configure

It asks you four things:

AWS Access Key ID:
→ Paste your Access Key ID

AWS Secret Access Key:
→ Paste your Secret Access Key

Default region name:
→ Type: eu-north-1
  (or whatever region you use)

Default output format:
→ Type: json

Done. That is it.
You never need to do this again
unless your keys change.
```

---

## Where Credentials Are Stored

```
AWS CLI saves your credentials in:

Windows/Git Bash:
~/.aws/credentials

Contents look like:
[default]
aws_access_key_id = AKIAIOSFODNN7EXAMPLE
aws_secret_access_key = wJalrXUtnFEMI/K7MDENG

And region in:
~/.aws/config

[default]
region = eu-north-1
output = json

These files are read automatically
every time you run any AWS command.
That is why you only configure once.
```

---

## Step 3 — Verify Connection Works

```
aws sts get-caller-identity

Output:
{
  "UserId": "AIDAEXAMPLE",
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/cli-user"
}

If you see this = connected! ✅
If you see error = credentials wrong

This is the first command to run
whenever you want to verify
your CLI is working correctly.
```

---

## Accessing Multiple Regions

### Option 1 — Per Command

```
Add --region flag to any command:

aws ec2 describe-instances --region us-east-1
aws ec2 describe-instances --region eu-west-1
aws s3 ls --region ap-southeast-1

This overrides your default region
for just that one command.
Your default stays unchanged.
```

### Option 2 — Multiple Profiles

```
Set up named profiles for each region:

aws configure --profile london
(enter same keys, region=eu-west-2)

aws configure --profile stockholm
(enter same keys, region=eu-north-1)

aws configure --profile virginia
(enter same keys, region=us-east-1)

Use a profile:
aws ec2 describe-instances --profile london
aws s3 ls --profile virginia

Or set a profile for entire session:
export AWS_PROFILE=london
(now ALL commands use london region)
```

### Option 3 — Environment Variable

```
export AWS_DEFAULT_REGION=us-east-1
(overrides config for current session)

Revert back:
unset AWS_DEFAULT_REGION
```

---

## Do You Exit AWS CLI?

```
Short answer: No.

AWS CLI is not like SSH where
you are connected and need to
disconnect. Each AWS CLI command
is a separate API call that:

1. Opens connection to AWS API
2. Sends the request
3. Gets the response
4. Closes connection automatically

There is nothing to exit.
When the command finishes
the connection is already closed.

You just close Git Bash when
you are done working.
```

---

## Launching EC2 from CLI

### What Information You Need

```
Before launching EC2 you need:

1. AMI ID (Operating System image)
   → Amazon Linux 2023:
     ami-0c1ac8a8d2f9a9b5b (eu-north-1)
   → Find current one:
     aws ec2 describe-images
     --owners amazon
     --filters "Name=name,
     Values=al2023-ami-*"
     --query 'Images[0].ImageId'

2. Instance Type
   → t2.micro (free tier)
   → t3.micro (free tier)

3. Key Pair Name
   → The name of your .pem key

4. Security Group ID
   → sg-xxxxxxxxx

5. Subnet ID (optional)
   → Which network to launch in
```

### Simple EC2 Launch Command

```
aws ec2 run-instances \
  --image-id ami-0c1ac8a8d2f9a9b5b \
  --instance-type t2.micro \
  --key-name MyKeyPair \
  --security-group-ids sg-xxxxxxxxx \
  --count 1 \
  --tag-specifications \
  'ResourceType=instance,
   Tags=[{Key=Name,Value=MyServer}]'

Breaking it down:
--image-id      = which OS to install
--instance-type = size of server
--key-name      = your .pem key name
--security-group-ids = firewall rules
--count         = how many instances
--tag-specifications = give it a name
```

### Check Instance Status

```
aws ec2 describe-instances \
  --query 'Reservations[*].Instances[*].
  [InstanceId,State.Name,PublicIpAddress]' \
  --output table

Output shows:
InstanceId    State    PublicIP
i-0abc123     running  16.171.x.x
```

### Stop and Terminate EC2

```
Stop (paused, data kept):
aws ec2 stop-instances \
  --instance-ids i-0abc123

Start again:
aws ec2 start-instances \
  --instance-ids i-0abc123

Terminate (deleted forever!):
aws ec2 terminate-instances \
  --instance-ids i-0abc123
```

---

## Creating S3 Buckets from CLI

### What Information You Need

```
1. Bucket name (globally unique!)
   → No two buckets in the world
     can have the same name
   → Use your name + random: 
     bappa-bucket-2025-xyz

2. Region
   → Where to create the bucket

3. Access settings
   → Public or private?
```

### Create S3 Bucket

```
Create bucket:
aws s3 mb s3://bappa-bucket-2025-xyz \
  --region eu-north-1

mb = make bucket

List your buckets:
aws s3 ls

Upload a file to bucket:
aws s3 cp myfile.txt s3://bappa-bucket-2025-xyz/

Download a file:
aws s3 cp s3://bappa-bucket-2025-xyz/myfile.txt .

List files in bucket:
aws s3 ls s3://bappa-bucket-2025-xyz/

Delete a file:
aws s3 rm s3://bappa-bucket-2025-xyz/myfile.txt

Delete entire bucket:
aws s3 rb s3://bappa-bucket-2025-xyz --force
```

---

## Key Information Required for Automation

```
When automating AWS with scripts
these are the values you need to
store as variables:

REGION="eu-north-1"
AMI_ID="ami-0c1ac8a8d2f9a9b5b"
INSTANCE_TYPE="t2.micro"
KEY_NAME="MyKeyPair"
SECURITY_GROUP="sg-xxxxxxxxx"
BUCKET_NAME="bappa-bucket-2025"

Store sensitive values in:
→ AWS Secrets Manager
→ Environment variables
→ .env files (never commit to GitHub!)
→ AWS Parameter Store

NEVER store access keys in:
→ Scripts
→ GitHub repositories
→ Shared files
```

---

## Simple Automation Script Example

```bash
#!/bin/bash
# Launch EC2 and S3 automation

REGION="eu-north-1"
AMI_ID="ami-0c1ac8a8d2f9a9b5b"
INSTANCE_TYPE="t2.micro"
KEY_NAME="MyKeyPair"
BUCKET_NAME="bappa-project-$(date +%Y%m%d)"

echo "Creating S3 bucket..."
aws s3 mb s3://$BUCKET_NAME --region $REGION
echo "Bucket created: $BUCKET_NAME"

echo "Launching EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --region $REGION \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "Instance launched: $INSTANCE_ID"

echo "Waiting for instance to start..."
aws ec2 wait instance-running \
  --instance-ids $INSTANCE_ID

echo "Getting public IP..."
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

echo "Instance is running!"
echo "Instance ID: $INSTANCE_ID"
echo "Public IP: $PUBLIC_IP"
echo "Connect with: ssh -i $KEY_NAME.pem ec2-user@$PUBLIC_IP"
```

---

## Most Important AWS CLI Commands to Know

```
VERIFY CONNECTION:
aws sts get-caller-identity

EC2:
aws ec2 describe-instances
aws ec2 run-instances (launch)
aws ec2 stop-instances
aws ec2 start-instances
aws ec2 terminate-instances

S3:
aws s3 ls (list buckets)
aws s3 mb (make bucket)
aws s3 cp (copy files)
aws s3 rm (remove files)
aws s3 rb (remove bucket)

IAM:
aws iam list-users
aws iam create-user

GENERAL:
--region (override region)
--profile (use named profile)
--output table/json/text
--query (filter output)
```

---

## Interview Questions on This Topic

```
Q: How does AWS CLI authenticate?
A: Using Access Key ID and Secret
   Access Key stored in ~/.aws/credentials
   configured with aws configure.

Q: Is it safe to use root credentials in CLI?
A: No. Always create an IAM user with
   only required permissions and use
   those credentials instead.

Q: How do you access multiple regions?
A: Use --region flag per command or
   set up named profiles with
   aws configure --profile name
   or use export AWS_DEFAULT_REGION.

Q: What is aws sts get-caller-identity?
A: Verifies your CLI is connected and
   shows which IAM user or role is
   currently authenticated.

Q: How do you prevent exposing credentials?
A: Never put credentials in scripts or
   GitHub. Use IAM roles for EC2,
   AWS Secrets Manager for sensitive data
   and environment variables for local work.
```

Try running `aws configure` in your Git Bash right now and then `aws sts get-caller-identity` to verify it works. Tell me what you see! 💪
