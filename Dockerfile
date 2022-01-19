FROM ubuntu
RUN apt update && apt install nginx ca-certificates sudo -y
COPY vault-binary vault
ENV VAULT_CONFIG=/etc/vault/vault.hcl
COPY etc/default /etc/nginx/sites-enabled/
COPY .htpasswd /etc/nginx/
RUN useradd vault
ENTRYPOINT nginx & sudo -u vault ./vault server -config $VAULT_CONFIG
