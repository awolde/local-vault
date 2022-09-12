 docker-compose down ; 
 sudo chown awolde vault -R
 sudo cp -p $(which vault) vault-binary
 docker build . -t local-vault && 
docker-compose up -d
