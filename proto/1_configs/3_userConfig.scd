m.config.ppName = m.config.ppName ?? {\graziele};

/////////// all ////////////
m.config.ppAddrs = (
	graziele:  NetAddr("169.254.1.1", 9000),
	katharina: NetAddr("169.254.1.1", 9000),
	ruben:     NetAddr("169.254.1.1", 9000),
	gil:       NetAddr("192.168.2.6", 9000),
	alex:      NetAddr("169.254.1.1", 9000),
	daniel:    NetAddr("169.254.1.1", 9000),
	amelie:    NetAddr("192.168.2.5", 9000),
	dominik:   NetAddr("192.168.2.4", 9000),
);

m.config.ppIsLefts = (
	graziele:  false,
	katharina: false,
	ruben:     false,
	gil:       false,
	alex:      true,
	daniel:    true,
	amelie:    false,
	dominik:   false,
);

m.config.ppWLANs = (
	graziele:  "PushPull graziele",
	katharina: "PushPull katharina",
	ruben:     "PushPull ruben",
	gil:       "3dmin-perform",
	alex:      "PushPull alex",
	daniel:    "PushPull daniel",
	amelie:    "3dmin-perform",
	dominik:   "3dmin-perform",
);

m.config.ppBaseClass = (
	graziele:  PushPullOSC_SE,
	katharina: PushPullOSC_SE,
	ruben:     PushPullOSC_SE,
	gil:       PushPullOSC_SE,
	alex:      PushPullOSC_SE,
	daniel:    PushPullOSC_SE,
	amelie:    PushPullOSC,
	dominik:   PushPullOSC,
);

m.config.ppCapTares = (
	graziele:
	[ [ 2989, 5713 ], [ 0, 1592 ], [ 0, 2672 ], [ 0, 2372 ], [ 0, 16383 ], [ 0, 16383 ] ],
	katharina:
	[ [ 2627, 5715 ], [ 0, 3101 ], [ 0, 1326 ], [ 0, 1764 ], [ 0, 16383 ], [ 0, 16383 ] ],
	ruben:
	[ [ 1984, 6331 ], [ 0, 2633 ], [ 0, 865 ], [ 0, 869 ], [ 0, 16383 ], [ 0, 16383 ] ],
	dominik:
	[ [ 0, 4313 ], [ 0, 3544 ], [ 0, 3142 ], [ 0, 2111 ], [ 0, 4818 ], [ 0, 2277 ] ],
	amelie:
	[ [ 0, 4313 ], [ 0, 3544 ], [ 0, 3142 ], [ 0, 2111 ], [ 0, 4818 ], [ 0, 2277 ] ],
);


////////// mine //////////////////////
m.config.ppAddr    = m.config.ppAddrs    [m.config.ppName];
m.config.ppIsLeft  = m.config.ppIsLefts  [m.config.ppName];
m.config.ppWLAN    = m.config.ppWLANs    [m.config.ppName];
m.config.ppCapTare = m.config.ppCapTares [m.config.ppName];



nil; // return value
