module statsbase 

import math

fn test_sum() {
	assert 0.0 == sum([])
	assert 1.0 == sum([1.0])
	assert 2.0 == sum([1.0, 1])
	assert 15.0 == sum([1.0, 2, 3, 4, 5])
}

fn test_mean() {
	assert 0.0 == mean([])
	assert 1.0 == mean([1.0])
	assert 2.0 == mean([1.0, 2, 3])
	assert 2.5 == mean([1.0, 2, 3, 4])
}

fn test_quantile() {
	x := [1.0, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	assert 1.0 == quantile(x, 0.0) // Min
	assert 10.0 == quantile(x, 1.0) // Max
	assert 5.5 == quantile(x, 0.5) // Median
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

fn test_combination(){
	assert combination(5, 3) == 10
	assert combination(5, 5) == 1
	assert combination(5, 0) == 1
	assert combination(25, 4) == 12650
	assert combination(100, 3) == 161700
}

fn test_prod(){
	assert prod(1, 5) == 120
	assert prod(3, 5) == 60
}

fn test_centerize() {
	x := [1.0, 2.0, 3.0]
	y := centerize(x)
	assert -1 == y[0]
	assert 0.0 == y[1]
	assert 1 == y[2]
}

fn test_standardize() {
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	stdx := standardize(x)
	assert -0.9561828874675149 == stdx[0]
	assert -0.7171371656006361 == stdx[1]
	assert -0.47809144373375745 == stdx[2]
	assert 1.1952286093343936 == stdx[3]
	assert 0.9561828874675149 == stdx[4]
}

fn test_sample_variance() {
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	assert 17.5 == sample_variance(x)
}

fn test_sample_std() {
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	assert 4.183300132670378 == sample_std(x)
}

fn test_covariance() {
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	y := [9.0, 10, 3, 2, 1]
	assert 17.5 == covariance(x, x)
	assert -14.5 == covariance(x, y)
}

fn test_correlation() {
	eps := 0.0001
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	y := [9.0, 10, 3, 2, 1]
	assert math.abs(1.0 - correlation(x, x)) < eps
	assert math.abs(-0.8285714285714286 - correlation(x, y)) < eps
}

fn test_mad() {
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	xmad := mad(x)
	assert 2.9652044370112036 == xmad
}

fn test_geomean() {
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	assert 3.5194820289355238 == geomean(x)
}

fn test_harmmean(){
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	assert 2.4456521739130435 == harmmean(x)
}

fn test_wsum(){
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	w := [1.0, 1.0, 1.0, 1.0, 2.0]
	assert 34.0 == wsum(x, w)
}

fn test_wmean(){
	x := [1.0, 2.0, 3.0, 10.0, 9.0]
	w := [1.0, 1.0, 1.0, 1.0, 2.0]
	assert 5.666666666666667 == wmean(x, w)
}

fn test_normaldistribution(){
	nd := NormalDistribution{mean: 0.0, var: 1.0}
	assert nd.mean() == 0.0
	assert nd.var()  == 1.0
	assert nd.std()  == 1.0
}

fn test_inverf(){
	eps := 0.005
	assert inverf(0.0) == 0.0
	assert math.abs(inverf(0.1) - 0.08885599049425769) < eps 
	assert math.abs(inverf(0.5) - 0.4769362762044699) < eps 
	assert math.abs(inverf(0.8) - 0.9061938024368231) < eps 
}

fn test_qnorm(){
	eps := 0.005
	assert math.abs(qnorm(0.0, 1.0, 0.05 / 2) - -1.9599639845400592) < eps
}

fn test_dnorm(){
	eps := 0.005
	assert math.abs(dnorm(0.0, 0.0, 1.00) - 0.3989423) < eps
	assert math.abs(dnorm(1.0, 0.0, 1.00) - 0.2419707) < eps
	assert math.abs(dnorm(-1.0, 0.0, 1.00) - 0.2419707) < eps
}

fn test_integrate(){
	eps := 0.001
	f := fn (x f64) f64 {
		return x * x 
	}
	result := integrate(f, 0.0, 1.0)
	assert math.abs(result -  0.33333) < eps 
}

fn test_pnorm(){
	eps := 0.005
	assert math.abs(pnorm(-1.96, 0.0, 1.00) - 0.0249) < eps
}

fn test_dunif(){
	a := 0.0
	b := 1.0
	assert dunif(0, a, b) == 1 / (b-a)
	assert dunif(0.5, a, b) == 1 / (b-a)
	assert dunif(0.75, a, b) == 1 / (b-a)
}

fn test_qunif(){
	assert qunif(0, 0, 1) == 0
	assert qunif(0.5, 0, 1) == 0.5
	assert qunif(0.75, 0, 1) == 0.75

	assert qunif(0.1, 0, 10) == 1
	assert qunif(0.5, 0, 10) == 5
	assert qunif(0.75, 0, 10) == 7.5
}

fn test_punif(){
	eps := 0.001
	assert math.abs(punif(2.0, 1.0, 10) - 0.11111) < eps 
	assert math.abs(punif(5.0, 1.0, 10) - 0.4444444) < eps 
	assert math.abs(punif(9.0, 1.0, 10) - 0.8888889) < eps 
}

fn test_dexp(){
	eps := 0.001
	assert math.abs(dexp(3, 5.0) - 0.1097623) < eps 
	assert math.abs(dexp(4, 5.0) - 0.08986579) < eps 
}

fn test_qexp(){
	eps := 0.001
	assert math.abs(qexp(0.5, 5.0) - 3.465736) < eps 
	assert math.abs(qexp(0.75, 10.0) - 13.86294) < eps 
}

fn test_pexp(){
	eps := 0.001
	assert math.abs(pexp(3, 5.0) - 0.4511884) < eps 
	assert math.abs(pexp(4, 10.0) - 0.32968) < eps 
}

fn test_dbinom(){
	eps := 0.001
	assert math.abs(dbinom(5, 10, 0.5) - 0.2460938) < eps 
	assert math.abs(dbinom(5, 50, 0.25) - 0.004937859) < eps
}