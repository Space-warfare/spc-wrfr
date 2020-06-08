/obj/item/tank/jetpack
	name = "Jetpack (Empty)"
	desc = "A tank of compressed gas for use as propulsion in zero-gravity areas. Use with caution."
	icon_state = "jetpack"
	w_class = WEIGHT_CLASS_BULKY
	item_state = "jetpack"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	
/obj/item/tank/jetpack/void
	name = "Void Jetpack (Oxygen)"
	desc = "It works well in a void."
	icon_state = "jetpack-void"
	item_state =  "jetpack-void"


/obj/item/tank/jetpack/oxygen
	name = "Jetpack (Oxygen)"
	desc = "A tank of compressed oxygen for use as propulsion in zero-gravity areas. Use with caution."
	icon_state = "jetpack"
	item_state = "jetpack"


/obj/item/tank/jetpack/carbondioxide
	name = "Jetpack (Carbon Dioxide)"
	desc = "A tank of compressed carbon dioxide for use as propulsion in zero-gravity areas. Painted black to indicate that it should not be used as a source for internals."
	distribute_pressure = 0
	icon_state = "jetpack-black"
	item_state =  "jetpack-black"

/obj/item/tank/jetpack/oxygen/combat
	name = "PLSS"
	desc = "A bulky spacesuit backpack with high-powered maneuvering thrusters."
	icon_state = "PLSS"
	item_state =  "PLSS"
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/tank/jetpack/oxygen/combat/Initialize()
	. = ..()
	AddComponent(/datum/component/jetpack_dash)

/obj/item/tank/jetpack/oxygen/combat/attack_self(mob/user)
	if(!isturf(user.loc))
		to_chat(user, "<span class='warning'>You cannot turn the jets on while in [user.loc].</span>")
		return
	if(!ishuman(user))
		return
	if(datum_components)
		datum_components = null
		icon_state = "PLSS"
	else
		AddComponent(/datum/component/jetpack_dash)
		icon_state = "PLSS_a"
	
	playsound(src,'sound/items/flashlight.ogg', 15, 1)
	return TRUE

/obj/item/tank/jetpack/oxygen/combat/item_action_slot_check(mob/user, slot)
	if(!ishuman(user))
		return FALSE
	if(slot != SLOT_BACK)
		return FALSE
	return TRUE //only give action button when armor is worn.
