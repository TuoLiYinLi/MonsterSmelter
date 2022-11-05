# Building.gd
# 建筑类，描述一个静止不动的建筑

extends Node2D
class_name Building

var grid = null setget set_grid

func set_grid(g):
	grid = g
	position = grid.position

func xxx():
	pass
