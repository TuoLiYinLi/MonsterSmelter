# arrow.gd

extends Projectile

const HEIGHT:int = 256
const FLY_TIME:float = 1.2
const RANDOM_RANGE:float = 20.0
# 飞行目标网格
var target_grid

var my_time:float = FLY_TIME

func _ready():
	# 持续时间
#	life_time = FLY_TIME
	# 初速度
#	velocity = Vector2.ZERO
	# 加速度
	# 速度衰减
#	damp = 1
	pass

func _physics_process(delta):
	if(my_time > 0):
		my_time -= delta
	else:
		if(target_grid and target_grid.battle_entity and is_instance_valid(target_grid.battle_entity) and is_instance_valid(host)):
			host.offence(target_grid.battle_entity)
		queue_free()
		
#	._physics_process(delta)

# 当击中战斗实体时触发
func on_hit_battle_entity(_battle_entity):
	pass

# 当击中建筑时触发
func on_hit_building(_building):
	pass

func initialize(grid_x:int,grid_y:int, target_x:int, target_y:int, _host:BattleEntity = null):
	host = _host
	
	position = G.grid_manager.get_grid_at(grid_x,grid_y).position
	target_grid = G.grid_manager.get_grid_at(target_x,target_y)
	
	var _distance:Vector2 = target_grid.position - position + Vector2(rand_range(-RANDOM_RANGE,RANDOM_RANGE),rand_range(-RANDOM_RANGE,RANDOM_RANGE))
	
	acceleration = Vector2(0 , 2*HEIGHT/(FLY_TIME*FLY_TIME))
	
	var v1:Vector2 = _distance / FLY_TIME
	var v2:Vector2 = -0.5 * FLY_TIME * acceleration
	
	velocity = v1 + v2
	
	$AnimatedSprite.rotation = atan2(velocity.y,velocity.x)

func _process(delta):
	$AnimatedSprite.rotation = atan2(velocity.y,velocity.x)
