# （预研）
# 生成管理器
# 管理一切需要生成的对象

extends Node2D
class_name SpawnManager

# ------------------------------------------------------------
# 战斗实体

# 战斗实体ID枚举
enum BATTLE_ENTITY_ID{
	SLIME, # 史莱姆
	SKELETON, # 骷髅
	MINER, # 矿工
	GEM_FIGHTER, # 宝石战士 
}

# 战斗实体字典
var battle_entity_dict:Dictionary = {
	BATTLE_ENTITY_ID.SLIME:load("res://BattleEntity/slime.tscn"),
}

func spawn_battle_entity(grid_x:int, grid_y:int,BE_ID:int,WP_ID:int,genes:Array)->BattleEntity:
	var g = G.grid_manager.get_grid_at(grid_x,grid_y)
	if(g.building or g.battle_entity):
		printerr("[SpawnManager] spawn_battle_entity在%s,%s处已阻挡" % [grid_x, grid_y])
		return null
	var be:BattleEntity = battle_entity_dict[BE_ID].instance()
	be.teleport_to(g)
	be.get_node("weapon_pivot").add_child(spawn_weapon(WP_ID))
	for i in genes:
		if !G.is_Gene(i):
			printerr("[SpawnManager] spawn_battle_entity中%s不属于Gene" % i)
			return null
		add_child(i)
	G.battle_entity_pivot.add_child(be)
	return be

# 生成 战斗实体 史莱姆
func spawn_battle_entity_slime(grid_x:int, grid_y:int)->BattleEntity:
	return spawn_battle_entity(grid_x,grid_y,BATTLE_ENTITY_ID.SLIME,WEAPON_ID.SPIT,[])
	
# ----------------------------------------------------------------
# 武器

# 所有武器ID枚举
enum WEAPON_ID{
	SPIT, # 喷射（粘液球）
	
}

# 所有武器字典
var weapon_dict:Dictionary = {
	WEAPON_ID.SPIT: load("res://Weapon/spit.tscn"),
	
}

func spawn_weapon(WP_ID:int)->Weapon:
	return weapon_dict[WP_ID].instance()

# ----------------------------------------------------------------------------
# 建筑

var building_dirt_wall:PackedScene = load("res://Building/dirt_wall.tscn")

# 生成 建筑 墙
func spawn_building_dirt_wall(grid_x:int, grid_y:int , version:int = 0):
	var g = G.grid_manager.get_grid_at(grid_x, grid_y)
	if(g.building or g.battle_entity):
		printerr("[SpawnManager] spawn_building_dirt_wall在%s,%s处已阻挡" % [grid_x, grid_y])
		return
	var obj:Node2D = building_dirt_wall.instance()
	G.building_pivot.add_child(obj)
	obj.grid = g
	g.building = obj
	obj.position = g.position
	obj.version = version


# ---------------------------------------------------------------------------------
# 投射物

var projectile_little_slime_ball:PackedScene = load("res://Projectile/little_slime_ball.tscn")

# 生成 投射物 小粘液球
func spawn_projectile_little_slime_ball(grid_x:int,grid_y:int, direction:int, host:BattleEntity = null):
	var bullet:Projectile = projectile_little_slime_ball.instance()
	G.projectile_pivot.add_child(bullet)
	bullet.position = G.grid_manager.get_grid_at(grid_x,grid_y).position
	bullet.host = host
	match direction:
		G.DIRECTION.UP:
			bullet.velocity.y = -320
			bullet.rotation_degrees = 270
		G.DIRECTION.DOWN:
			bullet.velocity.y = +320
			bullet.rotation_degrees = 90
		G.DIRECTION.LEFT:
			bullet.velocity.x = -320
			bullet.rotation_degrees = 180
		G.DIRECTION.RIGHT:
			bullet.velocity.x = +320
	

# ---------------------------------------------------------------------------------
# 地面

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

# ---------------------------------------------------------------------------------
# 特效

var effect_damage_num = load("res://Effect/damage_num.tscn")

func spawn_effect_damage_num(grid_x:int, grid_y:int ,num:int, color:Color = Color.white):
	var e = effect_damage_num.instance()
	G.effect_pivot.add_child(e)
	e.position = G.grid_manager.get_grid_at(grid_x, grid_y).position
	e.text = str(num)
	e.color = color
