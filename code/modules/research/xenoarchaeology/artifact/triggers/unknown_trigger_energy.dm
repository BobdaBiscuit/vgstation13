/datum/artifact_trigger/energy
	triggertype = "energy"

/datum/artifact_trigger/energy/New()
	..()
	spawn(0)
		my_artifact.on_attackby.Add(src, "owner_attackby")
		my_artifact.on_projectile.Add(src, "owner_projectile")

/datum/artifact_trigger/energy/proc/owner_attackby(var/list/event_args, var/source)
	var/toucher = event_args[1]
	var/context = event_args[2]
	var/obj/item/weapon/item = event_args[3]

	if(istype(item,/obj/item/weapon/melee/baton) && item:status ||\
			istype(item,/obj/item/weapon/melee/energy) ||\
			istype(item,/obj/item/weapon/melee/cultblade) ||\
			istype(item,/obj/item/weapon/card/emag) ||\
			istype(item,/obj/item/device/multitool))
		Triggered()
		my_artifact.investigation_log(I_ARTIFACT, "|| effect [my_effect.artifact_id]([my_effect]) triggered by [context]([my_effect.trigger]) || [item] || attacked by [key_name(toucher)].")

/datum/artifact_trigger/energy/proc/owner_projectile(var/list/event_args, var/source)
	var/toucher = event_args[1]
	var/context = event_args[2]
	var/item = event_args[3]

	if(istype(item,/obj/item/projectile/beam) ||\
		istype(item,/obj/item/projectile/ion) ||\
		istype(item,/obj/item/projectile/energy))
		Triggered()
		my_artifact.investigation_log(I_ARTIFACT, "|| effect [my_effect.artifact_id]([my_effect]) triggered by [context]([my_effect.trigger]) || [item] || attacked by [key_name(toucher)].")