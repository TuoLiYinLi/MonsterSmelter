# Building.gd
# 建筑类，描述一个静止不动的建筑

extends Node2D
class_name Building

# 所在的网格
var grid = null setget set_grid

func set_grid(g):
	grid = g
	position = grid.position

# 类似版本号
var version:int = 0 setget set_version
func set_version(value:int):
	$Sprite.frame = value

# 当被子弹击中时
func on_hit_by(_projectile):
	pass

#------------------------------------------------------
static func is_Building(obj)->bool:
	return obj.has_method("is_Building")
