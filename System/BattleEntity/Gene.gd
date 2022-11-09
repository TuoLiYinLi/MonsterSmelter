# Gene.gd 基因类
# 所有基因的基类

extends Node2D
class_name Gene

# 最大生命值
var health_max:float = 10

#暴击率
var crit_rate:float = 0.1

#暴击倍数
var crit_multiple:float = 0

# 生命恢复
var health_recovery:float = 0.1

# 攻击力
var attack:float = 0

# 攻速
var attack_speed:float = 0

# 穿甲率
var piercing_rate:float = 0

# 护甲
var armor:float = 0

# 护甲率
var armor_rate:float = 0

#最大能量
var energy_max:float = 0

#能量恢复
var energy_recover:float = 0

#反伤率
var rebound_rate:float = 0

#反伤比例
var rebound_proportion:float =0

# 标签集合
var tags:Array = []

# 基因信息文字说明
var description:String = "default_gene_info"

# 当正在燃烧时，每帧触发 delta是间隔时间
func on_burning(_delta:float):
	pass

# 当正在中毒时，每帧触发 delta是间隔时间
func on_poisoning(_delta:float):
	pass

# 当死亡时，单帧触发
func on_dead():
	pass

# 当击中敌人时 enemy是击中的敌人
func on_attack(_enemy):
	pass

# 被敌人击中时 enemy是击中自己的敌人
func on_attacked_by(_enemy):
	pass


# --------------------------------------------------------------------
# 角色移动系统

var moving_speed:float = 0

# --------------------------------------------------------------------
static func is_Gene(obj)->bool:
	return obj.has_method("is_Gene")
