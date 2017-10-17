```
docker run \
--rm \
--detach \
--init \
--name ombi \
--network backend \
--volume ombi-data:/data \
--publish 3579:3579 \
bmoorman/ombi
```
