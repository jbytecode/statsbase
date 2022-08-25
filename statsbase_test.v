module statsbase 

fn test_sum() {
	assert 0.0 == sum([])
	assert 1.0 == sum([1.0])
	assert 2.0 == sum([1.0, 1])
	assert 15.0 == sum([1.0,2,3,4,5])
}

fn test_mean() {
	assert 0.0 == mean([])
	assert 1.0 == mean([1.0])
	assert 2.0 == mean([1.0, 2, 3])
	assert 2.5 == mean([1.0, 2, 3, 4])
}

fn test_quantile() {
	x := [1.0 2 3 4 5 6 7 8 9 10]
	assert 1.0  == quantile(x, 0.0) // Min 
	assert 10.0 == quantile(x, 1.0) // Max
	assert 5.5  == quantile(x, 0.5) // Median
}

fn test_median() {
	x := [1.0, 2, 3, 4, 5, 4, 3, 2, 1]
	y := [1.0, 2, 3, 4, 5, 5, 4, 3, 2, 1]
	assert 3.0 == median(x)
	assert 3.0 == median(y)
}

fn test_min() {
	x := [1.0, 2, 3, 4, 5, 4, 3, 2, 1]
	y := [10.0, 2, 3, 4, 5, 5, 4, 3, 2, 10]
	assert 1.0 == min(x)
	assert 2.0 == min(y)
}

fn test_max() {
	x := [1.0, 2, 3, 4, 5, 4, 3, 2, 1]
	y := [10.0, 2, 3, 4, 5, 5, 4, 3, 2, 10]
	assert 5.0 == max(x)
	assert 10.0 == max(y)
}

fn test_centerize(){
	x := [1.0, 2.0, 3.0]
	y := centerize(x)
	assert -1  == y[0]
	assert 0.0 == y[1]
	assert  1  == y[2]
}

fn test_sample_variance(){
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	assert 17.5 == sample_variance(x)
}

fn test_sample_std(){
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	assert 4.183300132670378 == sample_std(x)
}



