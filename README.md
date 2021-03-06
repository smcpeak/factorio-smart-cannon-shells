Introduction
============
Smart Cannon Shells is a mod for [Factorio](https://wiki.factorio.com/).  It adds
four new kinds of cannon shells: ordinary, explosive, uranium, and explosive
uranium.  Unlike their vanilla counterparts, they pass through allies.

I created this mod as an optional complement to [RoboTank](https://mods.factorio.com/mods/smcpeak/RoboTank),
for which I am working on the ability to fire cannon shells.  The vanilla
shells cause a lot of friendly fire in that scenario due to automated and
somewhat indiscriminant firing.

I chose to not simply bundle the new shells with RoboTank in case
people don't want to use cannon shells with RoboTank, and thus do not
want the extra research and items cluttering the UI.  Also it might be
useful stand-alone or with some other mods.

Installation
============
Copy the release zip file (SmartCannonShells_X.Y.Z.zip) into the "mods" subfolder
of the [User Data Directory](https://wiki.factorio.com/Application_directory#User_Data_directory).
Then start (or restart) Factorio.  It should then appear in the Mods
list available from the Factorio main menu, initially enabled.

Usage
=====
Unlock the new technologies and craft the new items.  Every recipe is
basically the same: one vanilla shell plus one red circuit.

Smart shells pass through allies.  The explosive variants splash damage
also does not harm allies.

Limitations
===========
I'm not sure how well balanced these additions are.  I have deliberately
started at what I think is the high end in terms of cost.  Feedback on
balance is welcome in this discussion section of the mod page.

Smart shells pass through rocks and trees as if they were allies.  I suspect
that is a bug in Factorio, but it's hard to tell because the "force_condition"
attribute at the heart of this mod is not well documented.  See
[bug report on forum](https://forums.factorio.com/viewtopic.php?f=7&t=69742).

Acknowledgments
===============
I learned how to create ammunition without friendly fire by looking at
[Cannon Turret](https://mods.factorio.com/mod/vtk-cannon-turret) by VortiK.

Pi-C
[asked](https://mods.factorio.com/mod/SmartCannonShells/discussion/5e56381600922b000d06bd1a)
about removing explosive friendly fire damage and suggested a way to do
it, although it didn't quite work.  Klonan then explained how to turn
off friendly fire for explosive splash damage in [this forum
post](https://forums.factorio.com/viewtopic.php?p=484967#p484967).

Links
=====
Factorio mod portal page: https://mods.factorio.com/mods/smcpeak/SmartCannonShells

Github repo: https://github.com/smcpeak/factorio-smart-cannon-shells

RoboTank: https://mods.factorio.com/mods/smcpeak/RoboTank
