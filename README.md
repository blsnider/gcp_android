# Android Studio in Google Cloud Workstations

This project sets up a Docker image with Android Studio and GUI support via noVNC for use with Google Cloud Workstations.

## 📦 Build and Push

Replace placeholders before running:

```bash
# Authenticate if needed
gcloud auth login

# Set project
gcloud config set project [YOUR_PROJECT_ID]

# Enable Artifact Registry
gcloud services enable artifactregistry.googleapis.com

# Create Docker repo if not exists
gcloud artifacts repositories create android-dev --repository-format=docker \
  --location=us-central1

# Build
docker build -t android-studio-vnc .

# Tag
docker tag android-studio-vnc us-central1-docker.pkg.dev/[YOUR_PROJECT_ID]/android-dev/android-studio-vnc

# Push
docker push us-central1-docker.pkg.dev/[YOUR_PROJECT_ID]/android-dev/android-studio-vnc
