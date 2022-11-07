# （预研）
# 投射物
# 代表了一个角色发起的一次攻击，击中后会触发角色的offence函数

extends Node2D
class_name Projectile

# 自己的主人
var host:BattleEntity = null
# 速度
var speed:float = 10*64
# 方向
var direction:int

#位置
var velocity:Vector2 

var damp

#经过时间
var life_time:float

# 是否击中后立即销毁
var collision_destory:int

# 是否可以穿墙
var through:int

# 
func set_host(hs:BattleEntity,direction:int):
	self.host = hs
	self.direction = direction
	#提前设置好Z
	self.through = 0
	self.collision_destory = 0
	self.life_time = 2
	#设置旋转角度Z
	match self.direction:
		1:
			self.rotation_degrees = -90.0
		2:
			self.rotation_degrees = 90.0
		3:
			self.rotation_degrees = 180.0
		4:
			self.rotation_degrees = 0.0

#up 1 down 2 left 3 right 4
func _physics_process(delta):
	if life_time == 0 :
		queue_free()
		return
	life_time -= delta
	velocity = Vector2.ZERO
	match self.direction:
		1:
			velocity.y-=32
		2:
			velocity.y+=32
		3:
			velocity.x-=32
		4:
			velocity.x+=32
	if velocity.length()>0:
		velocity = velocity.normalized()*speed
		position += velocity *delta
	



# 信号接入
# 当击中战斗实体(BattleEntity)或建筑(Building)时会触发
func on_enter_area(area:Area2D):
	#获取父节点
	var _battle_entity = area.get_parent()
#	print(_battle_entity)
	if _battle_entity == host:
		print("[Projectile] %s 击中自己" %self)
		return
	#判断能不能穿墙
	elif _battle_entity.has_method("xxx"):
		if through:
			pass
		else:
			queue_free()
			return
	print("[Projectile] %s 击中敌人 %s"%[self,_battle_entity])
	host.offence(_battle_entity)
	#判断撞击后是否被销毁
	if collision_destory:
		pass
	else:
		queue_free()


