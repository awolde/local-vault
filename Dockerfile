FROM ubuntu
RUN apt update && apt install nginx -y
RUN apt-get install ca-certificates -y
COPY vault-binary vault
ENV VAULT_CONFIG=/etc/vault/vault.hcl
COPY etc/default /etc/nginx/sites-enabled/
COPY .htpasswd /etc/nginx/
ENTRYPOINT nginx & ./vault server -config $VAULT_CONFIG
