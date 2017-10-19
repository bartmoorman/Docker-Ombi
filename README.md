```
docker run \
--rm \
--detach \
--init \
--name ombi \
--network backend \
--volume /mnt/ombi-data:/data \
--publish 3579:5000 \
bmoorman/ombi:beta
```
