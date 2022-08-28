module statsbase 

import math

fn dbinom(x i64, n i64, p f64) f64 {
	return combination(n, x) * math.pow(p, x) * math.pow(1 - p, n - x)
}

fn pexp(q f64, theta f64) f64 {
	return 1.0 - math.exp(-q / theta)
}

fn qexp(p f64, theta f64) f64 {
	return -math.log(1 - p) * theta 
}

fn dexp(x f64, theta f64) f64 {
	return (1 / theta) * math.exp(-x / theta)
}

fn punif(q f64, a f64, b f64) f64{
	myf := fn [a, b] (x f64) f64 {
		return dunif(x, a, b)
	}
	if q < a {
		return 0.0
	}else{
		return integrate(myf, a, q) 
	}
}

fn qunif(p f64, a f64, b f64) f64 {
	return p * (b - a) + a
}

fn dunif(x f64, a f64, b f64) f64 {
	return 1.0 / (b - a)
}

fn pnorm(q f64, mu f64, sd f64) f64{
	myf := fn [mu, sd] (x f64) f64 {
		return dnorm(x, mu, sd)
	}
	return integrate(myf, mu + sd * (-5.0), q) 
}

fn qnorm(mu f64, sd f64, p f64) f64 {
    return math.sqrt2 * sd * inverf(2 * p - 1) + mu
}

fn dnorm(x f64, mu f64, sd  f64) f64 {
	return (1/(sd * math.sqrt(2.0 * math.pi))) * math.exp(-0.5 * math.pow(((x - mu)/sd), 2.0))
}

fn integrate(func fn (f64) f64, from f64, to f64) f64{
	mut s := 0.0
	eps := 0.0001
	mut i := from 
	for i <= to {
		s += func(i) * eps 
		i += eps 
	}
	return s 
}

fn inverf(x f64) f64{
  //a := 0.140012
  a := (8.0 * (math.pi - 3)) / (3.0 * math.pi - (4.0 - math.pi))
  return math.sign(x) *
   math.sqrt(
        math.sqrt( 
            math.pow(
                2.0/(math.pi * a) + math.log(1-x*x)/2.0, 2.0) - 
                (math.log(1.0-x*x)/a)) - (2.0/(math.pi * a) + math.log(1.0 - x*x)/2.0))
}

fn wmean(x []f64, w []f64) f64 {
    return wsum(x, w) / sum(w)
}


fn wsum(x []f64, w []f64) f64 {
    mut s := 0.0
    xl := x.len 
    for i in 0 .. xl {
        s += x[i] * w[i]
    }
    return s
}

fn harmmean(x []f64) f64{
    xl := x.len 
    mut s := 0.0
    for i in 0 .. xl {
        s += 1.0 / x[i]
    }
    return f64(xl) / s
}

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

fn combination(n i64, r i64) i64 {
	nom := prod((n - r + 1), n)
	denom := prod(2, r)
	return nom / denom
}

fn prod(from i64, to i64) i64{
	mut s := i64(1)
	mut i := from 
	for i <= to {
		s *= i
		i++
	}
	return s
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
	print('Basic Statistics functions for V language')
}
