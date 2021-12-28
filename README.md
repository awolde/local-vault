# local-vault
A local custom made docker container to run your vault instance.

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
