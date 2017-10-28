```
docker run \
--rm \
--detach \
--name ombi \
--hostname ombi \
--network backend \
--volume /mnt/ombi-data:/data \
--publish 3579:3579 \
bmoorman/ombi
```
