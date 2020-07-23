/turf/open/simplechasm //Don't use these
	name = "chasm"
	desc = "Watch your step."
	icon = 'icons/turf/chasm.dmi'
	icon_state = "chasm"
	var/drop_x = 1
	var/drop_y = 1
	var/drop_z = 1

/turf/open/simplechasm/Entered(atom/movable/AM)
	if(istype(AM, /mob/dead/observer) || istype(AM, /obj/projectile))
		return
	drop(AM)

/turf/open/simplechasm/proc/drop(atom/movable/AM)
	visible_message("[AM] falls into [src]!")
	AM.forceMove(locate(drop_x, drop_y, drop_z))
	AM.visible_message("[AM] falls from above!")
	if(istype(AM, /mob/living))
		var/mob/living/L = AM
		L.adjustBruteLoss(30)

/turf/open/simplechasm/straight_down/New()
	..()
	drop_x = x
	drop_y = y
	if(z+1 <= world.maxz)
		drop_z = z+1
