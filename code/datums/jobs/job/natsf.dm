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
	paygrade = "E1"
	outfit = /datum/outfit/job/natsf/soldier
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_OVERRIDELATEJOINSPAWN


/datum/outfit/job/natsf/soldier
	name = "NATSF Soldier"
	jobtype = /datum/job/natsf/soldier

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/marine
	ears = /obj/item/radio/headset/natsf
	w_uniform = /obj/item/clothing/under/natsf
	shoes = /obj/item/clothing/shoes/marine
	wear_suit = /obj/item/clothing/suit/space/soviet/natsf
	gloves = /obj/item/clothing/gloves/marine/veteran/PMC
	head = /obj/item/clothing/head/helmet/space/soviet/natsf
	suit_store = /obj/item/weapon/gun/rifle/famas
	l_store = /obj/item/storage/pouch/firstaid/coldwar/natsf/full
	back = /obj/item/tank/jetpack/oxygen/combat/natsa
	mask = /obj/item/clothing/mask/rebreather/natsf


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

//NATSF medic

/datum/job/natsf/medic
	title = NATSF_MEDIC
	display_order = JOB_DISPLAY_ORDER_NATSF_MEDIC
	paygrade = "E1"
	outfit = /datum/outfit/job/natsf/medic
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_OVERRIDELATEJOINSPAWN

/datum/outfit/job/natsf/medic
	name = "NATSF Medic"
	jobtype = /datum/job/natsf/medic

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/marine
	ears = /obj/item/radio/headset/natsf
	w_uniform = /obj/item/clothing/under/natsf
	shoes = /obj/item/clothing/shoes/marine
	wear_suit = /obj/item/clothing/suit/space/soviet/natsf/light
	gloves = /obj/item/clothing/gloves/marine/veteran/PMC
	head = /obj/item/clothing/head/helmet/space/soviet/natsf/light
	suit_store = /obj/item/weapon/gun/rifle/groza/ar15c
	l_store = /obj/item/storage/pouch/firstaid/coldmedic/natsf/full
	r_store = /obj/item/storage/pouch/firstaid/coldmedic/natsf/full
	back = /obj/item/tank/jetpack/oxygen/combat/natsa
	mask = /obj/item/clothing/mask/rebreather/natsf


/datum/outfit/job/natsf/medic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/frag/stick, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/frag/stick, SLOT_IN_SUIT)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar15c, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar15c, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar15c, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar15c, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar15c, SLOT_IN_BELT)
