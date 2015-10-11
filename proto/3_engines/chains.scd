q.utils.loadSamples("tack");
q.samples.tack.choose.play

// mono files only;
SynthDef(\klankPlayer, {|out = 0, buf = 0, amp = 0.1, rate = 1|
	var src1 = PlayBuf.ar(1, buf, BufRateScale.ir(buf) * rate, doneAction: 2)!2;
	var src2 = PlayBuf.ar(1, buf, BufRateScale.ir(buf) * 0.01 * rate, doneAction: 2)!2;

	var src = [src1, src2].sum * EnvGen.ar(Env.perc(0, 0.1), doneAction: 2);
	//src = src * LFPulse.ar(50);
	Out.ar(out, src * amp);

}).add;

/*
{
	20.do{|i|
		Synth.grain(\klankPlayer, [\buf, q.samples.tack.choose.bufnum, \rate, rrand(0.95, 1) * 0.2 * i.linexp(0, 19, 1, 6), \amp, rrand(0.8, 1)]);
		(rrand(0.05, 0.04) * i.linexp(0, 19, 1, 0.4)).wait;
	}

}.fork;
*/

Ndef(\chaniz).addHalo(\envBuf, Buffer.sendCollection(q.server, Env([0, 1, 1, 0], [0, 1, 0]).discretize, 1));

Ndef(\chaniz).addHalo(\shapeBuf, Buffer.alloc(q.server, 512, 1, { |buf| buf.chebyMsg([1,0,1,1,0,1])}));

Ndef(\chainz).addSpec(\rate, [0.2, 10, \exp]);
Ndef(\chainz).addSpec(\fFreq, [2100, 1600, \exp]);
Ndef(\chainz).addSpec(\fRes, [0, 1]);
Ndef(\chainz).addSpec(\fWet, [0, 1]);

Ndef(\chainz, {
	var snd, filter;

	var envBuf = Ndef(\chaniz).getHalo(\envBuf);
	var trig = \trig.tr(0);
	var sndBuf = Demand.kr(trig, 0, Drand(q.samples.tack.asArray, inf));


	snd = GrainBufJ.ar(2, trig, \dur.kr(0.2),
		rate: \rate.kr(1),
		envbufnum: envBuf,
		sndbuf: sndBuf
	);

	snd = Shaper.ar(
		Ndef(\chaniz).getHalo(\shapeBuf),
		snd
    );

	filter = MoogLadder.ar(snd, \fFreq.kr(1710), \fRes.kr(0.9)) * 7;

	SelectX.ar(\fWet.kr(0.83), [snd, filter]);

})
Ndef(\chainz).play


Ndef(\chainz).set(\trig, 1)

