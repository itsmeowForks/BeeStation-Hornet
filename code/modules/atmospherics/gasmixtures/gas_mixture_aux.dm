// Implements various procs from auxmos-era into listmos.
// These are *objectively slower* than listmos, inline these if you're doing something that needs to be performant!

/// DO NOT USE IN NEW CODE!
/datum/gas_mixture/proc/set_volume(vol)
	volume = vol

/// DO NOT USE IN NEW CODE!
/datum/gas_mixture/proc/adjust_moles(gastype, moles)
	ASSERT_GAS(gastype, src)
	gases[gastype][MOLES] += moles

/// DO NOT USE IN NEW CODE!
/datum/gas_mixture/proc/set_moles(gastype, moles)
	ASSERT_GAS(gastype, src)
	gases[gastype][MOLES] = moles

/// DO NOT USE IN NEW CODE!
/datum/gas_mixture/proc/get_moles(gastype)
	ASSERT_GAS(gastype, src)
	return gases[gastype][MOLES]

/// DO NOT USE IN NEW CODE!
/datum/gas_mixture/proc/set_temperature(temperature)
	src.temperature = temperature

/// DO NOT USE IN NEW CODE!
/datum/gas_mixture/proc/transfer_to(datum/gas_mixture/other, moles)
	other.merge(remove(moles))

/// DO NOT USE IN NEW CODE!
/datum/gas_mixture/proc/adjust_heat(joules)
	var/cap = heat_capacity()
	temperature = ((cap * temperature) + joules) / cap

/datum/gas_mixture/proc/thermal_energy() //joules
	return THERMAL_ENERGY(src) //see code/__DEFINES/atmospherics.dm; use the define in performance critical areas


/datum/gas_mixture/proc/scrub_into()
	return // TODO ATMOS

/datum/gas_mixture/proc/transfer_ratio_to()
	return // TODO ATMOS

/datum/gas_mixture/proc/remove_specific_ratio()
	return // TODO ATMOS

/datum/gas_mixture/proc/gas_pressure_calculate()
	return // TODO ATMOS

/datum/gas_mixture/proc/remove_specific()
	return // TODO ATMOS

/proc/equalize_all_gases_in_list()
	return // TODO ATMOS

/datum/gas_mixture/proc/multiply()
	return // TODO ATMOS

/datum/gas_mixture/proc/clear()
	return // TODO ATMOS
