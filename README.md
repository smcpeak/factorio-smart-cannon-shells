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

Manual Installation
===================

Copy the release zip file (SmartCannonShells_X.Y.Z.zip) into the "mods" subfolder
of the [User Data Directory](https://wiki.factorio.com/Application_directory#User_Data_directory).
Then start (or restart) Factorio.  It should then appear in the Mods
list available from the Factorio main menu, initially enabled.

Usage
=====

Unlock the new technologies and craft the new items.  Every recipe is
basically the same: one vanilla shell plus one red circuit.

By default, smart shells pass through units of the same force, and the
explosive variants' splash damage does not harm them.

Configuration
=============

The precise targeting condition can be set in the startup settings:

* Not same (default): Hits any unit that is not the same force,
  including trees and rocks.

* Not friend: Hits any unit that is not part of a friendly force.
  Does *not* hit trees and rocks.

* Enemy: Hits any unit that is part of an enemy force.
  Does *not* hit trees and rocks.

* There are a few other settings (everything else the internal API
  supports) meant only for testing.

The default hits trees and rocks because clearing them at the same time
as shooting bugs is helpful for visibility and navigation, but it has
the drawback of not working well in the case of an allied but not the
same force, hence the setting is configurable.

Limitations
===========

I'm not sure how well balanced these additions are.  I have deliberately
started at what I think is the high end in terms of cost.  Feedback on
balance is welcome in this discussion section of the mod page.

It would be good if there were a targeting setting that would hit trees
and rocks while not hitting any allied force, but the API does not
provide that capability.  See
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
