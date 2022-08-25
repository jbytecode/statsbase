module main 

import math 

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

fn centerize(x []f64) []f64 {
    xl := x.len
    mut res := []f64{len: x.len}
    avg := mean(x)
    for i in 0..xl {
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
    hup   := math.ceil(h)
    mut sortedx := x.clone()
    sortedx.sort()
    xup := sortedx[u64(hup)]
    xdown := sortedx[u64(hdown)]
    return xdown + ((h - hdown) * (xup - xdown))
}

fn sum(x []f64) f64 {
    mut s := 0.0
    for element in x {
        s += element
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
    print("Hello world!")
}