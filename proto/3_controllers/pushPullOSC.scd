// instantiate PushPullOSC

m.ctls.pp =  m.ctls.pp ?? {
	([\dominik, \amelie].includes(m.config.ppName)).if({
		PushPullOSC(m.config.ppAddr)
	}, {
		PushPullOSC_SE(m.config.ppAddr)
	})

};

m.ctls.pp.isLeft = m.config.ppIsLeft;

/*
m.ctls.pp.trace[\imu] = true
m.ctls.pp.trace[\imu] = false
m.ctls.pp.trace[\cap] = true
m.ctls.pp.trace[\cap] = false
*/




m.ctls.pp; // return value

