#define KOSMNAZ_VICTORY "KOSMNAZ_VICTORY"
#define NATSF_VICTORY "NATSF_VICTORY"

//War, an HvH mode where players must kill or capture specific areas in order to drain the opposing faction's tickets. - Tennessee116

/datum/game_mode/war
	name = "War"
	config_tag = "War"
	required_players = 0
	votable = TRUE
	var/natsf_tickets = 100
	var/kosmnaz_tickets = 100

/datum/game_mode/war/announce()
	to_chat(world, "<b>The current game mode is War!</b>")
	to_chat(world, "<b>Assume DEFCON 1, prepare for all-out war!</b>")

/datum/game_mode/war/proc/kill_tickets(var/mob/living/carbon/human/H)
	if(H.undefibbable == 1)
		if(H.faction == "NATSF")
			natsf_tickets -= 100
		if(H.faction == "KOSMNAZ")
			kosmnaz_tickets -= 100
	return

/datum/game_mode/war/proc/cap_tickets(var/obj/machinery/capbeacon/B)
	if(B.controlled_by == null)
		return
	if(B.controlled_by == "NATSF")
		kosmnaz_tickets -= 100
	if(B.controlled_by == "KOSMNAZ")
		natsf_tickets -= 100

/datum/game_mode/war/proc/ticket_processing()
	. = ..()
	kill_tickets(loc()
	cap_tickets()
	if(natsf_tickets <= 0)
		round_finished = KOSMNAZ_VICTORY
		return TRUE
	if(kosmnaz_tickets <= 0)
		round_finished = NATSF_VICTORY
		return TRUE
	return FALSE


/datum/game_mode/war/process()
	ticket_processing()
	if(round_finished)
		return FALSE

/datum/game_mode/war/distress/check_finished()
	ticket_processing()
	if(round_finished)
		return TRUE

/datum/game_mode/war/declare_completion()
	. = ..()
	var/F = null
	to_chat(world, "<span class='round_header'>|Round Complete|</span>")
	to_chat(world, "<span class='round_body'>The [F] soldiers are victorious</span>")
	var/sound/S = null
	switch(round_finished)
		if(KOSMNAZ_VICTORY)
			S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
			F = "KOSMNAZ"
		if(NATSF_VICTORY)
			S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
			F = "NATSF"

	SEND_SOUND(world, S)

	log_game("[round_finished]\nGame mode: [name]\nRound time: [duration2text()]\nEnd round player population: [length(GLOB.clients)]\nTotal humans spawned: [GLOB.round_statistics.total_humans_created]")

	announce_medal_awards()
	announce_round_stats()
