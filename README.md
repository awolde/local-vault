# local-vault
A local custom made docker container to run your vault instance.

## Rationale
There is only one person in your household that knows all the passwords, why not share them within your LAN hosted vault?
Also I dont trust lastpass, etc ;)

## Login
Use Oauth with your gmail account.
![vault login](vault.png | width=100)

## Pre-req
- SSL certs - self signed is fine, you're gonna use it in your LAN eitherway.
- .htpasswd file generated with `htpasswd` command to add allowed users to access Vault UI.
- Vault binary - from HashiCorp site for Ubuntu.

## Deploy
- Copy the SSL key and cert to `etc/` directory.
- Copy your generated `.htpasswd` file in this dir.
- Rename vault binary you downloaded to `vault-binary` and put it in this dir.
- run `./build.sh`

## Architecture
This is a single vault container frontended by nginx to handle SSL termination.

All your secrets will be local `vault/` directory, make a backup of that as needed.

Basic Auth in nginx is configured not to ask for login for internal `192.168.0.0/16` Ip range. This is a good idea if you plan on exposing Vault to the internet.

## Configure Vault
A terraform file is provided to configure your vault instance to auth with Gmail. Populate the appropriate values in a tfvars file for the following:
```
domain -> your domain, oidc wont work with IP addresses. You can use localhost for testing, thats about it.
gmail_ids -> you can get that from the container logs, google assigns your account some long a$$ number
client_id -> GCP console on Oauth credentials
client_secret -> Keep this secret from Oauth credentials from above
```

## How to htpasswd
```
$ sudo apt install apache2-utils
$ htpasswd -c file user
New password:
Re-type new password:
Adding password for user user
$ cat file
user:$apr1$7A67oITs$LRD/fUbARKqMd0B5GfqJg.
```

## Port forward with SSH
Q: Forward vault container running on `192.168.1.5:8200` to your localhost port 8200 for oidc testing?

A: `ssh -L 8200:localhost:8200 awolde@192.168.1.5`
