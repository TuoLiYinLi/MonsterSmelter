# little_slime_ball.gd

extends Projectile

func _ready():
	# 持续时间
#	life_time = 10
	# 初速度
#	velocity = Vector2.ZERO
	# 加速度
#	acceleration = Vector2.ZERO
	# 速度衰减
#	damp = 1
	pass

# 当击中战斗实体时触发
func on_hit_battle_entity(_battle_entity):
	if(host and _battle_entity != host):
		host.offence(_battle_entity)
#		get_parent().remove_child(self)
		flag_valid = false
		life_time = 0
		queue_free()

# 当击中建筑时触发
func on_hit_building(_building):
	queue_free()
