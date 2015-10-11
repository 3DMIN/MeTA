// RUN this entire file from elsewhere to have convenience functions //

q = q ? ();


// basic places to put things

q.utils   = q.utils   ? (); // utils
q.net     = q.net     ? (); // network-related stuff
q.maps    = q.maps    ? (); // mapping
q.ctls    = q.ctls    ? (); // controllers
q.engs    = q.engs    ? (); // engines
q.afx     = q.afx     ? (); // aux EFX
q.mfx     = q.mfx     ? (); // master EFX
q.routs   = q.routs   ? (); // routings
q.views   = q.views   ? (); // GUI views
q.samples = q.samples ? (); // samples

// helpful things to find all the files in this setup folder:
q.utilDir      = thisProcess.nowExecutingPath.dirname;
q.topDir       = q.utilDir.dirname;
q.fulldirnames = (q.topDir +/+ "*/").pathMatch;
q.dirnames     = q.fulldirnames.collect { |path| path.basename };

q.resourcesDir = q.dirnames.detect{|dir| dir.contains("resources")};
q.samplesDir   = q.resourcesDir +/+ "samples";



"/// q.topDir: %\n".postf(q.topDir);
"/// q.dirnames: ".postln;
q.dirnames.printAll;


// ----------------------------------
q.utils.warnWin = { |q, string="?!?", title="?!?"|
	var w = Window("Warning: %".format(title)).front.alwaysOnTop_(true);
	var tv = StaticText(w, w.view.bounds);
	tv.background_(Color(1, 0.75));
	tv.align_(\center);
	w.alpha_(0.9);
	tv.string_(string).font_(Font("Arial", 24));
};
// ----------------------------------

q.utils.postServerOptions = {
	"********** Server info : **********".postln;
	"s.name: % \n"
	"s.address: % \n"
	"s.latency: % \n"
	.postf(s.name, s.addr, s.latency);
	"server options:".postln;
	s.options.dump;
	"********************".postln;
	"serverConfig loaded.".postln;
	"********************".postln;
};

q.utils.loadedDocuments = ();

q.dirnames.do{|name|
	q.utils.loadedDocuments[name.asSymbol] = OrderedIdentitySet[];
};

q.utils.id2dirname = {|env, identifier|
	q.dirnames.detect{|dir| dir.contains(identifier.asString)}
};


// returns a sorted array of absolute paths
// identifier -- sstring
// docs is an array of wildcard-strings
q.utils.docPaths = {|env, identifier, docs|
	var basePath = q.topDir +/+ env.id2dirname(identifier);

	docs.bubble.flatNoString.collect{|doc|
		(basePath +/+ doc.asString).pathMatch;
	}.flatNoString.sort;
};


// opens docs
q.utils.openDocs = {|env, identifier, docs|
	env.docPaths(identifier, docs).do{|path|
		Document.open(path);
	}
};


// loads docs and collects return values in a dictionary
q.utils.loadDocs = {|env, identifier, docs|
	// load in alphabetical order
	var paths = env.docPaths(identifier, docs);
	var keys = paths.collect{|p| p.basename.asSymbol};

	// book-keeping
	q.utils.loadedDocuments[env.id2dirname(identifier).asSymbol].addAll(keys);

	[keys, paths].flop.flatNoString.as(Event).collect(_.load)
};



/* tests
q.utils.docPaths("ut", ["load*", "*file*"]).collect(_.basename);
q.utils.openDocs("ut", ["load*", "*file*"]).collect(_.basename);
q.utils.loadDocs("ut", ["load*", "*file*"])

*/



//
// // a function to load relative paths, going up and down
// // should be better tested, esp. going down tree
// // match
//
// /* // open this folder programmatically, e.g. while working on setup
// defer{ thisProcess.nowExecutingPath.dirname.openOS };
// */
//
// // methods to get to processes:
//
// // limit to sounding ndefs
// q.utils.getNdefs = { Ndef.dictFor(s).envir.select({ |ndef| ndef.rate == \audio }).asArray.sort { |px1, px2| px1.key < px2.key } };
// q.utils.getTdefs = { Tdef.all.values.asArray.sort { |px1, px2| px1.key < px2.key } };
// q.utils.getPdefs = { Pdef.all.values.asArray.sort { |px1, px2| px1.key < px2.key } };
//
// q.utils.getInfluxDestins = {
// 	// automagically attach all existing proxies to GUI Buttons. (max. 5 for now..)
// 	q.utils.getNdefs ++ q.utils.getTdefs ++ q.utils.getPdefs
// };


/*(
q.utils.makeNdefPreWin = { |q, name, i = 0|
	var a, w, g, b, px, numctls;
	px = Ndef(name);
	numctls = max(px.controlKeys.size, 5);
	a = NdefPreset(name);
	try{a.loadSettings}{"=====failed to load presettings====\n\n".postln};
	w = Window("NdefPreset " ++ name.asString, Rect(420*(i%3), 200*(i div: 3), 420, 400)).front;
	w.addFlowLayout;
	g = ProxyPresetGui(a, parent: w);
	b = NdefGui(px, px.controlKeys.size, parent: w);
	b.skipjack.dt = 0.03;
	g.skipjack.dt = 0.03;

	px.addHalo(\preWin, w);
	w;
};
);  */




""; // dont post q
