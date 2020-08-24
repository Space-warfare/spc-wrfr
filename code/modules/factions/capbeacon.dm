//Infamous faction capturepoint code. Took over a month to make work after saying it could be ported in a day from modern TG code, after it was already ported from ancient tg code.

var/list/obj/machinery/capbeacon/cps = list()
var/mob/living/carbon/human/H

/obj/machinery/capbeacon
	name = "MARSCOM Navigational Beacon"
	desc = "A beacon used by the MARSCOM for navigational purposes. Hacking it with your tablet would benefit your team."
	icon = 'icons/obj/machines/comm_tower.dmi'
	icon_state = "comm_tower"
	density = 1
	anchored = 1
	var/controlled_by	= null

	var/path_ending = null
	var/area = null

/obj/machinery/capbeacon/New()
	..()
	name = "MARSCOM Navigational Beacon ([area = get_area(loc)])"
	area = null
	cps = src
	update_desc()

/obj/machinery/capbeacon/proc/update_desc()
	if(controlled_by)

		desc = "A beacon used by the MARSCOM for navigational purposes. Hacking it with your tablet would benefit your team. This one is under [controlled_by]'s control."
	else
		desc = "A beacon used by the MARSCOM for navigational purposes. Hacking it with your tablet would benefit your team. This one is not under anyone's control."


/obj/machinery/capbeacon/attack_hand(mob/user, obj/item/O)

	if(!istype(user,/mob/living/carbon/human))
		say("You are not a human.")
		return

	var/mob/living/carbon/human/H = user
	var/obj/item/hud_tablet/T = O

	if(controlled_by == H.faction)
		say("[area = get_area(loc)] is already captured!")
		return

	priority_announce("[H.faction] has began capturing the MARSCOM Navigational Beacon at [area = get_area(loc)].","MARSCOM Navigation System")
	audible_message("<b>[H.faction] has began capturing the MARSCOM Navigational Beacon [area = get_area(loc)]!<b>")
	if(do_after(user, 200, 1, src))
		controlled_by = H.faction
		priority_announce("[H.faction] has captured the MARSCOM Navigational Beacon at [area = get_area(loc)].","MARSCOM Navigation System")
		audible_message("<b>[H.faction] has captured the MARSCOM Navigational Beacon at [area = get_area(loc)]!<b>")
		update_desc()
		process()
	return