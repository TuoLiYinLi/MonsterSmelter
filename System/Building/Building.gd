# Building.gd
# 建筑类，描述一个静止不动的建筑

extends Node2D
class_name Building

var grid = null setget set_grid

func set_grid(g):
	grid = g
	position = grid.position

#检测函数Z
func is_Building():
	pass

# 类似版本号
var version:int = 0 setget set_version
func set_version(value:int):
	$Sprite.frame = value
