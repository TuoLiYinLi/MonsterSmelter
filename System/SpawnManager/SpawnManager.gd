# （预研）
# 生成管理器
# 管理一切需要生成的对象

extends Node2D
class_name SpawnManager




# 根据你的选项生成一个物体
func spawn(option:Dictionary):
	pass

# 生成 战斗实体 史莱姆
func spawn_battle_entity_slime(grid_x:int, grid_y:int, genes:Array):
	var m1 = G.battle_entity.instance()
	G.battle_entity_pivot.add_child(m1)
	m1.teleport_to( G.grid_manager.get_grid_at(grid_x,grid_y))
	var w1 = G.weapon.instance()
	m1.get_node("weapon_pivot").add_child(w1)
	
	print('[SpawnManager] 生成',m1)
	
var building_dirt_wall:PackedScene = load("res://System/Building/Building.tscn")

# 生成 建筑 墙
func spawn_building_dirt_wall(grid_x:int, grid_y:int , version:int = 0):
	var obj:Node2D = building_dirt_wall.instance()
	var g = G.grid_manager.get_grid_at(grid_x, grid_y)
	obj.grid = g
	g.building = obj
	obj.position = g.position
	obj.version = version
	G.building_pivot.add_child(obj)

# 生成 投射物 小粘液球
func spawn_projectile_little_slime_ball(grid_x:int,grid_y:int,direction:int,host:BattleEntity = null):
	var bullet = G.projectile.instance()
	bullet.set_host(host,direction)
	G.projectile_pivot.add_child(bullet)
	bullet.position = G.grid_manager.get_grid_at(grid_x,grid_y).position
	

var ground_dirt:PackedScene = load("res://System/Ground/Ground.tscn")

# 生成 地面 泥土
func spawn_ground_dirt(grid_x:int, grid_y:int , version:int = 0):
	var obj:Node2D = ground_dirt.instance()
	var g = G.grid_manager.get_grid_at(grid_x, grid_y)
	obj.grid = g
	g.ground = obj
	obj.position = g.position
	obj.version = version
	G.ground_pivot.add_child(obj)
	
