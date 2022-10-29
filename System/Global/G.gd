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

# 网格管理器单例
var grid_manager = null setget , get_grid_manager
func get_grid_manager():
	if(!grid_manager):
		print("[G] GridManager 初始化")
		grid_manager = load("res://System/GridManager/GridManager.tscn").instance()
		add_child(grid_manager)
	return grid_manager

# 预加载的战斗实体场景
var battle_entity:PackedScene = load("res://System/BattleEntity/BattleEntity.tscn")

# 预加载的基因场景
var gene:PackedScene = load("res://System/BattleEntity/Gene.tscn")

# 默认建筑
var building:PackedScene = load("res://System/Building/Building.tscn")

# 默认武器
var weapon:PackedScene = load("res://System/Weapon/Weapon.tscn")


var damage_num = load("res://Effect/damage_num.tscn")

# 点燃基因
var gene_ignite:PackedScene = load("res://gene_ignite.tscn")
# 能量消耗Z
#var gene_ignite2:PackedScene = load("res://Scene/gene_ignite2.tscn")


# ----------------------------------------------------------------------
# 导出寻路网格
func simple_navigate_matrix(_grid)->float:
	if(_grid.battle_entity != null):
		return 0.0
	if(_grid.building != null):
		return 1.0
	return 0.0
