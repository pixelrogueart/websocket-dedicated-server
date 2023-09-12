#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <GCLOUD_PROJECT_ID> <YOUR_REGION> <DATABASE_PROJECT_NAME> <SERVER_PROJECT_NAME>"
    exit 1
fi

GCLOUD_PROJECT_ID=$1
REGION=$2
DATABASE_PROJECT_NAME=$3
SERVER_PROJECT_NAME=$4

deploy_project() {
    local PROJECT_NAME=$1
    local FOLDER=$2

    cd "$FOLDER"

    docker build -t $PROJECT_NAME .

    docker run -d --name $PROJECT_NAME -p 8080:8080/tcp $PROJECT_NAME

    docker tag $PROJECT_NAME gcr.io/$GCLOUD_PROJECT_ID/$PROJECT_NAME

    docker push gcr.io/$GCLOUD_PROJECT_ID/$PROJECT_NAME

    gcloud run deploy $PROJECT_NAME --image gcr.io/$GCLOUD_PROJECT_ID/$PROJECT_NAME --platform managed --region $REGION --allow-unauthenticated

    cd -
}

deploy_project $DATABASE_PROJECT_NAME "../database"

deploy_project $SERVER_PROJECT_NAME "../server"

echo "Both deployments completed!"
