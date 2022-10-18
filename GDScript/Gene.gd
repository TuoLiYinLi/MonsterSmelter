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
func on_burning(delta:float):
	pass

# 当死亡时，单帧触发
func on_dead():
	pass

# 当击中敌人时 enemy是击中的敌人
func on_attack(enemy):
	print("击中敌人时恢复1生命值触发了")
	get_parent().get_parent().health_current += 1

func on_hit_by(enemy):
	pass


# --------------------------------------------------------------------
# 角色移动系统

var moving_speed:float = 0
