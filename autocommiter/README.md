# HOW TO

First you need to create GitHub token with scope `repo.public_repo`

## option 1

```
export GH_TOKEN=<<your_github_token>>
./autocommiter.sh
```

## option 2

```
docker run -it -e GH_TOKEN=<<your_github_token>> paulfantom/autocommiter
```
