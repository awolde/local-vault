 docker-compose down ; 
 sudo chown awolde vault -R
 docker build . -t local-vault && 
docker-compose up -d
