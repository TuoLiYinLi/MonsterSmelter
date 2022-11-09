# （预研）
# 投射物
# 代表了一个角色发起的一次攻击，击中后会触发角色的offence函数

extends Node2D
class_name Projectile

# 自己的主人
var host:BattleEntity = null

# 初始速度
var velocity:Vector2 = Vector2.ZERO

# 加速度
var acceleration:Vector2 = Vector2.ZERO

# 速度衰减
var damp:float = 1

#经过时间
var life_time:float = 10

func _physics_process(delta:float):
	# 存在时间
	life_time -= delta
	if life_time <= 0:
		queue_free()
		return
	velocity *= damp
	velocity += acceleration * delta
	position += velocity * delta
	
# 信号接入
# 当击中战斗实体(BattleEntity)或建筑(Building)时会触发
func on_enter_area(area:Area2D):
	# 获取目标的父节点
	var _target = area.get_parent()
	if(!_target):
		# 不是战斗实体
		return
	elif G.is_BattleEntity(_target):
		# 击中了战斗实体
		on_hit_battle_entity(_target)
	elif G.is_Building(_target):
		# 击中了建筑
		on_hit_building(_target)
		_target.on_hit_by(self)

# 当击中战斗实体时触发
func on_hit_battle_entity(_battle_entity):
	pass

# 当击中建筑时触发
func on_hit_building(_building):
	pass

#------------------------------------------------------
static func is_Projectile(obj)->bool:
	return obj.has_method("is_Projectile")
