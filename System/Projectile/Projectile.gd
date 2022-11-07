# （预研）
# 投射物
# 代表了一个角色发起的一次攻击，击中后会触发角色的offence函数

extends Node2D
class_name Projectile

# 自己的主人
var host:BattleEntity = null
# 方向
var direction:int

#位置
var velocity:Vector2 

var damp

#经过时间
var life_time:float = 10

# 是否击中后立即销毁
var destory_on_collision:bool = true

# 是否可以穿墙
var through:int

enum DIRECTION{
	UP,
	DOWN,
	LEFT,
	RIGHT
}

# 
func set_host(hs:BattleEntity,direction:int):
	self.host = hs
	self.direction = direction
	#提前设置好Z
	self.through = 0
	self.destory_on_collision = 0
	#设置旋转角度Z
	match self.direction:
		DIRECTION.UP:
			self.rotation_degrees = -90.0
			velocity.y = -32
		DIRECTION.DOWN:
			self.rotation_degrees = 90.0
			velocity.y =32
		DIRECTION.LEFT:
			self.rotation_degrees = 180.0
			velocity.x =-32
		DIRECTION.RIGHT:
			self.rotation_degrees = 0.0
			velocity.x =32

#up 1 down 2 left 3 right 4
func _physics_process(delta):
	if life_time <= 0:
		queue_free()
		return
	life_time -= delta
	
	position += velocity *delta
	
	
# 信号接入
# 当击中战斗实体(BattleEntity)或建筑(Building)时会触发
func on_enter_area(area:Area2D):
	#获取父节点
	var _target = area.get_parent()
#	print(_battle_entity)
	if _target == host:
		print("[Projectile] %s 击中自己" %self)
		return
	#判断能不能穿墙
	elif _target.has_method("is_Building"):
		if through:
			pass
		else:
			queue_free()
			return
	print("[Projectile] %s 击中敌人 %s"%[self,_target])
	host.offence(_target)
	#判断撞击后是否被销毁
	if destory_on_collision:
		queue_free()
	else:
		pass
