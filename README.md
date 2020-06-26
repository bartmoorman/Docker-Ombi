### Docker Run
```
docker run \
--detach \
--name ombi \
--restart unless-stopped \
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
    restart: unless-stopped
    ports:
      - "5000:5000"
    volumes:
      - ombi-config:/config

volumes:
  ombi-config:
```

### Environment Variables
|Variable|Description|Default|
|--------|-----------|-------|
|TZ|Sets the timezone|`America/Denver`|
