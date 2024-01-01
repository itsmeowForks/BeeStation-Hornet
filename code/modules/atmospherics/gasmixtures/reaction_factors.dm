/datum/gas_reaction/water_vapor/init_factors()
	factor = list(
		/datum/gas/water_vapor = "Condensation will consume [MOLES_GAS_VISIBLE] moles, freezing will not consume any. Both needs a minimum of [MOLES_GAS_VISIBLE] moles to occur.",
		"Temperature" = "Freezes a turf at [WATER_VAPOR_DEPOSITION_POINT] Kelvins or below, wets it at [WATER_VAPOR_CONDENSATION_POINT] Kelvins or below.",
		"Location" = "Can only happen on turfs.",
	)

/datum/gas_reaction/plasmafire/init_factors()
	factor = list(
		/datum/gas/oxygen = "Oxygen consumption is determined by the temperature, ranging from [OXYGEN_BURN_RATIO_BASE] moles per mole of plasma consumed at [PLASMA_MINIMUM_BURN_TEMPERATURE] Kelvins to [OXYGEN_BURN_RATIO_BASE-1] moles per mole of plasma consumed at [PLASMA_UPPER_TEMPERATURE] Kelvins. Higher oxygen concentration up to [PLASMA_OXYGEN_FULLBURN] times the plasma increases the speed of plasma consumption.",
		/datum/gas/plasma = "Plasma is consumed at a rate that scales with the difference between the temperature and [PLASMA_MINIMUM_BURN_TEMPERATURE]K, with maximum scaling at [PLASMA_UPPER_TEMPERATURE]K.",
		/datum/gas/tritium = "Tritium is formed at 1 mole per mole of plasma consumed if there are at least 97 times more oxygen than plasma.",
		/datum/gas/water_vapor = "Water vapor is formed at 0.25 moles per mole of plasma consumed if tritium isn't being formed.",
		/datum/gas/carbon_dioxide = "Carbon Dioxide is formed at 0.75 moles per mole of plasma consumed if tritium isn't being formed.",
		"Temperature" = "Minimum temperature of [PLASMA_MINIMUM_BURN_TEMPERATURE] kelvin to occur. Higher temperature up to [PLASMA_UPPER_TEMPERATURE]K increases the oxygen efficiency and also the plasma consumption rate.",
		"Energy" = "[FIRE_PLASMA_ENERGY_RELEASED] joules of energy is released per mole of plasma consumed.",
	)

/datum/gas_reaction/tritfire/init_factors()
	factor = list(
		/datum/gas/oxygen = "Oxygen is consumed at 0.5 moles per mole of tritium consumed. Higher oxygen concentration up to [TRITIUM_OXYGEN_FULLBURN] times the tritium increases the tritium consumption rate.",
		/datum/gas/tritium = "Tritium is consumed at rapidly fast as long as there's enough oxygen to allow combustion.",
		/datum/gas/water_vapor = "Water vapor is produced at 1 mole per mole of tritium combusted.",
		"Temperature" = "Minimum temperature of [FIRE_MINIMUM_TEMPERATURE_TO_EXIST] kelvin to occur",
		"Energy" = "[FIRE_TRITIUM_ENERGY_RELEASED] joules of energy is released per mol of tritium consumed.",
		"Radiation" = "This reaction emits radiation proportional to the amount of energy released.",
	)

/datum/gas_reaction/nitrousformation/init_factors()
	factor = list(
		/datum/gas/oxygen = "10 moles of Oxygen needs to be present for the reaction to occur. Oxygen is consumed at 0.5 moles per mole of nitrous oxide formed.",
		/datum/gas/nitrogen = " 20 moles of Nitrogen needs to be present for the reaction to occur. Nitrogen is consumed at 1 mole per mole of nitrous oxife formed.",
		/datum/gas/bz = "5 moles of BZ needs to be present for the reaction to occur. Not consumed.",
		/datum/gas/nitrous_oxide = "Nitrous oxide gets produced rapidly.",
		"Temperature" = "Can only occur between [N2O_FORMATION_MIN_TEMPERATURE] - [N2O_FORMATION_MAX_TEMPERATURE] Kelvin",
		"Energy" = "[N2O_FORMATION_ENERGY] joules of energy is released per mole of nitrous oxide formed.",
	)

/datum/gas_reaction/nitrous_decomp/init_factors()
	factor = list(
		/datum/gas/nitrous_oxide = "Nitrous Oxide is decomposed at a rate that scales negatively with the distance between the temperature and average of the minimum and maximum temperature of the reaction. Minimum of [MINIMUM_MOLE_COUNT * 2] to occur.", //okay this one isn't made into a define yet.
		/datum/gas/oxygen = "Oxygen is formed at 0.5 moles per mole of nitrous oxide decomposed.",
		/datum/gas/nitrogen = "Nitrogen is formed at 1 mole per mole of nitrous oxide decomposed.",
		"Temperature" = "The decomposition rate scales with the product of the distances between temperature and minimum and maximum temperature. Can only happen between [N2O_DECOMPOSITION_MIN_TEMPERATURE] - [N2O_DECOMPOSITION_MAX_TEMPERATURE] kelvin.",
		"Energy" = "[N2O_DECOMPOSITION_ENERGY] joules of energy is released per mole of nitrous oxide decomposed.",
	)

