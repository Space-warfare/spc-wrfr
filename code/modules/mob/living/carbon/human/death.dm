/mob/living/carbon/human/gib()

	var/is_a_synth = issynth(src)
	for(var/datum/limb/E in limbs)
		if(istype(E, /datum/limb/chest))
			continue
		if(istype(E, /datum/limb/groin) && is_a_synth)
			continue
		// Only make the limb drop if it's not too damaged
		if(prob(100 - E.get_damage()))
			// Override the current limb status
			E.droplimb()


	if(is_a_synth)
		spawn_gibs()
		return
	..()





/mob/living/carbon/human/gib_animation()
	new /obj/effect/overlay/temp/gib_animation(loc, src, species ? species.gibbed_anim : "gibbed-h")

/mob/living/carbon/human/spawn_gibs()
	if(species)
		hgibs(loc, species.flesh_color, species.blood_color)
	else
		hgibs(loc)



/mob/living/carbon/human/spawn_dust_remains()
	if(species)
		new species.remains_type(loc)
	else
		new /obj/effect/decal/cleanable/ash(loc)


/mob/living/carbon/human/dust_animation()
	new /obj/effect/overlay/temp/dust_animation(loc, src, "dust-h")


/mob/living/carbon/human/death(gibbed)
	if(stat == DEAD)
		return

	if(pulledby)
		pulledby.stop_pulling()

	//Handle species-specific deaths.
	if(species)
		species.handle_death(src, gibbed)

	remove_typing_indicator()

	if(!gibbed && species.death_sound)
		playsound(loc, species.death_sound, 50, 1)

	if(SSticker && SSticker.current_state == GAME_STATE_PLAYING) //game has started, to ignore the map placed corpses.
		GLOB.round_statistics.total_human_deaths++
		SSblackbox.record_feedback("tally", "round_statistics", 1, "total_human_deaths")
		if(SSticker.mode.config_tag == "TDM")
			TDM_ticket_death()

	GLOB.dead_human_list += src
	GLOB.alive_human_list -= src

	return ..()

/mob/living/carbon/human/proc/TDM_ticket_death()
	var/datum/game_mode/team_death_match/this_game_mode = SSticker.mode
	switch(citizenship)
		if("NATSF")
			this_game_mode.a_team_tickets -= 1
			this_game_mode.check_finished()
		if("KOSMNAZ")
			this_game_mode.b_team_tickets -= 1
			this_game_mode.check_finished()


/mob/living/carbon/human/proc/makeSkeleton()
	if(f_style)
		f_style = "Shaved"
	if(h_style)
		h_style = "Bald"
	update_hair(0)

	status_flags |= DISFIGURED
	update_body(0)
	name = get_visible_name()
	return
