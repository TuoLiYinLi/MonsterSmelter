# BattleEntity.gd 战斗实体基本类型
class_name BattleEntity
extends Node2D


func _ready():
	$TextEdit.text = self.description

# 此实体的信息文字说明
var description:String = "default_battle_entity_info"

# 最大生命值
var health_max:float = 100 setget set_health_max, get_health_max

func get_health_max()->float:
	var out:float = health_max
	for i in $gene_pivot.get_children():
		out += i.health_max
	return out

func set_health_max(f:float)->void:
	health_max = f
	if(self.health_max < health_current):
		health_current = self.health_max

# 当前生命值
var health_current:float = 100 setget set_health_current

func set_health_current(f):
	if(f<self.health_max):
		health_current = f
	else:
		health_current = self.health_max

# 生命恢复
var health_recovery:float = 1 setget set_health_recovery, get_health_recovery

func get_health_recovery()->float:
	var out:float = health_recovery
	for i in $gene_pivot.get_children():
		out += i.health_recovery
	return out

func set_health_recovery(f:float)->void:
	health_recovery = f

# 攻击速度
var attack_speed:float = 1 setget set_attack_speed, get_attack_speed

func get_attack_speed()->float:
	var out:float = attack_speed
	for i in $gene_pivot.get_children():
		out += i.attack_speed
	return out

func set_attack_speed(f:float)->void:
	attack_speed = f

# 攻击冷却
var attack_cd:float = 0

# 攻击力
var attack:float = 5 setget set_attack, get_attack

func get_attack()->float:
	var out:float = attack
	for i in $gene_pivot.get_children():
		out += i.attack
	return out

func set_attack(f:float)->void:
	attack = f

# 穿甲率
var piercing_rate:float = 0 setget set_piercing_rate, get_piercing_rate

func get_piercing_rate()->float:
	var out:float = piercing_rate
	for i in $gene_pivot.get_children():
		out += i.piercing_rate
	return out

func set_piercing_rate(f:float)->void:
	piercing_rate = f

# 护甲
var armor:float = 2 setget set_armor, get_armor

func get_armor()->float:
	var out:float = armor
	for i in $gene_pivot.get_children():
		out += i.armor
	return out

func set_armor(f:float)->void:
	armor = f
# 护甲率
var armor_rate:float = 0.2 setget set_armor_rate, get_armor_rate

func get_armor_rate()->float:
	var out:float = armor_rate
	for i in $gene_pivot.get_children():
		out += i.armor_rate
	return out

func set_armor_rate(f:float)->void:
	armor_rate = f
	
#暴击率Z
var crit_rate:float = 0.3 setget set_crit_rate,get_crit_rate

func get_crit_rate()->float:
	var out:float = crit_rate
	for i in $gene_pivot.get_children():
		out+=i.crit_rate
	return out
	
func set_crit_rate(f:float)->void:
	crit_rate = f
	
#暴击倍数Z
var crit_multiple:float = 2 setget set_crit_multiple,get_crit_multiple

func get_crit_multiple()->float:
	var out:float = crit_multiple
	for i in $gene_pivot.get_children():
		out+=i.crit_multiple
	return out
	
func set_crit_multiple(f:float)->void:
	crit_multiple=f


#最大能量（Z）
var energy_max:float = 100 setget set_energy_max,get_energy_max

func get_energy_max()->float:
	var out:float = energy_max
	for i in $gene_pivot.get_children():
		out+=i.energy_max
	return out

func set_energy_max(f:float)->void:
	energy_max = f
	if(self.energy_max < energy_current):
		energy_current = self.energy_max
	
#当前能量值（Z）
var energy_current:float = 100 setget set_energy_current

func set_energy_current(f):
	if(f<self.energy_max):
		energy_current = f
	else:
		energy_current = self.energy_max
		
#能量恢复（Z）
var energy_recover:float = 10 setget set_energy_recover,get_energy_recover

func get_energy_recover()->float:
	var out:float = energy_recover
	for i in $gene_pivot.get_children():
		out+=i.energy_recover
	return out
	
func set_energy_recover(f:float)->void:
	energy_recover=f

#反伤率（Z）
var rebound_rate:float = 0.2 setget set_rebound_rate,get_rebound_rate

func get_rebound_rate()->float:
	var out:float = rebound_rate
	for i in $gene_pivot.get_children():
		out+=i.rebound_rate
	return out

func set_rebound_rate(f:float)->void:
	rebound_rate = f

#反伤比例（Z）
var rebound_proportion:float = 0.4 setget set_rebound_proportion,get_rebound_proportion

func get_rebound_proportion()->float:
	var out:float = rebound_proportion
	for i in $gene_pivot.get_children():
		out+=i.rebound_proportion
	return out
	
func set_rebound_proportion(f:float)->void:
	rebound_proportion = f

# 燃烧时间
var burning_cd:float = 0

