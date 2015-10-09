/*
MeTA -- a music-making architecture
this is a script to create the filesystem structure

filesystem structure in subdir proto is installed (via unix command install).


ToDo: add a way able to select which parts to
*/

q = ();
q.slash = Platform.pathSeparator;

	// put path basePath for your setup here
	// this path must exist.
q.basePath = ("HOME".getenv +/+ "tmp").pathMatch.first;
	// your project's name
	// this name should be unique
q.projectName = "blah";

q.mEtaDir = thisProcess.nowExecutingPath.dirname;
q.mEtaProtoDir = q.mEtaDir +/+ "proto".standardizePath;


// ---------------------- do not change anything below -----------------
q.listCmd = "ls -1AbpP"; // print all files in a row, end dirs with "/"

q.getSubDirs = {|q, path, parentDirs|
	var paths = "% %".format(q.listCmd, path +/+ parentDirs).postln
		.unixCmdGetStdOutLines.collect(_.escapeChar($ ));

	paths.notEmpty.if({
		paths.inject([parentDirs.drop(1).drop(-1)], {|last, elem|
			elem = parentDirs +/+ elem;
			last ++
				(elem.last == q.slash).if({
					[q.getSubDirs(path, elem)];
				}, {
					[elem.drop(1)]
				})
		})
	}, {
		parentDirs.drop(1).drop(-1); // get rid of trailing slash
	})
};


q.mEtaProtoFiles = q.getSubDirs(q.mEtaProtoDir, "").flatNoString; //WSlib dependancy

// ---------------------- Assembly -------------------------------------

q.projectDir = q.basePath +/+ q.projectName;

q.install = {|q, projectDir, protoDir, protos|
	var stamp = Date.getDate.stamp;
	protos.do{|proto|
		("file -b %".format(protoDir +/+ proto).unixCmdGetStdOut == "directory\n").if({
			"install -d %".format(projectDir +/+ proto).postln.unixCmd;
		}, {
			"install -B .% -bC % %".format(
				stamp,
				protoDir +/+ proto,
				projectDir +/+ proto
			).postln.unixCmd;
		})
	}
};

q.install(q.projectDir, q.mEtaProtoDir, q.mEtaProtoFiles);

q.projectDir.openOS;


/*
"rm -rf %".format(q.projectDir).unixCmd; // */