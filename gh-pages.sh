#!/bin/bash

# Exit with nonzero exit code if anything fails
set -e

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

git clone $REPO repo
cd repo

rm -r gh-pages
mkdir gh-pages

echo '---\nlayout: default \n---''\n'"$(cat readme.md)" >  gh-pages/index.markdown
cp -r website/* gh-pages

cd gh-pages
git init
git add .
git commit -m "Deploy to Github Pages"
git push --force $SSH_REPO $TARGET_BRANCH
