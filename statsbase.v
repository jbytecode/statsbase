module main

import math

fn geomean(x []f64) f64 {
	mut s := 0.0
	xl := x.len
	denom := 1.0 / f64(xl)
	for i in 0 .. xl {
		s += math.log(x[i])
	}
	return math.exp(denom * s)
}

fn mad(x []f64) f64 {
	med := median(x)
	xl := x.len
	mut res := []f64{len: xl}
	for i in 0 .. xl {
		res[i] = math.abs(x[i] - med)
	}
	return median(res) * 1.4826022185056018
}

/*
Pearson Correlation Coefficient
*/
fn correlation(x []f64, y []f64) f64 {
	xstd := standardize(x)
	ystd := standardize(y)
	xl := x.len
	mut s := 0.0
	for i in 0 .. xl {
		s += xstd[i] * ystd[i]
	}
	return s / (f64(xl) - 1.0)
}

fn covariance(x []f64, y []f64) f64 {
	centeredx := centerize(x)
	centeredy := centerize(y)
	mut s := 0.0
	for i in 0 .. x.len {
		s += centeredx[i] * centeredy[i]
	}
	return s / (f64(x.len) - 1.0)
}

fn sample_std(x []f64) f64 {
	return math.sqrt(sample_variance(x))
}

fn sample_variance(x []f64) f64 {
	centered := centerize(x)
	mut s := f64(0.0)
	for element in centered {
		s += element * element
	}
	return s / (f64(x.len) - 1.0)
}

fn standardize(x []f64) []f64 {
	mut centered := centerize(x)
	stddev := sample_std(x)
	for i in 0 .. x.len {
		centered[i] /= stddev
	}
	return centered
}

fn centerize(x []f64) []f64 {
	xl := x.len
	mut res := []f64{len: x.len}
	avg := mean(x)
	for i in 0 .. xl {
		res[i] = x[i] - avg
	}
	return res
}

fn max(x []f64) f64 {
	mut res := math.inf(-1)
	for element in x {
		if element > res {
			res = element
		}
	}
	return res
}

fn min(x []f64) f64 {
	mut res := math.inf(1)
	for element in x {
		if element < res {
			res = element
		}
	}
	return res
}

fn median(x []f64) f64 {
	return quantile(x, 0.5)
}

fn quantile(x []f64, p f64) f64 {
	n := x.len
	h := (n - 1) * p
	hdown := math.floor(h)
	hup := math.ceil(h)
	mut sortedx := x.clone()
	sortedx.sort()
	xup := sortedx[u64(hup)]
	xdown := sortedx[u64(hdown)]
	return xdown + ((h - hdown) * (xup - xdown))
}

fn sum(x []f64) f64 {
	mut s := f64(0.0)
	for i in 0 .. x.len {
		s += x[i]
	}
	return s
}

fn mean(x []f64) f64 {
	if x.len == 0 {
		return 0.0
	}
	return sum(x) / x.len
}

fn main() {
	print('Hello world!')
}
