#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the Flutter web app
echo "Building Flutter web app..."
flutter build web --release

# Deploy to Firebase Hosting
echo "Deploying to Firebase Hosting..."
firebase deploy

echo "Deployment completed successfully!" 