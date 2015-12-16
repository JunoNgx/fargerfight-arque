# Fargerfight Arque

**Fargerfight Arque** is a local-multiplayer videogame for smartphones (Android and iPhones, specifically), featuring a minimalist projectile-based combat gameplay. It is the sequel to the [2014 Fargerfight for Android](https://play.google.com/store/apps/details?id=com.junongx.fargerfight).

The game is made with [Luxe Engine](http://luxeengine.com/), which includes built-in support for [Nape Physics](http://napephys.com/) that powers majority of game mechanic.

## Developement Objectives

* Bringing Fargerfight franchise to Luxe.
* Further learning Luxe.
* Practicing effective code organization.
* Trying Nape.
* Creating example as a reference for new comers to Luxe.

## Gameplay Objectives

Two players, on each half of the screen, control their respective entity, each with one single touch. Movement is performed by touching and moving without releasing. To attack, the player is to double tap anywhere within their respective half of the screen.

The game ends when one or both of the player's entity depleted their hit point.

## Gameplay Mechanic

Gameplay's mechanic is governed mostly by [Nape Physics](http://napephys.com/).

Ordering player's entity (`entity.Azur` and `entity.Odeo`) to attack causes the release of a projectile `entity.Shard`, which will ricochet off arena's borders and deal equal damage to both entities. A hit to main body `component.FargerPhys` will deal one value of Hit Point, while hitting `component.Arquen` will accomplish the *ARQUE* technique, resulting in instant death to the target.

`entity.Shard` hitting `component.Armlet` and `component.Shield` will cause no damage. `entity.Shard` hitting `component.Armlet` will detach the component from player's entity. There is no major event upon `entity.Shard` hitting `component.Shield`, though blocking effect is not reliable, mostly likely due to Nape's physic mechanic.

Forces will be applied to physic bodies upon hit to enhance feedback towards players.

## Class overview

* **States**: `states.Play` is the main gameplay state. Menu is a transient state `states.Menu` enabled over main gameplay state. Ending screen is actually a secondary `luxe.Scene` made visible upon firing of events in `states.Play`.

* **Player's entities**: `entity.Azur` and `entity.Odeo`, extended from `entity.PlayerBase`.

* **Physical components belonging to player's entities**: `component.FargerPhys` (main body that takes damage from projectiles); `component.Armlet` (side armors which momentarily protect the main body); `component.Shield` (main secure frontal armor which can't be detached); `component.Arquen` (weapon and weak point, resulting in instant death upon being hit). All of them are extended from `component.ArmBase`. The majority of gameplay mechanics are here, called from `nape.callbacks.InteractionCallback` functions.

* **Controller components**: `component.touchcontrol.Left` and `component.touchcontrol.Right`, both extended from `component.touchcontrol.Base`. The only difference between them is checking of which side of the screen touches started from. Controlling functions will then be called from `component.touchcontrol.Base` accordingly.

* **Other components**: `component.Bloodbag` (for a visual "bleeding" effect when hit) and `component.Indicato`` (displaying of hit point with white squares over the main body).

* **Projectile**: `entity.Shard`, with physical properties governed by `component.Shard`.

* **Prop**: `prop.Essence`, practically decorative entities for visual effects without affecting the gameplay in anyway.

* **Particles**: `particle.*`, self-explanatory.

* **Constants**: `C`, list of values that require intense tuning that might majorly affect the game. For convenience.

## Debug mode

To enable physic debug mode and view the collision shapes in real-time, uncomment the line `states.Play:58` : 

```drawer = new DebugDraw();```

## Improvement wishlist

* Bug: ```component.FargerPhys:30``` random direction of feedback force. Did not have time to delve in what the issue was.
* More controllable entities. In the original Fargerfight, **Box2d** allows setting of friction for specific bodies. In **Nape**, however, this is universal for everything with `Luxe.physics.nape.space.worldLinearDrag` and `Luxe.physics.nape.space.worldAngularDrag`.
* Alternative rotation method when moving, which is less hacky and more straight-forward than current magic code `component.touchcontrol.Base:50`.
* Cut content: selection of colors before each match. Not exactly a huge problem, but I wanted to ship fast and needed to move on from this tiny project.
* Cut content: maps with pre-designated obstacles for a more tactical approach. Same as above.

## Final notes

Development period: Aug - Dec 2015 (approximately 3.5 months).

Codes are highly commented for instructive, collaborative, and self-reminding purposes.

The actual development process is here. Every commit is actual progress development, entirely in public and hidden in plain sight. Just doing this for fun :D

If you have already read this far, then I would deeply appreciate improvement suggestions (especially about that rotation when moving thingy). I'm going to need them.

Also, please feel free to fork and release your own versions of this game. I'm looking forward to them :D
