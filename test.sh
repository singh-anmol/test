#!/bin/bash

# Exit with nonzero exit code if anything fails
set -e

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"

SOURCE_FOLDER="website"
DEST_FOLDER="gh-pages"

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`\

git clone $REPO phimp
cd phimp

rm -rf $DEST_FOLDER
mkdir $DEST_FOLDER
cp -r $SOURCE_FOLDER/* $DEST_FOLDER
echo '---\nlayout: default \n---''\n'"$(cat readme.md)" >  $DEST_FOLDER/index.markdown

cd gh-pages
git init
git add .
git commit -m "Deploy to Github Pages"
git push --force $SSH_REPO $TARGET_BRANCH
