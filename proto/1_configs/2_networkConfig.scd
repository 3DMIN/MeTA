"\n**********  Network Config:  **********\n".postln;

// q.myIPs = OSCExplorer.getMyIPs;
NetAddr.broadcastFlag_(true);
if (NetAddr.langPort != 57120) {
	q.utils.warnWin(
		"NetAddr.langPort should be 57120, but it is %!".format(NetAddr.langPort)
		++ "\nBetter reboot SC.",
		"NetAddr.langPort is wrong!");
};

q.net.broad = NetAddr("255.255.255.255", NetAddr.langPort);

"network setup : \n"
"IP addresses : % \n".postf(q.myIPs);
"NetAddr.langPort : % \n".postf(NetAddr.langPort);
"q.broad : % \n".postf(q.net.broad);
"\n********************\n".postln;

