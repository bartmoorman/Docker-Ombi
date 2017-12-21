### Usage
```
docker run \
--rm \
--detach \
--init \
--name ombi \
--hostname ombi \
--volume ombi-config:/config \
--publish 5000:5000 \
bmoorman/ombi
```
