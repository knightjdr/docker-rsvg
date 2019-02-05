# Docker image for rsvg-convert version 2.44.12

## Build

```
docker build --tag=rsvg .
```

## Running with no arguments will show help by default
```
docker container run -v $(pwd):/app/ rsvg
```

## Run with flags
docker container run -v $(pwd):/app/ rsvg  --version