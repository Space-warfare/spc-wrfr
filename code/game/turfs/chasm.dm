// Base chasm, defaults to oblivion but can be overridden
/turf/open/chasm
	name = "chasm"
	desc = "Watch your step."
	icon = 'icons/turf/chasms.dmi'
	icon_state = "smooth"
	density = TRUE //This will prevent hostile mobs from pathing into chasms, while the canpass override will still let it function like an open turf

	smooth = SMOOTH_BORDER | SMOOTH_MORE
	canSmoothWith = list(/turf/open/chasm)

/turf/open/chasm/Initialize()
	. = ..()
	AddComponent(/datum/component/chasm, SSmapping.get_turf_below(src))

	update_icon()
	update_adjacent()

/// Lets people walk into chasms.
/turf/open/chasm/CanPass(atom/movable/mover, turf/target)
	. = ..()
	return TRUE

/turf/open/chasm/proc/set_target(turf/target)
	var/datum/component/chasm/chasm_component = GetComponent(/datum/component/chasm)
	chasm_component.target_turf = target

/turf/open/chasm/proc/drop(atom/movable/AM)
	var/datum/component/chasm/chasm_component = GetComponent(/datum/component/chasm)
	chasm_component.drop(AM)

/* building on top of chasms

/turf/open/chasm/attackby(obj/item/C, mob/user, params, area/area_restriction)
	..()
	if(istype(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = C
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(!L)
			if(R.use(1))
				to_chat(user, "<span class='notice'>You construct a lattice.</span>")
				playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
				// Create a lattice, without reverting to our baseturf
				new /obj/structure/lattice(src)
			else
				to_chat(user, "<span class='warning'>You need one rod to build a lattice.</span>")
			return
	if(istype(C, /obj/item/stack/tile/plasteel))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/plasteel/S = C
			if(S.use(1))
				qdel(L)
				playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
				to_chat(user, "<span class='notice'>You build a floor.</span>")
				// Create a floor, which has this chasm underneath it
				PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			else
				to_chat(user, "<span class='warning'>You need one floor tile to build a floor!</span>")
		else
			to_chat(user, "<span class='warning'>The plating is going to need some support! Place metal rods first.</span>")
*/

/turf/open/chasm/update_icon()
	. = ..()
	smooth_icon(src)

/turf/open/chasm/proc/update_adjacent(atom/A)
	for(var/V in orange(1,A)) //he would fucking hate this
		var/atom/T = V
		if(T.smooth)
			smooth_icon(T)

/turf/open/chasm/proc/calculate_adjacencies(turf/T)
	if(!T.loc)
		return 0

	var/adjacencies = 0

	var/atom/movable/AM

	for(var/direction in GLOB.cardinals)
		AM = find_type_in_direction(T, direction)
		if(AM == NULLTURF_BORDER)
			if((T.smooth & SMOOTH_BORDER))
				adjacencies |= 1 << direction
		else if( (AM && !istype(AM)) || (istype(AM) && AM.anchored) )
			adjacencies |= 1 << direction

	if(adjacencies & N_NORTH)
		if(adjacencies & N_WEST)
			AM = find_type_in_direction(T, NORTHWEST)
			if(AM == NULLTURF_BORDER)
				if((T.smooth & SMOOTH_BORDER))
					adjacencies |= N_NORTHWEST
			else if( (AM && !istype(AM)) || (istype(AM) && AM.anchored) )
				adjacencies |= N_NORTHWEST
		if(adjacencies & N_EAST)
			AM = find_type_in_direction(T, NORTHEAST)
			if(AM == NULLTURF_BORDER)
				if((T.smooth & SMOOTH_BORDER))
					adjacencies |= N_NORTHEAST
			else if( (AM && !istype(AM)) || (istype(AM) && AM.anchored) )
				adjacencies |= N_NORTHEAST

	if(adjacencies & N_SOUTH)
		if(adjacencies & N_WEST)
			AM = find_type_in_direction(T, SOUTHWEST)
			if(AM == NULLTURF_BORDER)
				if((T.smooth & SMOOTH_BORDER))
					adjacencies |= N_SOUTHWEST
			else if( (AM && !istype(AM)) || (istype(AM) && AM.anchored) )
				adjacencies |= N_SOUTHWEST
		if(adjacencies & N_EAST)
			AM = find_type_in_direction(T, SOUTHEAST)
			if(AM == NULLTURF_BORDER)
				if((T.smooth & SMOOTH_BORDER))
					adjacencies |= N_SOUTHEAST
			else if( (AM && !istype(AM)) || (istype(AM) && AM.anchored) )
				adjacencies |= N_SOUTHEAST

	return adjacencies

