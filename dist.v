module statsbase 

import math 

interface Distribution {
	mean() f64
	var()  f64 
	std()  f64
}

struct NormalDistribution {
	mean f64 
	var f64 
}

fn (obj NormalDistribution) mean() f64{
	return obj.mean 
}

fn (obj NormalDistribution) var() f64{
	return obj.var
}

fn (obj NormalDistribution) std() f64{
	return math.sqrt(obj.var) 
}

