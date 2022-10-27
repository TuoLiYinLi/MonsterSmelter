# Grid 网格类
# 设计目的：提出网格的概念，用于记录和查询某一格网格处的角色、地面、建筑等等
# 使用：实例化res://Scene/Gene.tscn场景，作为一个Grid

extends Node2D
class_name Grid

# 自己在地图中的索引X
var index_x:int = 0 setget set_index_x
func set_index_x(value:int):
	index_x = value
	position.x = index_x * 64

# 自己在地图中的索引Y
var index_y:int = 0 setget set_index_y
func set_index_y(value:int):
	index_y = value
	position.y = index_y * 64

# 记录的角色
var battle_entity = null
# 记录的地面
var ground = null
# 记录的建筑
var building = null

