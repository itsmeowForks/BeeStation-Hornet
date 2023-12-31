// Pressure limits.
#define HAZARD_HIGH_PRESSURE				550		//! This determines at what pressure the ultra-high pressure red icon is displayed. (This one is set as a constant)
#define WARNING_HIGH_PRESSURE				325		//! This determines when the orange pressure icon is displayed (it is 0.7 * HAZARD_HIGH_PRESSURE)
#define WARNING_LOW_PRESSURE				50		//! This is when the gray low pressure icon is displayed. (it is 2.5 * HAZARD_LOW_PRESSURE)
#define HAZARD_LOW_PRESSURE					20		//! This is when the black ultra-low pressure icon is displayed. (This one is set as a constant)

#define TEMPERATURE_DAMAGE_COEFFICIENT		1.5		//! This is used in handle_temperature_damage() for humans, and in reagents that affect body temperature. Temperature damage is multiplied by this amount.

#define BODYTEMP_NORMAL						310.15	//! The natural temperature for a body
#define BODYTEMP_AUTORECOVERY_DIVISOR		11		//! This is the divisor which handles how much of the temperature difference between the current body temperature and 310.15K (optimal temperature) humans auto-regenerate each tick. The higher the number, the slower the recovery. This is applied each tick, so long as the mob is alive.
#define BODYTEMP_AUTORECOVERY_MINIMUM		12		//! Minimum amount of kelvin moved toward 310K per tick. So long as abs(310.15 - bodytemp) is more than 50.
///Similar to the BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is lower than their body temperature. Make it lower to lose bodytemp faster.
#define BODYTEMP_COLD_DIVISOR 15
/// Similar to the BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is higher than their body temperature. Make it lower to gain bodytemp faster.
#define BODYTEMP_HEAT_DIVISOR 15
#define BODYTEMP_COOLING_MAX				-100	//! The maximum number of degrees that your body can cool in 1 tick, due to the environment, when in a cold area.
#define BODYTEMP_HEATING_MAX				30		//! The maximum number of degrees that your body can heat up in 1 tick, due to the environment, when in a hot area.

/// The body temperature limit the human body can take before it starts taking damage from heat.
/// This also affects how fast the body normalises it's temperature when hot.
/// 340k is about 66c, and rather high for a human.
#define BODYTEMP_HEAT_DAMAGE_LIMIT (BODYTEMP_NORMAL + 30)
/// The body temperature limit the human body can take before it starts taking damage from cold.
/// This also affects how fast the body normalises it's temperature when cold.
/// 270k is about -3c, that is below freezing and would hurt over time.
#define BODYTEMP_COLD_DAMAGE_LIMIT (BODYTEMP_NORMAL - 40)


#define SPACE_HELM_MIN_TEMP_PROTECT			2.0		//! what min_cold_protection_temperature is set to for space-helmet quality headwear. MUST NOT BE 0.
#define SPACE_HELM_MAX_TEMP_PROTECT			1500	//! Thermal insulation works both ways /Malkevin
#define SPACE_SUIT_MIN_TEMP_PROTECT			2.0		//! what min_cold_protection_temperature is set to for space-suit quality jumpsuits or suits. MUST NOT BE 0.
#define SPACE_SUIT_MAX_TEMP_PROTECT			1500

#define FIRE_SUIT_MIN_TEMP_PROTECT			60		//! Cold protection for firesuits
#define FIRE_SUIT_MAX_TEMP_PROTECT			30000	//! what max_heat_protection_temperature is set to for firesuit quality suits. MUST NOT BE 0.
#define FIRE_HELM_MIN_TEMP_PROTECT			60		//! Cold protection for fire helmets
#define FIRE_HELM_MAX_TEMP_PROTECT			30000	//! for fire helmet quality items (red and white hardhats)

#define FIRE_IMMUNITY_MAX_TEMP_PROTECT	35000		//! what max_heat_protection_temperature is set to for firesuit quality suits and helmets. MUST NOT BE 0.

//Emergency skinsuits
#define EMERGENCY_HELM_MIN_TEMP_PROTECT		2.0		//The helmet is pressurized with air from the oxygen tank. If they don't take damage from that they won't take damage here
#define EMERGENCY_SUIT_MIN_TEMP_PROTECT		237		//This is the approximate average temperature of Mt. Everest in the winter

#define HELMET_MIN_TEMP_PROTECT				160		//For normal helmets
#define HELMET_MAX_TEMP_PROTECT				600		//For normal helmets
#define ARMOR_MIN_TEMP_PROTECT				160		//For armor
#define ARMOR_MAX_TEMP_PROTECT				600		//For armor

#define GLOVES_MIN_TEMP_PROTECT				2.0		//For some gloves (black and)
#define GLOVES_MAX_TEMP_PROTECT				1500	//For some gloves
#define SHOES_MIN_TEMP_PROTECT				2.0		//For gloves
#define SHOES_MAX_TEMP_PROTECT				1500	//For gloves

#define PRESSURE_DAMAGE_COEFFICIENT			4		//! The amount of pressure damage someone takes is equal to (pressure / HAZARD_HIGH_PRESSURE)*PRESSURE_DAMAGE_COEFFICIENT, with the maximum of MAX_PRESSURE_DAMAGE
#define MAX_HIGH_PRESSURE_DAMAGE			4
#define LOW_PRESSURE_DAMAGE					4		//! The amount of damage someone takes when in a low pressure area (The pressure threshold is so low that it doesn't make sense to do any calculations, so it just applies this flat value).

#define COLD_SLOWDOWN_FACTOR				20		//! Humans are slowed by the difference between bodytemp and BODYTEMP_COLD_DAMAGE_LIMIT divided by this
