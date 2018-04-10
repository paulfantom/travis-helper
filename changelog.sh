#!/bin/bash
#
# Script automatically generates CHANGELOG.md by using https://github.com/skywinder/github-changelog-generator
# Requirements:
#   - GH_TOKEN variable set with GitHub token. Access level: repo.public_repo
#   - docker
#
# Author: Pawel Krupa (@paulfantom)
#

# Some basic variables
GIT_MAIL="paulfantom@gmail.com"
GIT_USER="paulfantom"
ORGANIZATION=$(echo "$TRAVIS_REPO_SLUG" | awk -F '/' '{print $1}')
PROJECT=$(echo "$TRAVIS_REPO_SLUG" | awk -F '/' '{print $2}')

# Overwrite default values
while getopts ":m:u:" opt; do
  case $opt in
    m) GIT_MAIL="$OPTARG" ;;
    u) GIT_USER="$OPTARG" ;;
    :) echo "Option -$OPTARG requires an argument. Exiting." >&2; exit 1 ;;
    *) echo "Invalid option passed. Exiting." >&2; exit 1 ;;
  esac
done

# Git config
git config --global user.email "${GIT_MAIL}"
git config --global user.name "${GIT_USER}"

# Generate CHANGELOG.md
git checkout master
git pull
docker run -it --rm -v "$(pwd)":/usr/local/src/your-app ferrarimarco/github-changelog-generator \
               -u "${ORGANIZATION}" -p "${PROJECT}" --token "${GH_TOKEN}" \
               --release-url "https://galaxy.ansible.com/${ORGANIZATION}/${PROJECT}" \
               --unreleased-label "**Upcoming**" --no-compare-link
    
git add CHANGELOG.md
git commit -m '[ci skip] update changelog'
git push "https://${GH_TOKEN}:@${GIT_URL}" || exit 0
