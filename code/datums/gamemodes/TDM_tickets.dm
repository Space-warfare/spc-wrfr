/datum/game_mode/team_death_match
	name = "Team Death Match"
	config_tag = "TDM"
	required_players = 0 //change to 2 in the future
	votable = TRUE

	var/a_team_tickets = 100
	var/b_team_tickets = 100

	valid_job_types = list(
		/datum/job/terragov/command/captain = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/terragov/command/staffofficer = 4,
		/datum/job/terragov/command/pilot = 2,
		/datum/job/terragov/police/chief = 1,
		/datum/job/terragov/police/officer = 5,
		/datum/job/terragov/engineering/chief = 1,
		/datum/job/terragov/engineering/tech = 1,
		/datum/job/terragov/requisitions/officer = 1,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/medical/medicalofficer = 6,
		/datum/job/terragov/medical/researcher = 2,
		/datum/job/terragov/civilian/liaison = 1,
		/datum/job/terragov/silicon/synthetic = 1,
		/datum/job/terragov/silicon/ai = 1,
		/datum/job/terragov/squad/engineer = 8,
		/datum/job/terragov/squad/corpsman = 8,
		/datum/job/terragov/squad/smartgunner = 4,
		/datum/job/terragov/squad/specialist = 4,
		/datum/job/terragov/squad/leader = 4,
		/datum/job/terragov/squad/standard = -1
	)

//yeah yeah move this to a defines file at some point in the future.
#define A_TEAM_VICTORY "a_team_victory"
#define B_TEAM_VICTORY "b_team_victory"

//for when scaling of the round start tickets is important
///datum/game_mode/team_death_match/proc/scale_tickets()
//	a_team_tickets = 50 * CONFIG_GET(number/ticket_scale)
//	b_team_tickets = 50 * CONFIG_GET(number/ticket_scale)

/datum/game_mode/team_death_match/announce()
	to_chat(world, "<b>The current game mode is - Team Death Match!</b>")
	to_chat(world, "<b>Just have fun and kill your fellow man!</b>")

/datum/game_mode/team_death_match/check_finished()
	if(a_team_tickets <= 0)
		round_finished = B_TEAM_VICTORY
		return TRUE
	if(b_team_tickets <= 0)
		round_finished = A_TEAM_VICTORY
		return TRUE
	return FALSE

/datum/game_mode/team_death_match/declare_completion()
	. = ..()
	to_chat(world, "<span class='round_header'>|Round Complete|</span>")
	to_chat(world, "<span class='round_body'>Thus ends the story of the brave men and women of the [SSmapping.configs[SHIP_MAP].map_name] and their struggle on [SSmapping.configs[GROUND_MAP].map_name].</span>")
	var/sound/S = null
	//the sounds here should be a victory track based on whomever won.
	switch(round_finished)
		if(A_TEAM_VICTORY)
			S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
		if(B_TEAM_VICTORY)
			S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)

	SEND_SOUND(world, S)

	log_game("[round_finished]\nGame mode: [name]\nRound time: [duration2text()]\nEnd round player population: [length(GLOB.clients)]\nTotal humans spawned: [GLOB.round_statistics.total_humans_created]")

	announce_medal_awards()
	announce_round_stats()
