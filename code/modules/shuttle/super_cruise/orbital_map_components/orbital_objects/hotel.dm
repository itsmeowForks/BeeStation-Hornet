/datum/orbital_object/z_linked/hotel
	name = "Space Hotel"
	mass = 0
	can_dock_anywhere = TRUE
	render_mode = RENDER_MODE_BEACON
	// Larger than a typical beacon
	radius = 50

/datum/orbital_object/z_linked/hotel/post_map_setup()
	//Orbit around the systems sun
	var/datum/orbital_map/linked_map = SSorbits.orbital_maps[orbital_map_index]
	set_orbitting_around_body(linked_map.center, 1000 + 250 * rand(1, 5))