func _physics_process(delta:float):
	
	# 燃烧效果
	if(burning_cd > 0):
		health_current -= G.BURNING_RATE * self.health_max * delta
		burning_cd -= delta
		on_burning(delta)
	
	# 检测死亡&恢复生命值
	if(health_current <= 0):
		on_dead()
		print("%s生命值归零死亡了" % description)
		queue_free()
	else:
		self.health_current += self.health_recovery * delta
		#能量恢复（Z）
		self.energy_current += self.energy_recover * delta
	
	# 武器产生作用
	if(self.weapon):
		self.weapon.behavior()
	
	# 攻击冷却
	if(attack_cd > 0):
		attack_cd -= self.attack_speed * delta
	
	# 移动角色
	var delta_posi:Vector2 = (next_position- last_position) * delta * G.MOVING_SPEED
	if(delta_posi):
		is_moving = true
		if((position - next_position).length_squared() <= delta_posi.length_squared()):
			position = next_position
			last_position = next_position
		else:
			position += delta_posi
		
		if(target_grid != grid and (position - next_position).length_squared()<(position - last_position).length_squared()):
			on_leave_grid()
			on_enter_grid(target_grid)
	else:
		is_moving = false
		
	# 移动CD
	if(moving_cd > 0):
		moving_cd -= delta

# 发动进攻
func offence(be:BattleEntity):
	attack_cd += 1
	
	print("%s 发起攻击 %s" % [self.description, be.description])
	
	# 实际的护甲率
	var real_armor_rate:float
	# 是否护甲格挡成功
	var is_blocked:int
	
	if(be.armor<=0 or be.armor_rate<=0):
		real_armor_rate = 0
		is_blocked = 0
	else:
		real_armor_rate = max(be.armor_rate - self.piercing_rate, 0)
		if(randf() - real_armor_rate < 0):
			is_blocked = 1
		else:
			is_blocked = 0
	
	#是否暴击成功(初始默认暴击倍数为1)Z
	var crit=1
	if(randf()<=self.crit_rate):
		crit=self.crit_multiple
		print("%s 对 %s 造成暴击" % [self.description, be.description])
		
	# 造成的真实伤害
	var damage:float = max(self.attack*crit - is_blocked * be.armor, 0)
	be.health_current -= damage
	
	var n = G.damage_num.instance()
	get_node("/root/G").add_child(n)
	n.position = be.global_position
	n.text = damage
	
	# 触发
	on_attack(be)
	be.on_hit_by(self)
	
#	print("%s的实际护甲率是%s"%[be.description,real_armor_rate])
	
	if(is_blocked == 0):
		print("%s的护甲被穿透了，受到%s伤害，剩下生命值%s" % [be.description, damage, be.health_current])
	else:
		print("%s的护甲挡住了%s伤害，受到%s伤害，剩下生命值%s" % [be.description, be.armor, damage, be.health_current])
		
		
	#是否触发反伤Z
	var rebound_damage = 0
	if(randf() <= be.rebound_rate):
		rebound_damage = damage*be.rebound_proportion
		self.health_current -= rebound_damage
		print("%s的攻击触发了%s的反伤，造成了%s伤害，%s剩余%s生命" % [self.description, be.description, rebound_damage, self.description, self.health_current])
	
	print("---------------------------------------------------------------------------")

# 当正在燃烧时，每帧触发 delta是间隔时间
func on_burning(delta:float):
	for g in $gene_pivot.get_children():
		g.on_burning(delta)

# 当死亡时，单帧触发
func on_dead():
	for g in $gene_pivot.get_children():
		g.on_dead()
	
# 当击中敌人时 enemy是击中的敌人
func on_attack(enemy:BattleEntity):
	for g in $gene_pivot.get_children():
		g.on_attack(enemy)

# 被敌人击中时 enemy是击中自己的敌人
func on_hit_by(enemy:BattleEntity):
	for g in $gene_pivot.get_children():
		g.on_hit_by(enemy)


# ---------------------------------------------------------------------------
# 运动系统

# 自己所在位置处的网格
var grid = null
# 目标的网格
var target_grid = null

# 朝向移动的位置（一定在网格上）
var next_position:Vector2 = Vector2.ZERO 

var last_position:Vector2 = Vector2.ZERO


var is_moving:bool = false

# 角色移动速度
var moving_speed:float = 1 setget set_moving_speed,get_moving_speed

func get_moving_speed()->float:
	var out:float = moving_speed
	for i in $gene_pivot.get_children():
		out += i.moving_speed
	return out

func set_moving_speed(f:float)->void:
	moving_speed = f

# 移动的冷却
var moving_cd:float = 0

# 开始向目标网格移动
func move_to(_target_grid):
	if(is_moving or moving_cd>0):
		print("%s的移动能力还在冷却" % [self.description])
		return
	else:
		moving_cd += 1
		target_grid = _target_grid
		next_position = _target_grid.position

# 直接将当前战斗实体传送到目标位置
func teleport_to(_target_grid):
	if(grid):
		on_leave_grid()
	on_enter_grid(_target_grid)
	print("传送到网格 位置%s"%_target_grid.position)
	position = _target_grid.position
	last_position = position
	next_position = position
	
# 当离开一个网格时触发
func on_leave_grid():
	if(grid):
		print("离开网格 %s" % grid.position)
		grid.battle_entity = null
		grid = null
	else:
		printerr("离开网格时，网格不存在")

# 当进入一个网格时触发
func on_enter_grid(_grid):
	if(_grid):
		_grid.battle_entity = self
		grid = _grid
		print("进入新的网格 %s" % grid.position)
	else:
		printerr("进入网格时，网格不存在")


#---------------------------------------------------------------------------
# 武器系统

# 已经锁定的攻击目标
var attack_target:BattleEntity = null

# 获取我的武器
var weapon = null setget ,get_weapon
func get_weapon():
	if($weapon_pivot.get_child_count() == 0):
		return null
	else:
		return $weapon_pivot.get_child(0)


#测试用：判断是否有多目标 测试多目标寻路用 Z
#--------------------------------
var test=1
var target_position_list:Array
#--------------------------------
