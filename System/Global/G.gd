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
# 寻路 Z
var path_finder:PathFinder
# 生成管理器
var spawn_manager:SpawnManager

# 所有的战斗实体放在这里
var battle_entity_pivot:Node2D
# 所有的投射物节点放在这里
var projectile_pivot:Node2D
# 所有的building对象节点都放在这个节点下
var building_pivot:Node2D
# 所有的ground对象节点都放在这个节点下
var ground_pivot:Node2D
# effect放在这里
var effect_pivot:Node2D



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
	
	print("[G] 加载 battle_entity_pivot")
	battle_entity_pivot = Node2D.new()
	battle_entity_pivot.name='battle_entity_pivot'
	add_child(battle_entity_pivot)
	
	print("[G] 加载  projectile_pivot")
	projectile_pivot = Node2D.new()
	projectile_pivot.name='projectile_pivot'
	add_child(projectile_pivot)
	
	print("[G] 加载  effect_pivot")
	effect_pivot = Node2D.new()
	effect_pivot.name='effect_pivot'
	add_child(effect_pivot)
	
	
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
		
		
# 类型检测
static func is_BattleEntity(obj)->bool:
	return BattleEntity.is_BattleEntity(obj)

static func is_Projectile(obj)->bool:
	return Projectile.is_Projectile(obj)

static func is_Building(obj)->bool:
	return Building.is_Building(obj)
	
static func is_Ground(obj)->bool:
	return Ground.is_Ground(obj)

static func is_Gene(obj)->bool:
	return Gene.is_Gene(obj)