/datum/gas_reaction/bzformation/init_factors()
	factor = list(
		/datum/gas/plasma = "Each mole of BZ made consumes 0.8 moles of plasma. If there is more plasma than nitrous oxide, bz formation rate gets slowed down.",
		/datum/gas/nitrous_oxide = "Each mole of bz made consumes 0.4 moles of Nitrous oxide. If there is less nitrous oxide than plasma the reaction rate is slowed down. At three times the amount of plasma to Nitrous oxide it will start breaking down into Nitrogen and Oxygen, the lower the ratio the more Nitrous oxide decomposes.",
		/datum/gas/bz = "The lower the pressure and larger the volume the more bz gets made. Less nitrous oxide than plasma will slow down the reaction.",
		/datum/gas/nitrogen = "Each mole Nitrous oxide decomposed makes 1 mol Nitrogen. Lower ratio of Nitrous oxide to Plasma means a higher ratio of decomposition to BZ production.",
		/datum/gas/oxygen = "Each mole Nitrous oxide decomposed makes 0.5 moles Oxygen. Lower ratio of Nitrous oxide to Plasma means a higher ratio of decomposition to BZ production.",
		"Energy" = "[BZ_FORMATION_ENERGY] joules of energy is released per mol of BZ made. Nitrous oxide decomposition releases [N2O_DECOMPOSITION_ENERGY] per mol decomposed",
	)

/datum/gas_reaction/pluox_formation/init_factors()
	factor = list(
		/datum/gas/carbon_dioxide = "1 mole of carbon dioxide gets consumed per mole of pluoxium formed.",
		/datum/gas/oxygen = "Oxygen is consumed at 0.5 moles per mole of pluoxium formed.",
		/datum/gas/tritium = "Tritium is converted into hydrogen at 0.01 moles per mole of pluoxium formed.",
		/datum/gas/pluoxium = "Pluoxium is produced at a constant rate in any given mixture.",
		"Energy" = "[PLUOXIUM_FORMATION_ENERGY] joules of energy is released per mole of pluoxium formed.",
		"Temperature" = "Can only occur between [PLUOXIUM_FORMATION_MIN_TEMP] - [PLUOXIUM_FORMATION_MAX_TEMP] Kelvin",
	)

/datum/gas_reaction/nitryl_formation/init_factors()
	factor = list(
		/datum/gas/bz = "5 moles of BZ needs to be present for the reaction to occur. BZ is consumed at 0.05 moles per mole of nitryl formed.",
		/datum/gas/tritium = "20 moles of tritium needs to be present for the reaction to occur. Tritium is consumed at 1 mole per mole of nitroum formed.",
		/datum/gas/nitrogen = "10 moles of nitrogen needs to be present for the reaction to occur. Nitrogen is consumed at 1 mole per mole of nitryl formed.",
		/datum/gas/nitryl = "Nitryl is produced at a rate that scales with the temperature.",
		"Temperature" = "Can only occur above [NITRYL_FORMATION_MIN_TEMP] kelvins",
		"Energy" = "[NITRYL_FORMATION_ENERGY] joules of energy is absorbed per mole of nitryl formed.",
	)

/datum/gas_reaction/nitryl_decomposition/init_factors()
	factor = list(
		/datum/gas/oxygen = "[MINIMUM_MOLE_COUNT] moles of oxygen need to be present for the reaction to occur. Not consumed.",
		/datum/gas/nitryl = "Nitryl is consumed at a rate that scales with the temperature.",
		/datum/gas/nitrogen = "Nitrogen is produced at 1 mole per mole of nitryl decomposed.",
		"Temperature" = "Can only occur below [NITRYL_DECOMPOSITION_MAX_TEMP]. Higher temperature increases the nitryl decomposition rate.",
		"Energy" = "[NITRYL_DECOMPOSITION_ENERGY] joules of energy is released per mole of nitryl decomposed.",
	)

/datum/gas_reaction/nobliumformation/init_factors()
	factor = list(
		/datum/gas/nitrogen = "10 moles of nitrogen needs to be present for the reaction to occur. Nitrogen is consumed at 10 moles per mole of hypernoblium formed.",
		/datum/gas/tritium = "5 moles of tritium needs to be present for the reaction to occur. Tritium is consumed at 5 moles per mole of hypernoblium formed. The relative consumption rate of tritium decreases in the exposure of BZ.",
		/datum/gas/hypernoblium = "Hyper-Noblium production scales based on the sum of the nitrogen and tritium moles.",
		"Energy" = "[NOBLIUM_FORMATION_ENERGY] joules of energy is released per mole of hypernoblium produced.",
		/datum/gas/bz = "BZ is not consumed in the reaction but will lower the amount of energy released. It also reduces amount of tritium consumed by a ratio between tritium and bz, greater bz than tritium will reduce more.",
		"Temperature" = "Can only occur between [NOBLIUM_FORMATION_MIN_TEMP] - [NOBLIUM_FORMATION_MAX_TEMP] kelvin",
	)
