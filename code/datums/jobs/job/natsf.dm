/datum/job/natsf
	access = ALL_ANTAGONIST_ACCESS
	minimal_access = ALL_ANTAGONIST_ACCESS
	skills_type = /datum/skills/crafty
	faction = FACTION_NATSF
	job_category = FACTION_NATSF

//NATSF Soldier
/datum/job/natsf/soldier
	title = NATSF_SOLDIER
	display_order = JOB_DISPLAY_ORDER_NATSF_SOLDIER
	paygrade = "FRE1"
	outfit = /datum/outfit/job/natsf/soldier
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_OVERRIDELATEJOINSPAWN


/datum/outfit/job/natsf/soldier
	name = "NATSF Soldier"
	jobtype = /datum/job/natsf/soldier

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/marine
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/marine/veteran/freelancer
	shoes = /obj/item/clothing/shoes/marine
	wear_suit = /obj/item/clothing/suit/space/soviet/natsf
	gloves = /obj/item/clothing/gloves/marine/veteran/PMC
	head = /obj/item/clothing/head/helmet/space/soviet/natsf
	suit_store = /obj/item/weapon/gun/rifle/famas
	l_store = /obj/item/storage/pouch/firstaid/full
	back = /obj/item/tank/jetpack/oxygen/combat/natsa


/datum/outfit/job/natsf/soldier/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/frag/stick, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/frag/stick, SLOT_IN_SUIT)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/famas, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/famas, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/famas, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/famas, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/famas, SLOT_IN_BELT)

//	H.equip_to_slot_or_del(new /obj/item/weapon/combat_knife, SLOT_