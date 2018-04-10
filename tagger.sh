#!/bin/bash
#
# Script uses TRAVIS_COMMIT_MESSAGE to automatically tag repository according to semantic versioning scheme.
# Requirements:
#   - `semver` python program (pip install semver)
#   - GH_TOKEN variable set with GitHub token. Access level: repo.public_repo
#
# Author: Pawel Krupa (@paulfantom)
#

# Some basic variables
GIT_MAIL="paulfantom@gmail.com"
GIT_USER="paulfantom"

# Overwrite default values
while getopts ":m:u:" opt; do
  case $opt in
    m) GIT_MAIL="$OPTARG" ;;
    u) GIT_USER="$OPTARG" ;;
    :) echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
  esac
done

# Git config
git config --global user.email "${GIT_MAIL}"
git config --global user.name "${GIT_USER}"
GIT_URL=$(git config --get remote.origin.url)
GIT_URL=${GIT_URL#*//}

# Test if current commit is already tagged
git tag --points-at
[[ $(git tag --points-at) ]] && exit 0

# Create tag
GIT_TAG=$([[ "$TRAVIS_COMMIT_MESSAGE" =~ ("Merge pull request".*\[feature\].*) ]] && git semver --next-minor || git semver --next-patch )
echo "$TRAVIS_COMMIT_MESSAGE"
echo $GIT_TAG

# Tag and push to remote repo
git tag $GIT_TAG -a -m "Generated tag from TravisCI for build $TRAVIS_BUILD_NUMBER"
git push https://${GH_TOKEN}:@${GIT_URL} --tags || exit 0
