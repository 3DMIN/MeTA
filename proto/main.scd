/********
Server.killAll;
*********/

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
(
(
///////////    PREPARATION	  ///////////////////////
q = q ? ();


"0_utils/0_utils.scd".loadRelative;

q.utils.loadDocs("utils",   ["loadSample*", "*file_op*"]);
q.utils.loadDocs("configs", ["*server*", "*network*"]);

// have a language config here as well?
// this would have e.g.
q.numChans = 2;


/*
q.utils.openDocs("utils",   ["*utils*", "*loadSample*", "*file_op*"]);
q.utils.openDocs("configs", ["*server*", "*network*"]);
*/


s.latency = nil;	// make the server respond to controls immediately;

s.waitForBoot({
	q.utils.postServerOptions;

	// load resources
	/*q.utils.loadSamples("tack");*/

	q.pxmix = NdefMixer(s, 12);
	q.pxmix.skipjack.dt = 0.05;
	q.pxmix.moveTo(5, 5);
	ProxyMeter.addMixer(q.pxmix);
//	s.scope(q.numChans).window.bounds_(Rect(700, 5, 261, 250));
});


);

q.utils.loadSamples("tack", true)

q.utils.openDocs("engines", "*chain*")


(
///////////    ENGINES	  ///////////////////////

q.utils.loadDocs("engines", ["*wiggler*"]);


// get the loaded Ndefs by name
// - change here to also get Tdefs, Pdefs
// tell them to play, but keep amp at 0
q.ndefs = q.getNdefs;
q.ndefs.do {|ndef| ndef.set(\amp, 0).fadeTime_(1).play };
);


///////////    INTERFACES	  ///////////////////////

(
"4_controllers/makePresets*".loadRelative; /// makePresets
"4_controllers/miniBees-xpee*".loadRelative; /// load all available miniBees with XPee boards such that they can be mapped below


// Modality MIDI/HID - better choose just one for saf'ty !!


);


///////////    MAPPING   	  ///////////////////////

(
"5_mapping/miniBee2fry*".loadRelative
);

);