/turf/open/chasm/proc/smooth_icon(turf/T)
	T.smooth &= ~SMOOTH_QUEUED
	if (!T.z)
		return
	if(QDELETED(T))
		return
	var/adjacencies = calculate_adjacencies(T)
	cardinal_smooth(T, adjacencies)

/turf/open/chasm/proc/cardinal_smooth(turf/T, adjacencies)
	//NW CORNER
	var/nw = "1-i"
	if((adjacencies & N_NORTH) && (adjacencies & N_WEST))
		if(adjacencies & N_NORTHWEST)
			nw = "1-f"
		else
			nw = "1-nw"
	else
		if(adjacencies & N_NORTH)
			nw = "1-n"
		else if(adjacencies & N_WEST)
			nw = "1-w"

	//NE CORNER
	var/ne = "2-i"
	if((adjacencies & N_NORTH) && (adjacencies & N_EAST))
		if(adjacencies & N_NORTHEAST)
			ne = "2-f"
		else
			ne = "2-ne"
	else
		if(adjacencies & N_NORTH)
			ne = "2-n"
		else if(adjacencies & N_EAST)
			ne = "2-e"

	//SW CORNER
	var/sw = "3-i"
	if((adjacencies & N_SOUTH) && (adjacencies & N_WEST))
		if(adjacencies & N_SOUTHWEST)
			sw = "3-f"
		else
			sw = "3-sw"
	else
		if(adjacencies & N_SOUTH)
			sw = "3-s"
		else if(adjacencies & N_WEST)
			sw = "3-w"

	//SE CORNER
	var/se = "4-i"
	if((adjacencies & N_SOUTH) && (adjacencies & N_EAST))
		if(adjacencies & N_SOUTHEAST)
			se = "4-f"
		else
			se = "4-se"
	else
		if(adjacencies & N_SOUTH)
			se = "4-s"
		else if(adjacencies & N_EAST)
			se = "4-e"

	var/list/New

	if(T.top_left_corner != nw)
		T.cut_overlay(T.top_left_corner)
		T.top_left_corner = nw
		LAZYADD(New, nw)

	if(T.top_right_corner != ne)
		T.cut_overlay(T.top_right_corner)
		T.top_right_corner = ne
		LAZYADD(New, ne)

	if(T.bottom_right_corner != sw)
		T.cut_overlay(T.bottom_right_corner)
		T.bottom_right_corner = sw
		LAZYADD(New, sw)

	if(T.bottom_left_corner != se)
		T.cut_overlay(T.bottom_left_corner)
		T.bottom_left_corner = se
		LAZYADD(New, se)

	if(New)
		T.add_overlay(New)

/turf/open/chasm/proc/find_type_in_direction(turf/source, direction)
	var/turf/target_turf = get_step(source, direction)
	if(!target_turf)
		return NULLTURF_BORDER

	if(source.canSmoothWith)
		var/atom/A
		if(source.smooth & SMOOTH_MORE)
			for(var/a_type in source.canSmoothWith)
				if( istype(target_turf, a_type) )
					return target_turf
				A = locate(a_type) in target_turf
				if(A)
					return A
			return null

		for(var/a_type in source.canSmoothWith)
			if(a_type == target_turf.type)
				return target_turf
			A = locate(a_type) in target_turf
			if(A && A.type == a_type)
				return A
		return null
	else
		if(isturf(source))
			return source.type == target_turf.type ? target_turf : null
		var/atom/A = locate(source.type) in target_turf
		return A && A.type == source.type ? A : null
