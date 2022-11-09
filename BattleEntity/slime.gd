# slime.gd

extends BattleEntity

func _ready():
	health_max = 20
	health_current = 20
	health_recovery = 0.5
	attack = 3
	attack_speed = 1
	piercing_rate = 0
	armor = 0
	armor_rate = 0
	crit_multiple = 1.5
	crit_rate = 0.05
	energy_max = 1
	energy_current = 1
	energy_recover = 0.1
	rebound_proportion = 0
	rebound_rate = 0
	moving_speed = 0.8
	
	description = "slime"

