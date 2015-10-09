MeTA -- a music-making architecture
===================================
as of 9.10.2015

MeTA is a structured directory for SuperCollider performance systems.

## Install

```MeTA-install.scd``` allows to install MeTa for a new project.
It essentially copies all items in the ```proto``` folder to a given project folder.

## Glossar

+ ```q``` -- global dictionary holding everything



## File system structure

+ ```0_globals``` -- tools and utilities
    * server config
    * sample loading routine
    * network config
    * setting up master FX
    * variables to find/open all files easily
        - q.globalsDir = thisProcess.nowExecutingPath.dirname;
        - q.topDir = q.utilDir.dirname;
        - q.fulldirnames = (q.topDir +/+ "*/").pathMatch;
        - q.dirnames = q.fulldirnames.collect { |path| path.basename };
    * preset management
+ ```1_resources``` -- resources to load (samples/photos/...)
    * subdirectory ```samples``` contains directories with sample-packs (maybe as well videos/images/texts/etc)
        - load sample-packs into ```Buffer```s via ```loadToBuffer```-util.
        - sample-Buffer accessible via ```q.samples[<dirname>][<samplename>]
    * subdirectory ```images``` contains images
    * subdirectory ```midi``` contains midi-files
    * ...
+ ```2_engines``` -- (audio/video) engines
    * typically ```Ndef```, ```Tdef```, or ```Pdef```
    * loading one file loads an entire process and its side-info in one go.
    * filename equals process-name + ```.scd```
    * responds to the interface
        - ```play``` -- makes the process audible
        - ```stop``` -- mutes the process, continues playing in the background
        - ```pause``` -- pauses rendering (not audible anymore)
        - ```resume``` -- resumes rendering
        - ```controlKeys``` -- possible mapping points (*parameters*)
        - ```getSpec``` -- all ControlSpecs
        - ```getSpec(<controlKey>)```  -- ```ControlSpec``` for a controlKey
            + set e.g. via ```Ndef(\blonk).addSpec(\blink, [1, 10, \exp]);```
    * does not ```play``` itself during loading.
+ ```3_auxEfx``` -- aux-effects
    * loading one file loads an entire effect and its side-info in one go.
    * filename equals process-name + ```.scd```
    * typically ```Ndef```
    * has an ```In.ar(\in.ar)``` slot defined
    * output is fully wet
    * responds to the interface
        - ```play``` -- makes the process audible
        - ```stop``` -- mutes the process, continues playing in the background
        - ```pause``` -- pauses rendering (not audible anymore)
        - ```resume``` -- resumes rendering
        - ```controlKeys``` -- possible mapping points (*parameters*)
        - ```getSpec``` -- all ControlSpecs
        - ```getSpec(<controlKey>)```  -- ```ControlSpec``` for a controlKey
            + set e.g. via ```Ndef(\blonk).addSpec(\blink, [1, 10, \exp]);```
    * does not ```play``` itself during loading.
    * assumes that all inputs are inserted via ```ProxySubmix(<filename>+'Aux')``` 
+ ```4_controllers``` -- set-up of controllers
    * grabs controllers
+ ```5_mapping``` -- mapping strategies between sound engines and controllers.
    * establishes the mapping between processes and controllers.
    * Maybe like 
```
Ndef(\allArm).addHalo(\gamePadMap, (
    joyLX: \topfreq,
    joyLY: \divefreq,
    joyRX: \filtfreq,
    joyRY: \amp)
);
```
+ ```6_routing```
    * contains routing skeletons that connect ```engines``` and ```aux_efx```