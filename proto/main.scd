/********
nanocontrol
akai mpkmini x2
ferrari gp

impact gamepad older
nanocontrol2

multitouchpad
touchOSC & arduino



* EXAMPLE for big, flexible setup:
* 4 sound processes among those provided
* choose between different GUI/HW controllers to play the 4 sounds

- sound choice:
-- 2 sounds with recognizable pitch/timbre (frya, dog)
-- 2 chaotic ones (xFMSH, revFB)

GUI:
- Standard Slider Window
- Sliders 2D
- KeyPlayer with presets (H demo)

MOBILE OSC APPS:
- TouchOSC,
- GyrOsc
- Mac MultiTouchPad

MIDI:
- NanoKtl2
HID:
- GamePad: Impact, Ferrari
- Cyborg Joystick
- Macally AirStick

ToDo:
add
- INFLUX !!

Server.killAll;
*********/

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
(
(
///////////    PREPARATION	  ///////////////////////
q = q ? ();


"0_globals/0_loadGlobalUtils.scd".loadRelative;
"0_globals/1_serverConfig.scd".loadRelative;
"0_globals/2_networkConfig.scd".loadRelative;
"0_globals/2a_findInterfaces.scd".loadRelative;

"0_globals/4_preset_win_func.scd".loadRelative;


s.latency = nil;	// make the server respond to controls immediately;
q.numChans = 2;

s.waitForBoot({
	q.postServerOptions;
	q.pxmix = NdefMixer(s, 12);
	q.pxmix.skipjack.dt = 0.05;
	q.pxmix.moveTo(5, 5);
	ProxyMeter.addMixer(q.pxmix);
	s.scope(q.numChans).window.bounds_(Rect(700, 5, 261, 250));
});

p = Ndef.dictFor(s); // p.push;

// put this into globals .. or use in the interfaces used!
q.active = q.active ?? {()};
q.isActive = { |q, obj| q.active.any(_.includes(obj)) };
);

(
///////////    SOUNDS	  ///////////////////////
// load some sound processes - put your own here
"2_processes/fry*".loadRelative;
"2_processes/xFMSH*".loadRelative;
"2_processes/revFB*".loadRelative;
"2_processes/dog*".loadRelative;

// or let sc choose some for you:
/*
"2_processes*.scd".resolveRelative.pathMatch.scramble.keep(4)
.postcs.do(_.loadRelative);
*/

// get the loaded Ndefs by name
// - change here to also get Tdefs, Pdefs
// tell them to play, but keep amp at 0
q.ndefs = q.getNdefs;
q.ndefs.do {|ndef| ndef.set(\amp, 0).fadeTime_(1).play };
);


///////////    INTERFACES	  ///////////////////////

(
"3_interfaces/4wins*".loadRelative; /// classic 4 windows
"3_interfaces/slider2D*".loadRelative; /// 2D sliders
"3_interfaces/keyplayer*".loadRelative; /// keyplayer
"3_interfaces/makePresets*".loadRelative; /// makePresets

// Modality MIDI/HID - better choose just one for saf'ty !!

// "3_interfaces/korg-nanokontrol2_4nd*".loadRelative; /// OK!
// "3_interfaces/korg-nanokontrol_4nd*".loadRelative; /// OK!
// "3_interfaces/gamepad*".loadRelative; ///
// "3_interfaces/cyborg*".loadRelative; ///
// "3_interfaces/airstick*".loadRelative; ///
// "3_interfaces/MultiTouch*".loadRelative; /// OK!
// "3_interfaces/TouchOsc*".loadRelative; /// OK!!!
// "3_interfaces/GyrOsc_4nd*".loadRelative; /// OK!!!
// "3_interfaces/MPKMini*".loadRelative; //// OK!

);
);
