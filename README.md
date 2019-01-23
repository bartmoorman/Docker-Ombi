### Docker Run
```
docker run \
--detach \
--name ombi \
--publish 5000:5000 \
--volume ombi-config:/config \
bmoorman/ombi:latest
```

### Docker Compose
```
version: "3.7"
services:
  ombi:
    image: bmoorman/ombi:latest
    container_name: ombi
    ports:
      - "5000:5000"
    volumes:
      - ombi-config:/config

volumes:
  ombi-config:
```
