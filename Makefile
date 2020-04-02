IMAGE_NAME=crowd_detector
PORT ?= 9999

build:
	docker build -t $(IMAGE_NAME) .

dev:
	docker run --rm -ti  \
		--shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 --gpus all \
		-v $(PWD)/:/project \
		-w '/project' \
		$(IMAGE_NAME)

dev_gui:
	xhost local:root
	docker run --rm -ti \
		-v $$PWD/:/project \
		--shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 --gpus all \
		--env="DISPLAY" \
		--env="QT_X11_NO_MITSHM=1" \
		--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
		-w="/project" \
		$(IMAGE_NAME)

lab:
	docker run --rm -ti  \
		--shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 --gpus all \
		-p $(PORT):$(PORT) \
		-v $(PWD)/:/project \
		-w '/project' \
		$(IMAGE_NAME) \
		jupyter lab --ip=0.0.0.0 --port=$(PORT) --allow-root --no-browser
