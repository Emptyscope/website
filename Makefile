all: build

.PHONY: build

build:
	docker build -t emptyscope/website github.com/emptyscope/website

run:
	docker run -name emptyscope -d -p 80:9292 emptyscope/website bundle exec puma -e production