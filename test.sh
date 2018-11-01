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

openssl aes-256-cbc -K $encrypted_15f3c740145e_key -iv $encrypted_15f3c740145e_iv -in github.enc -out github -d
chmod 600 github
eval `ssh-agent -s`
ssh-add github

cd $DEST_FOLDER
git init
git checkout -b gh-pages
git add .
git commit -m "Deploy to Github Pages"
git push --force $SSH_REPO $TARGET_BRANCH
