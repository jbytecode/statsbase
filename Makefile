.PHONY: test 


test: statsbase_test.v statsbase.v 
	v -stats test .


