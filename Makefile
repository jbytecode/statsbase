.PHONY: test 
.PHONY: clean

test: statsbase_test.v statsbase.v 
	v -stats test .

build: statsbase.v 
	v -shared .

