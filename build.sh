echo "Getting latest git updates"
git pull

BASE_IMAGE_NAME="localhost:6500/chaos-control-2"

echo "Building image $BASE_IMAGE_NAME:$1"
docker build . -t "$BASE_IMAGE_NAME:$1"
docker tag "$BASE_IMAGE_NAME:$1" "$BASE_IMAGE_NAME:latest"
echo "Successfully build docker images"

echo "Pushing to docker registry on localhost:6500"
docker push "$BASE_IMAGE_NAME:$1"
docker push "$BASE_IMAGE_NAME:latest"


