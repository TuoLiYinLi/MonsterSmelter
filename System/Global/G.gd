# G.gd 全局脚本
# 全局符号 G
extends Node2D

# 全局燃烧系数
const BURNING_RATE:float = 0.01

# 移动耗时系数
const MOVING_SPEED:float = 5.0

# 移动的不同方向
enum DIRECTION{
	UP = 0,
	DOWN = 1,
	LEFT = 2,
	RIGHT = 3,
}

# 网格管理器单例
var grid_manager:GridManager

#寻路 Z
var path_finder:PathFinder

var spawn_manager:SpawnManager

var battle_entity_pivot:Node2D

var projectile_pivot:Node2D

# 所有的building对象节点都放在这个节点下
var building_pivot:Node2D

# 所有的ground对象节点都放在这个节点下
var ground_pivot:Node2D

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

#发射子弹
var projectile:PackedScene = load("res://System/Projectile/Projectile.tscn")


func _ready():
	print("[G] 准备初始化")
	print("[G] 加载 ground_pivot")
	ground_pivot = Node2D.new()
	ground_pivot.name="ground_pivot"
	add_child(ground_pivot)
	
	print("[G] 加载 building_pivot")
	building_pivot = Node2D.new()
	building_pivot.name="building_pivot"
	add_child(building_pivot)
	
	print("[G] 加载 grid_manager")
	grid_manager = load("res://System/GridManager/GridManager.tscn").instance()
	add_child(grid_manager)
	
	print("[G] 加载 path_finder")
	path_finder = load("res://System/PathFinder/PathFinder.tscn").instance()
	add_child(path_finder)
	
	print("[G] 加载 spawn_manager")
	spawn_manager = load("res://System/SpawnManager/SpawnManager.tscn").instance()
	add_child(spawn_manager)
	
	print("[G] 初始化完成")


# ----------------------------------------------------------------------
# 导出寻路网格
func simple_navigate_matrix(_grid)->float:
	if(_grid.battle_entity != null):
		return 2.0
	if(_grid.building != null):
		return 1.0
	return 0.0

# 导出权重寻路网格 z
func simple_navigate_weight_matrix(_grid)->float:
	if(_grid.battle_entity != null):
		return 500.0
	if(_grid.building != null):
		return 99999.0
	return 1.0
		
		
		 
