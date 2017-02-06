/datum/artifact_trigger/temperature
	triggertype = "temperature"
	var/heat_triggered = 0

/datum/artifact_trigger/temperature/New()
	..()
	heat_triggered = prob(50)
	spawn(0)
		my_artifact.on_attackby.Add(src, "owner_attackby")

/datum/artifact_trigger/temperature/CheckTrigger()
	var/turf/T = get_turf(my_artifact)
	var/datum/gas_mixture/env = T.return_air()
	if(env)
		if(!my_effect.activated)
			if(!heat_triggered && env.temperature < 225)
				Triggered()
				my_artifact.investigation_log(I_ARTIFACT, "|| effect [my_effect.artifact_id]([my_effect]) triggered by COLDAIR([my_effect.trigger]).")
			else if(heat_triggered && env.temperature > 375)
				Triggered()
				my_artifact.investigation_log(I_ARTIFACT, "|| effect [my_effect.artifact_id]([my_effect]) triggered by HOTAIR([my_effect.trigger]).")
		else
			if(!heat_triggered && env.temperature > 225)
				Triggered()
				my_artifact.investigation_log(I_ARTIFACT, "|| effect [my_effect.artifact_id]([my_effect]) triggered by COLDAIR([my_effect.trigger]).")
			else if(heat_triggered && env.temperature < 375)
				Triggered()
				my_artifact.investigation_log(I_ARTIFACT, "|| effect [my_effect.artifact_id]([my_effect]) triggered by HOTAIR([my_effect.trigger]).")

/datum/artifact_trigger/temperature/proc/owner_attackby(var/list/event_args, var/source)
	var/toucher = event_args[1]
	var/context = event_args[2]
	var/obj/item = event_args[3]

	if(heat_triggered && item.is_hot())
		Triggered()
		my_artifact.investigation_log(I_ARTIFACT, "|| effect [my_effect.artifact_id]([my_effect]) triggered by [context]([my_effect.trigger]) || [item] || attacked by [key_name(toucher)].")

/datum/artifact_trigger/temperature/proc/owner_explode(var/list/event_args, var/source)
	var/context = event_args[2]
	Triggered()
	my_artifact.investigation_log(I_ARTIFACT, "|| effect [my_effect.artifact_id]([my_effect]) triggered by [context]([my_effect.trigger]).")