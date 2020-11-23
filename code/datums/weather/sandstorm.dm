/datum/weather/sandstorm
	name = "sandstorm"
	desc = "The terraforming of mars has made the famous sandstorms much more dangerous."

	telegraph_duration = 40 SECONDS
	telegraph_message = "<span class='highdanger'>The storm is coming. Seek shelter!<span>"
	telegraph_overlay = "dust_low"

	weather_message = "<span class='highdanger'><i>The wind bellows around you as shrapnels of sand cuts through the landscape.</i></span>"
	weather_overlay = "dust_high"
	weather_duration_lower = 1 MINUTES
	weather_duration_upper = 3 MINUTES

	target_trait = ZTRAIT_MARS
	end_duration = 10 SECONDS
	end_message = "<span class='boldannounce'>The wind is dying down. It should be safe outside now.</span>"
	end_overlay = "dust_med"

	var/datum/looping_sound/active_outside_ashstorm/sound_ao = new(list(), FALSE, TRUE)
	var/datum/looping_sound/active_inside_ashstorm/sound_ai = new(list(), FALSE, TRUE)
	var/datum/looping_sound/weak_outside_ashstorm/sound_wo = new(list(), FALSE, TRUE)
	var/datum/looping_sound/weak_inside_ashstorm/sound_wi = new(list(), FALSE, TRUE)

/datum/weather/sandstorm/weather_act(mob/living/L)
	L.adjustBruteLoss(10)