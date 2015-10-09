/*
"~/4dMAX/MetaControlSetup/0_globals/5_loadSamples.scd"
load samples into a dict/list
*/
var a;

try{ q.samples.do(_.free); q.samples = nil; };

a = (thisProcess.nowExecutingPath.dirname.dirname +/+ "4_samples/*/*.ai*").pathMatch;
a.size;

q.samples = a.collect({|path,i| Buffer.readChannel(s, path, channels: [0]) });

q.samples.collect({|b| b.path.basename}).printAll;
"\n\n*** loaded % samples into q.samples ***\n\n".postf(q.samples.size);

\;

/*
// test
q.samples.choose.play;
*/