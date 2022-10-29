# G.gd 全局脚本
# 全局符号 G
extends Node2D

# 全局燃烧系数
const BURNING_RATE:float = 0.01

# 移动耗时系数
const MOVING_SPEED:float = 10.0

# 移动的不同方向
enum DIRECTION{
	UP = 0,
	DOWN = 1,
	LEFT = 2,
	RIGHT = 3,
}

# 预加载的战斗实体场景
var battle_entity:PackedScene = load("res://System/BattleEntity/BattleEntity.tscn")
# 预加载的基因场景
var gene:PackedScene = load("res://System/BattleEntity/Gene.tscn")

# 预加载网格
var grid:PackedScene = load("res://System/GridManager/Grid.tscn")
# 预加载的网格管理器
var grid_manager:PackedScene = load("res://System/GridManager/GridManager.tscn")

var building:PackedScene = load("res://System/Building/Building.tscn")

# 点燃基因
var gene_ignite:PackedScene = load("res://gene_ignite.tscn")
# 能量消耗Z
#var gene_ignite2:PackedScene = load("res://Scene/gene_ignite2.tscn")

# ----------------------------------------------------------------------
# 导出寻路网格
func simple_navigate_matrix(_grid)->float:
	if(_grid.battle_entity != null):
		return 2.0
	if(_grid.building != null):
		return 1.0
	return 0.0
