/********
Server.killAll;
*********/

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
(
(
///////////    PREPARATION	  ///////////////////////
q = q ? ();


"0_utils/0_utils.scd".loadRelative;
"0_utils/0_file_operations.scd".loadRelative;
"0_utils/loadSampleFunc.scd".loadRelative;
"1_configs/1_serverConfig.scd".loadRelative;
"1_configs/2_networkConfig.scd".loadRelative;


/*
"0_utils/0_utils.scd".resolveRelative.openOS;
"0_utils/0_file_operations.scd".resolveRelative.openOS;
"1_configs/1_serverConfig.scd".resolveRelative.openOS;
"1_configs/2_networkConfig.scd".resolveRelative.openOS;
*/


s.latency = nil;	// make the server respond to controls immediately;
q.numChans = 2;

s.waitForBoot({
	q.utils.postServerOptions;
	// q.pxmix = NdefMixer(s, 12);
	// q.pxmix.skipjack.dt = 0.05;
	// q.pxmix.moveTo(5, 5);
	// ProxyMeter.addMixer(q.pxmix);
//	s.scope(q.numChans).window.bounds_(Rect(700, 5, 261, 250));
});






// ----------------------------------


// p = Ndef.dictFor(s); // p.push;
//
// // put this into globals .. or use in the interfaces used!
// q.active = q.active ?? {()};
// q.isActive = { |q, obj| q.active.any(_.includes(obj)) };
);

(
///////////    SOUNDS	  ///////////////////////
// load some sound processes - put your own here
"2_engines/fry*".loadRelative;
"2_engines/dog*".loadRelative;


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
