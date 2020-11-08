#define TICKETLOSS_KILL 1
#define KOSMNAZ_VICTORY "KOSMNAZ_VICTORY"
#define NATSF_VICTORY "NATSF_VICTORY"

//War, an HvH mode where players must kill or capture specific areas in order to drain the opposing faction's tickets. - Tennessee116

/datum/game_mode/war
	name = "War"
	config_tag = "War"
	required_players = 0
	votable = TRUE
	var/natsf_tickets = 50
	var/kosmnaz_tickets = 50
	valid_job_types = list(
		/datum/job/ussr/soldier = -1,
		/datum/job/natsf/soldier = -1
	)

/datum/game_mode/war/announce()
	to_chat(world, "<b>The current game mode is War!</b>")
	to_chat(world, "<b>Assume DEFCON 1, prepare for all-out war!</b>")

//Capture beacon will call this upon being captured//
/datum/game_mode/war/proc/cap_tickets(var/faction,var/tickets)
	if(faction == FACTION_NATSF)
		natsf_tickets += tickets
	if(faction == FACTION_USSR)
		kosmnaz_tickets += tickets

//Called when mob dies//
/datum/game_mode/war/on_mob_death(var/mob/living/M)
//	if(M.undefibbable) This wouldn't work because the proc is called on death of the mob, in most cases it dies with being defibbable yet, from my understanding anyway
	if(M.faction == FACTION_NATSF)
		natsf_tickets -= TICKETLOSS_KILL
	if(M.faction == FACTION_USSR)
		kosmnaz_tickets -= TICKETLOSS_KILL

//Takes 2 seconds per process(), this is why there's * 2 in there
//I know this is rigid as hell, but there's no pre-existing framework for this, what gives.
/datum/game_mode/war/process()
	. = ..()

	if(global.cps.len)
		for(var/obj/machinery/capbeacon/C in global.cps)
			if(C.controlled_by == FACTION_USSR)
				natsf_tickets -= C.ppm / 30
//				kosmnaz_tickets += C.pps / 30
			if(C.controlled_by == FACTION_NATSF)
//				natsf_tickets += C.pps / 30
				kosmnaz_tickets -= C.ppm / 30

	if(natsf_tickets <= 0)
		round_finished = KOSMNAZ_VICTORY
	if(kosmnaz_tickets <= 0)
		round_finished = NATSF_VICTORY

//Returns true if one faction lacks tickets//
/datum/game_mode/war/check_finished()
	if(round_finished)
		return TRUE

/datum/game_mode/war/declare_completion()
	. = ..()
	var/winner
	var/win_condition
	var/sound/S

	switch(round_finished)
		if(KOSMNAZ_VICTORY)
			winner = "KOSMNAZ"
			if(kosmnaz_tickets / initial(kosmnaz_tickets) >= 0.6)
				win_condition = "OVERWHELMING VICTORY!"
				S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
			else if(kosmnaz_tickets / initial(kosmnaz_tickets) <= 0.4)
				win_condition = "PHYRRIC VICTORY"
				S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
			else
				win_condition = "VICTORY"
				S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
		if(NATSF_VICTORY)
			winner = "NATSF"
			if(natsf_tickets / initial(natsf_tickets) >= 0.6)
				win_condition = "OVERWHELMING VICTORY!"
				S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
			else if(natsf_tickets / initial(natsf_tickets) <= 0.4)
				win_condition = "PHYRRIC VICTORY"
				S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
			else
				win_condition = "VICTORY"
				S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)

	to_chat(world, "<span class='round_header'>|Round Complete|</span>")
	to_chat(world, "<span class='round_body'>The [winner] is victorious.</span>")
	to_chat(world,"<span class='round_body'>[win_condition]</span>")

	SEND_SOUND(world, S)

	log_game("[round_finished]\nGame mode: [name]\nRound time: [duration2text()]\nEnd round player population: [length(GLOB.clients)]\nTotal humans spawned: [GLOB.round_statistics.total_humans_created]")

	announce_medal_awards()
	announce_round_stats()