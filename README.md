C-quencer
=========

Realtime collaborative sequencer

Setup
=====

To use the C-quencer, you need to modify the config.ck file to reflect your setup. It is currently set up in 2 modes - either a 2 computer setup or a 16 computer 4x4 grid setup. 
Modify the host_name() file to return the correct computer name in whatever set up you want. Update the server_name() to return the server name. Nothing else needs to be changed.

Use
===
To use the C-quencer, first clone all the files on all the computers. Run launch_node.ck on each node that wants to play. Run launch_server.ck on a separate computer that acts as the server. Once the ChucK files are running, run the fm_envelopes.maxpat from the max directory. This brings up the GUI for controlling the sequencer. This GUI is entirely mouse controlled.

Server Controls
===============
The server has a few special controls. By pressing the number keys, you can move through the pre-defined sections. Changing sections changes the score displayed on each sequencer as well as switches on/off the 'drone' mode. By pressing +/-, the tempo of the piece is modified - this can be used as a manual control over the energy in the piece.

Changing Scores
===============
To change the score, modify the appropriate image and sound files in the max folder.
