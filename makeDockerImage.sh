export VCS_REF=$(git rev-parse --short HEAD)
export BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
export VERSION=$(cat VERSION)

docker-compose -f docker-compose.yml build -t docker-alerta:frekel \
  --build-arg VCS_REF=$VCS_REF \
  --build-arg BUILD_DATE=$BUILD_DATE \
  --build-arg ROOT_PASSWORD='frekel' \
  --build-arg VERSION=$VERSION
  
