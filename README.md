```
docker run \
--rm \
--detach \
--init \
--name ombi \
--hostname ombi \
--volume ombi-data:/data \
--publish 3579:5000 \
bmoorman/ombi
```
