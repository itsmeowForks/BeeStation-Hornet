SUBSYSTEM_DEF(overlays)
	name = "Overlay"
	flags = SS_NO_FIRE|SS_NO_INIT
	var/list/stats

	// If the overlay set currently being considered contains a manglable overlay.
	// This is only safe because SSoverlays can only ever consider one overlay list at a time with no interior sleeps. Professional on closed course, do not attempt.
	var/context_needs_automangle

/datum/controller/subsystem/overlays/PreInit()
	stats = list()

/datum/controller/subsystem/overlays/Shutdown()
	rustg_file_append(render_stats(stats), "[GLOB.log_directory]/overlay.log")

/datum/controller/subsystem/overlays/Recover()
	stats = SSoverlays.stats

/// Converts an overlay list into text for debug printing
/// Of note: overlays aren't actually mutable appearances, they're just appearances
/// Don't have access to that type tho, so this is the best you're gonna get
/proc/overlays2text(list/overlays)
	var/list/unique_overlays = list()
	// As anything because we're basically doing type coerrsion, rather then actually filtering for mutable apperances
	for(var/mutable_appearance/overlay as anything in overlays)
		var/key = "[overlay.icon]-[overlay.icon_state]-[overlay.dir]"
		unique_overlays[key] += 1
	var/list/output_text = list()
	for(var/key in unique_overlays)
		output_text += "([key]) = [unique_overlays[key]]"
	return output_text.Join("\n")

/proc/iconstate2appearance(icon, iconstate)
	var/static/image/stringbro = new()
	stringbro.icon = icon
	stringbro.icon_state = iconstate
	return stringbro.appearance

/proc/icon2appearance(icon)
	var/static/image/iconbro = new()
	iconbro.icon = icon
	return iconbro.appearance

// If the overlay has a planeset (e.g., emissive), mark for ZM mangle. This won't catch overlays on overlays, but the flag can just manually be set in that case.
#define ZM_AUTOMANGLE(target) if ((target):plane != FLOAT_PLANE) { SSoverlays.context_needs_automangle = TRUE; }

/atom/proc/build_appearance_list(build_overlays)
	if (!islist(build_overlays))
		build_overlays = list(build_overlays)
	for (var/overlay in build_overlays)
		if(!overlay)
			build_overlays -= overlay
			continue
		if (istext(overlay))
#ifdef UNIT_TESTS
			// This is too expensive to run normally but running it during CI is a good test
			var/list/icon_states_available = icon_states(icon)
			if(!(overlay in icon_states_available))
				var/icon_file = "[icon]" || "Unknown Generated Icon"
				stack_trace("Invalid overlay: Icon object '[icon_file]' [REF(icon)] used in '[src]' [type] is missing icon state [overlay].")
				continue
#endif
			build_overlays -= overlay
			build_overlays += iconstate2appearance(icon, overlay)
		else if(isicon(overlay))
			build_overlays -= overlay
			build_overlays += icon2appearance(overlay)
	return build_overlays

#ifdef ZMIMIC_USE_AUTOMANGLE
// The same as the above, but with ZM_AUTOMANGLE.
/atom/movable/build_appearance_list(build_overlays)
	if (!islist(build_overlays))
		build_overlays = list(build_overlays)
	for (var/overlay in build_overlays)
		if(!overlay)
			build_overlays -= overlay
			continue
		if (istext(overlay))
#ifdef UNIT_TESTS
			// This is too expensive to run normally but running it during CI is a good test
			var/list/icon_states_available = icon_states(icon)
			if(!(overlay in icon_states_available))
				var/icon_file = "[icon]" || "Unknown Generated Icon"
				stack_trace("Invalid overlay: Icon object '[icon_file]' [REF(icon)] used in '[src]' [type] is missing icon state [overlay].")
				continue
#endif
			build_overlays -= overlay
			var/image/new_overlay = iconstate2appearance(icon, overlay)
			build_overlays += new_overlay
			ZM_AUTOMANGLE(new_overlay)
		else if(isicon(overlay))
			build_overlays -= overlay
			var/image/new_overlay = icon2appearance(overlay)
			build_overlays += new_overlay
			ZM_AUTOMANGLE(new_overlay)
	return build_overlays
#endif

/atom/proc/cut_overlays()
	STAT_START_STOPWATCH
	overlays = null
	POST_OVERLAY_CHANGE(src)
	STAT_STOP_STOPWATCH
	STAT_LOG_ENTRY(SSoverlays.stats, type)

#ifdef ZMIMIC_USE_AUTOMANGLE
// same as above but with automangle
/atom/movable/cut_overlays()
	STAT_START_STOPWATCH
	overlays = null
	POST_OVERLAY_CHANGE(src)
	STAT_STOP_STOPWATCH
	STAT_LOG_ENTRY(SSoverlays.stats, type)
	zmm_flags &= ~ZMM_AUTOMANGLE
