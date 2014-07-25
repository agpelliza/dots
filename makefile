gems:
	which gs  || gem install gs
	which dep || gem install dep
	gs init

install:
	dep install

push:
	git push origin master

pull:
	git pull origin master

test:
	rspec -f d -c -w
