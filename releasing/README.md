# Scripts to simplify releasing new versions

## Dependencies

All scripts need to have variable `GH_TOKEN` set to current GitHub token with `repo.public_repo` scope.

### tagger.sh

Set new tag according to semantic versioning. Only PATCH and MINOR versions are possible to update this way.

### changelog.sh

Generate CHANGELOG based on GitHub features like: issues, labels, PRs, and tags

### releaser.sh

All in one solution for complete release management. At first it can set new tag (semantic versioning only), then it
generates new CHANGELOG, pushes it to master branch, and in the end it promotes git tag to GitHub release with content 
synchronized with fresh CHANGELOG.
