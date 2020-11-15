/datum/job/ussr
	access = ALL_ANTAGONIST_ACCESS
	minimal_access = ALL_ANTAGONIST_ACCESS
	skills_type = /datum/skills/crafty
	faction = FACTION_USSR
	job_category = FACTION_USSR

//USSR Soldier
/datum/job/ussr/soldier
	title = USSR_SOLDIER
	display_order = JOB_DISPLAY_ORDER_USSR_SOLDIER
	paygrade = "E1"
	outfit = /datum/outfit/job/ussr/soldier
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_OVERRIDELATEJOINSPAWN


/datum/outfit/job/ussr/soldier
	name = "USSR Soldier"
	jobtype = /datum/job/ussr/soldier

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/marine
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/marine/veteran/freelancer
	shoes = /obj/item/clothing/shoes/marine
	wear_suit = /obj/item/clothing/suit/space/soviet
	gloves = /obj/item/clothing/gloves/marine/veteran/PMC/soviet
	head = /obj/item/clothing/head/helmet/space/soviet
	suit_store = /obj/item/weapon/gun/rifle/famas/ak40vm
	l_store = /obj/item/storage/pouch/firstaid/coldwar
	back = /obj/item/tank/jetpack/oxygen/combat
	mask = /obj/item/clothing/mask/gas/soviet


/datum/outfit/job/ussr/soldier/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/frag/stick, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/frag/stick, SLOT_IN_SUIT)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ak40vm, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ak40vm, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ak40vm, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ak40vm, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ak40vm, SLOT_IN_BELT)

//	H.equip_to_slot_or_del(new /obj/item/weapon/combat_knife, SLOT_