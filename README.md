# travis-helper

[![Travis CI](https://travis-ci.org/paulfantom/travis-helper.svg?branch=master)](https://travis-ci.org/paulfantom/travis-helper)

Helper scripts meant to be used in travis CI pipelines


## Example usage

#### After tests

```yaml
sudo: required
services:
  - docker
install:
  - pip install git-semver
script:
  - <<something>>
deploy:
  provider: script
  skip_cleanup: true
  script: git clone https://github.com/paulfantom/travis-helper.git && travis-helper/tagger.sh
  on:
    branch: master
branches:
  only:
    - master
```
