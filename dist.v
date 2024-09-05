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

pub fn (obj NormalDistribution) mean() f64{
	return obj.mean 
}

pub fn (obj NormalDistribution) var() f64{
	return obj.var
}

pub fn (obj NormalDistribution) std() f64{
	return math.sqrt(obj.var) 
}

