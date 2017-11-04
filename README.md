```
docker run \
--rm \
--detach \
--name ombi \
--hostname ombi \
--network backend \
--volume /mnt/ombi-data:/data \
--publish 3579:5000 \
bmoorman/ombi
```
