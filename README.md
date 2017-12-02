### Usage
```
docker run \
--rm \
--detach \
--init \
--name ombi \
--hostname ombi \
--volume ombi-config:/config \
--publish 3579:5000 \
bmoorman/ombi
```
