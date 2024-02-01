include secrets.mk

.PHONY: clean

FUNCTION_TARGET = oncreatetodo
REGION = asia-northeast1
FUNCTION_SIGNATURE_TYPE = cloudevent

server_build:
	cd server/full_dart_server && dart run build_runner build --delete-conflicting-outputs

build: server_build

test: clean build
	cd server/full_dart_server && dart test

clean:
	cd server/full_dart_server && dart run build_runner clean

run: build
	cd server/full_dart_server && dart run bin/server.dart --target=$(FUNCTION_TARGET) --signature-type=cloudevent



# See: https://cloud.google.com/sdk/gcloud/reference/run/deploy
deploy: build
	gcloud run deploy $(FUNCTION_TARGET) \
		--source=. \
		--no-allow-unauthenticated \
		--project=$(PROJECT_ID) \
		--region=$(REGION) \
		--set-env-vars=ENVIRONMENT=production \
		--set-secrets=PROJECT_ID=PROJECT_ID:latest,CLIENT_ID=CLIENT_ID:latest,CLIENT_EMAIL=CLIENT_EMAIL:latest,PRIVATE_KEY=PRIVATE_KEY:latest

# See: 
# https://cloud.google.com/sdk/gcloud/reference/eventarc/triggers/create
# https://cloud.google.com/eventarc/docs/run/route-trigger-eventarc
trigger:
	gcloud eventarc triggers create $(FUNCTION_TARGET) \
    --location=$(REGION) \
    --destination-run-service=$(FUNCTION_TARGET) \
    --event-filters="type=google.cloud.firestore.document.v1.created" \
    --event-filters="database=(default)" \
    --event-filters="namespace=(default)" \
    --event-filters-path-pattern="document=todos/{todoId}" \
    --event-data-content-type="application/protobuf" \
    --service-account="$(EVENT_ARC_SERVICE_ACCOUNT_NAME)@$(PROJECT_ID).iam.gserviceaccount.com" \
		--project=$(PROJECT_ID)
