/*
loads samples into a dict/list in q.samples[relPath]

relies on

+ utils
+ file_operations

relPath -- path relative to resources/samples
*/


q.utils.loadSamples = {|env, relPath|
	var absolutePath;
	var samplePaths;
	var baseKeyArray = relPath.notNil.if({
		relPath.split($/).collect(_.asSymbol)
	},{
		[]
	});

	try{
		// go to position in dict where samples are stored, release them.
		q.samples.traverseAt(baseKeyArray ).traverseDo(_.free);
		q.samples.traversePut(baseKeyArray, nil);
	};

	absolutePath = q.topDir +/+ q.samplesDir +/+ (relPath ? "");

	// get all paths to sound files (restricted to .wav and .aiff)
	samplePaths = q.utils.traversePathMatch(absolutePath, "")
	.flatNoString.select{|path|
		(path != "") &&
		{path.contains(".DS_Store").not}
		&& {
			path.endsWith(".wav")
			|| path.endsWith(".aif")
		}
	};
	samplePaths.do{|path|
		var sampleKeys, buffer;

		sampleKeys = baseKeyArray ++ path.splitext.first
		.split($/)
		.collect(_.asSymbol);

		buffer = Buffer.read(q.server, absolutePath +/+ path, action: {|b|
			"% loaded".format(sampleKeys).inform;
		});
		q.samples.traversePut(sampleKeys, buffer);

	}

}

/*
// test

q.utils.loadSamples("tack")
q.samples[\tack].choose.play

q.utils.loadSamples("ice")
*/
