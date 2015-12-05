MeTA
====
*as of 05.12.2015, Till Bovermann*
[ [3DMIN](http://3DMIN.org) | [tai-studio](http://tai-studio.org) | [Modality](http://modalityteam.github.io/)]

MeTA is a performance framework for [SuperCollider](http://supercollider.github.io). It consists of a guideline (this), a structured directory (directory: "proto") and a set of classes (directory "classes").

## Install

`MeTA-install.scd`
allows to install MeTa for a new project.
Running it copies all items in the ```proto``` folder to a given project folder.

MeTA requires you to install the directory "classes" to the SuperCollider extensions folder.

## File system structure

Foldernames and filenames have an initial number that informs about the order of their execution. If folders (or files within folders) have the same number, their execution does not rely on each other.
Common features such as directory and file access/evaluation are implemented in the MeTA class. See its Documentation for details.

+ ```main.scd``` -- main performance file. This file comes as a barebone, i.e. it has a lot of stuff already in it which you have to fill and customise to your liking.
+ ```tests.scd``` -- a notepad/scratchpad for repeating tests such as "post controller values" etc.
+ ```0_utils``` -- tools and utilities
    * add general functionality here, mainly stuff that (a) does not fit into the other categories and (b) is required for the rest of your setup.
+ ```1_configs``` -- configuration files
    * server configuration
    * network configuration
    * user configuration
+ ```3_engines``` -- (audio/video) engines
    * typically ```Ndef``` (possibly also ```Tdef```, or ```Pdef```)
    * loading one file loads an entire process and its side-info in one go.
    * file name equals process-name + ```.scd```
    * responds to the interface
        - ```m.gens[\name].getHalo(\onFunc)``` -- makes the process audible
        - ```m.gens[\name].getHalo(\offFunc)``` -- mutes the process, continues playing in the background
        - ```m.gens[\name].pause``` -- pauses rendering (not audible anymore)
        - ```m.gens[\name].resume``` -- resumes rendering
        - ```m.gens[\name].controlKeys``` -- possible mapping points (*parameters*)
        - ```m.gens[\name].getSpec``` -- all ControlSpecs
        - ```m.gens[\name].getSpec(<controlKey>)```  -- ```ControlSpec``` for a controlKey
            + set e.g. via ```m.gens[\name].addSpec(\blink, [1, 10, \exp]);```
    * does ```play``` itself during loading but remains muted (e.g. via an ```on```-parameter set to ```0```).
+ ```3_efx/aux``` -- auxilliary effects
    * loading one file loads an entire effect and its side-info in one go.
    * file name equals process-name + ```.scd```
    * typically ```Ndef```
    * has an ```In.ar(\in.ar)``` slot defined through which the input signal is (automatically) routed
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
    * does ```play``` itself during loading.
    * assumes that all inputs are inserted via ```ProxySubmix(<filename>+'Aux')```
        - this is ensured if uax-effects are loaded via ```MeTA:loadAux```
+ ```3_controllers``` -- set-up of controllers
    * grabs controllers and makes it accessible via ```MeTA:ctls```
    * does _not_ implement the mapping
+ ```3_helperNdefs``` -- Ndefs for common tasks 
    * here you can store Ndefs for amplitude tracking or ramping (as needed for server-side quantisation)
+ ```5_mapping``` -- mapping strategies between sound engines and controllers.
    * automation of mapping routings between generators and controllers.
    * actual mapping is defined in the generator files (via ndef-Halo's). Here, only the actual connection between the controllers and those functions is implemented.

## Other directories

+ ```resources``` -- contains data needed for the performance (samples/photos/...)
    * subdirectory ```samples``` contains directories with sample-packs (maybe as well videos/images/texts/etc)
        - load sample-packs into ```Buffer```s via ```MeTA:loadSamples```
        - sample-Buffers accessible via ```MeTA:samples```
    * subdirectory ```images``` contains images
    * subdirectory ```midi``` contains midi-files

## 