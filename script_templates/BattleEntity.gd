# script_name.gd

extends BattleEntity

func _ready():
	health_max = 100
	health_current = 100
	health_recovery = 0
	attack = 5
	attack_speed = 1
	piercing_rate = 0
	armor = 0
	armor_rate = 0
	crit_multiple = 2
	crit_rate = 0.1
	energy_max = 10
	energy_current = 10
	energy_recover = 0.5
	rebound_proportion = 0
	rebound_rate = 0
	moving_speed = 1
	
	description = "template_battle_entity"