#endif

/atom/proc/cut_overlay(list/remove_overlays)
	if(!overlays)
		return
	STAT_START_STOPWATCH
	#ifdef ZMIMIC_USE_AUTOMANGLE
	SSoverlays.context_needs_automangle = FALSE
	#endif
	overlays -= build_appearance_list(remove_overlays)
	POST_OVERLAY_CHANGE(src)
	STAT_STOP_STOPWATCH
	STAT_LOG_ENTRY(SSoverlays.stats, type)

#ifdef ZMIMIC_USE_AUTOMANGLE
// Above but add automangle
/atom/movable/cut_overlay(list/overlays)
	..()
	// If we removed an automangle-eligible overlay and have automangle enabled, reevaluate automangling.
	if (!SSoverlays.context_needs_automangle || !(zmm_flags & ZMM_AUTOMANGLE))
		return

	var/list/cached_overlays = src.overlays.Copy()

	// If we cut some overlays but some are still left, we need to scan for AUTOMANGLE.
	if (LAZYLEN(cached_overlays))
		// need to scan overlays
		var/found = FALSE
		for (var/i in 1 to length(cached_overlays))
			var/image/I = cached_overlays[i]
			if (I.plane != FLOAT_PLANE)
				found = TRUE
				break
		if (!found)
			zmm_flags &= ~ZMM_AUTOMANGLE
	// None left, just unset the bit.
	else
		zmm_flags &= ~ZMM_AUTOMANGLE
#endif

/atom/proc/add_overlay(list/add_overlays)
	if(!overlays)
		return
	STAT_START_STOPWATCH
	#ifdef ZMIMIC_USE_AUTOMANGLE
	SSoverlays.context_needs_automangle = FALSE
	#endif
	overlays += build_appearance_list(add_overlays)
	POST_OVERLAY_CHANGE(src)
	STAT_STOP_STOPWATCH
	STAT_LOG_ENTRY(SSoverlays.stats, type)

#ifdef ZMIMIC_USE_AUTOMANGLE
/// Same as above but checks for automangle
/atom/movable/add_overlay(list/add_overlays)
	if(!overlays)
		return
	STAT_START_STOPWATCH
	SSoverlays.context_needs_automangle = FALSE
	overlays += build_appearance_list(add_overlays)
	if (SSoverlays.context_needs_automangle)
		// This is a movable flag.
		src:zmm_flags |= ZMM_AUTOMANGLE
	POST_OVERLAY_CHANGE(src)
	STAT_STOP_STOPWATCH
	STAT_LOG_ENTRY(SSoverlays.stats, type)
#endif

/atom/proc/copy_overlays(atom/other, cut_old)	//copys our_overlays from another atom
	if(!other)
		if(cut_old)
			cut_overlays()
		return

	STAT_START_STOPWATCH
	var/list/cached_other = other.overlays.Copy()
	if(cut_old)
		if(cached_other)
			overlays = cached_other
		else
			overlays = null
		POST_OVERLAY_CHANGE(src)
		STAT_STOP_STOPWATCH
		STAT_LOG_ENTRY(SSoverlays.stats, type)
	else if(cached_other)
		overlays += cached_other
		POST_OVERLAY_CHANGE(src)
		STAT_STOP_STOPWATCH
		STAT_LOG_ENTRY(SSoverlays.stats, type)

#ifdef ZMIMIC_USE_AUTOMANGLE
// Same as above but with automangle
/atom/movable/copy_overlays(atom/other, cut_old)
	if(!other)
		if(cut_old)
			cut_overlays()
		return

	STAT_START_STOPWATCH
	var/list/cached_other = other.overlays.Copy()
	if(cut_old)
		if(cached_other)
			for (var/i in 1 to length(cached_other))
				var/image/I = cached_other[i]
				if (I.plane != FLOAT_PLANE)
					src:zmm_flags |= ZMM_AUTOMANGLE
					break
			overlays = cached_other
		else
			overlays = null
		POST_OVERLAY_CHANGE(src)
		STAT_STOP_STOPWATCH
		STAT_LOG_ENTRY(SSoverlays.stats, type)
	else if(cached_other)
		overlays += cached_other
		POST_OVERLAY_CHANGE(src)
		STAT_STOP_STOPWATCH
		STAT_LOG_ENTRY(SSoverlays.stats, type)
#endif

//TODO: Better solution for these?
/image/proc/add_overlay(x)
	overlays |= x

/image/proc/cut_overlay(x)
	overlays -= x

/image/proc/cut_overlays(x)
	overlays.Cut()

/image/proc/copy_overlays(atom/other, cut_old)
	if(!other)
		if(cut_old)
			cut_overlays()
		return

	var/list/cached_other = other.overlays.Copy()
	if(cached_other)
		if(cut_old || !overlays.len)
			overlays = cached_other
		else
			overlays |= cached_other
	else if(cut_old)
		cut_overlays()
