//Infamous faction capturepoint code. Took over a month to make work after saying it could be ported in a day from modern TG code, after it was already ported from ancient tg code.

var/list/obj/machinery/capbeacon/cps = list()

/obj/machinery/capbeacon
	name = "MARSCOM Navigational Beacon"
	desc = "A beacon used by the MARSCOM for navigational purposes. Hacking it with your tablet would benefit your team."
	icon = 'icons/obj/machines/comm_tower.dmi'
	icon_state = "comm_tower"
	density = 1
	anchored = 1
	var/time_to_hack = 200 // How much attackby() delay beacon will get//
	var/capture_points = 5 // How much point faction will get upon capturing//
	var/ppm = 8 // Points per minute, This can be less than 1 if you want less tickets//
	var/controlled_by = null

/obj/machinery/capbeacon/New()
	..()
	name = "MARSCOM Navigational Beacon ([get_area(loc)])"
	cps.Add(src)
	update_desc()

/obj/machinery/capbeacon/Destroy()
	cps.Remove(src)
	..()

/obj/machinery/capbeacon/proc/update_desc()
	if(controlled_by)
		desc = "A beacon used by the MARSCOM for navigational purposes. Hacking it with your tablet would benefit your team. This one is under [controlled_by]'s control."
	else
		desc = "A beacon used by the MARSCOM for navigational purposes. Hacking it with your tablet would benefit your team. This one is not under anyone's control."


/obj/machinery/capbeacon/attackby(obj/item/O, var/mob/living/carbon/human/H)
	if(!istype(H))
		to_chat(H, "<span class = 'warning'>You are not a human.</span>")
		return

	var/obj/item/hud_tablet/T = O
	if(!istype(T))
		to_chat(H, "<span class = 'warning'>You need to use a tablet to interface with \the [src]</span>")
		return

	if(controlled_by == H.faction)
		to_chat(H, "<span class = 'notice'>[get_area(loc)] is already captured by your faction!</span>")
		return

	priority_announce("[H.faction] has began capturing the MARSCOM Navigational Beacon at [get_area(loc)].","MARSCOM Navigation System")
	audible_message("<b>[H.faction] has began capturing the MARSCOM Navigational Beacon [get_area(loc)]!<b>")
	if(do_after(H, time_to_hack, 1, src))
		controlled_by = H.faction
		priority_announce("[H.faction] has captured the MARSCOM Navigational Beacon at [get_area(loc)].","MARSCOM Navigation System")
		audible_message("<b>[H.faction] has captured the MARSCOM Navigational Beacon at [get_area(loc)]!<b>")
		update_desc()
		var/datum/game_mode/war/W = SSticker.mode
		if(istype(W))
			W.cap_tickets(controlled_by,capture_points)
	return