IMG = centos7
TAG = latest

USER = jw
GROUP = staff

default: sh

build:
	docker build -t $(IMG) .

run:
	docker run -d \
	    --cpus=4 --memory=4g \
	    --hostname localhost \
	    --mac-address 00:0c:29:0b:2c:39 \
	    -p 5901:5901 -p 6901:6901 \
	    --shm-size=256m \
	    -e VNC_RESOLUTION=1920x1080 \
	    -e VNC_PW=123456 \
	    -v /Volumes/nas/nfs:/nfs \
	    -v /Volumes/nas:/mnt/nas \
	    --name $(IMG) \
	    $(IMG):$(TAG)

commit:
	docker commit $(IMG) $(IMG):$(TAG)

sh:
	docker exec -it \
	    $(IMG) \
	    /bin/bash

clean:
	docker container prune
