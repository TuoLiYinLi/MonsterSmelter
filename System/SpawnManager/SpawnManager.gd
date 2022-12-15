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

# 战斗实体资源字典
var battle_entity_dict:Dictionary = {
	BATTLE_ENTITY_ID.SLIME:load("res://BattleEntity/slime.tscn"),
	
}

# 通用生成战斗实体
func spawn_battle_entity(BE_ID:int,grid_x:int, grid_y:int,WP_ID:int,genes:Array)->BattleEntity:
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
	return spawn_battle_entity(BATTLE_ENTITY_ID.SLIME,grid_x,grid_y,WEAPON_ID.SPIT,[])
	
# ----------------------------------------------------------------
# 武器

# 所有武器ID枚举
enum WEAPON_ID{
	SPIT, # 喷射（粘液球）
	SWORD, # 剑（砍）
	GREAD_SWORD, # 大剑（大横扫）
	JAVELIN, # 标枪
	FLAME_THROWER, #火焰喷射
	BOW, # 弓
}

# 所有武器字典
var weapon_dict:Dictionary = {
	WEAPON_ID.SPIT: load("res://Weapon/spit.tscn"),
	WEAPON_ID.SWORD: load("res://Weapon/sword.tscn"),
	WEAPON_ID.GREAD_SWORD: load("res://Weapon/great_sword.tscn"),
	WEAPON_ID.JAVELIN: load("res://Weapon/throw_javelin.tscn"),
	WEAPON_ID.FLAME_THROWER: load("res://Weapon/flame_thrower.tscn"),
	WEAPON_ID.BOW: load("res://Weapon/bow.tscn")
}

# 通用的生成武器
func spawn_weapon(WP_ID:int)->Weapon:
	return weapon_dict[WP_ID].instance()

# ----------------------------------------------------------------------------
# 基因
enum GENE_ID{
	ACCURATE, #精准
	BLOODTHIRSTY, #流血
	FOLIE, #疯狂
	HARD, #坚硬
	IGNITE, # 点燃
	POISON, #毒液
	STRENGTH, #力量
}

# 所有基因字典
var gene_dict:Dictionary = {
	GENE_ID.ACCURATE: load("res://Gene/accurate.tscn"),
	GENE_ID.BLOODTHIRSTY: load("res://Gene/bloodthirsty.tscn"),
	GENE_ID.FOLIE: load("res://Gene/folie.tscn"),
	GENE_ID.HARD: load("res://Gene/hard.tscn"),
	GENE_ID.IGNITE: load("res://Gene/ignite.tscn"),
	GENE_ID.POISON: load("res://Gene/poison.tscn"),
	GENE_ID.STRENGTH: load("res://Gene/strength.tscn")
}


#生成基因
func spawn_gene(GE_ID:int)->Gene:
	return gene_dict[GE_ID].instance()

#spawn生成基因
func spawn_Gene(be:BattleEntity,GE_ID:int):
	be.get_node("gene_pivot").add_child(spawn_gene(GE_ID))
	print("基因绑定成功")


# ----------------------------------------------------------------------------
# 建筑

# 所有建筑ID枚举

enum BUILDING_ID{
	DIRT_WALL, # 土墙
	
}
# 建筑的资源字典
var building_dict:Dictionary = {
	BUILDING_ID.DIRT_WALL: load("res://Building/dirt_wall.tscn")
}
# 通用的生成建筑
func spawn_building(BD_ID:int,grid_x:int, grid_y:int , version:int = 0)->Building:
	var g = G.grid_manager.get_grid_at(grid_x, grid_y)
	if(g.building or g.battle_entity):
		printerr("[SpawnManager] spawn_building在%s,%s处已阻挡" % [grid_x, grid_y])
		return null
	var obj:Building = building_dict[BD_ID].instance()
	G.building_pivot.add_child(obj)
	obj.grid = g
	g.building = obj
	obj.position = g.position
	obj.version = version
	return obj

# 生成 建筑 墙
func spawn_building_dirt_wall(grid_x:int, grid_y:int , version:int = 0):
	spawn_building(BUILDING_ID.DIRT_WALL, grid_x, grid_y, version)
	

# ---------------------------------------------------------------------------------
# 投射物

# 生成 投射物 小粘液球
var projectile_little_slime_ball:PackedScene = load("res://Projectile/little_slime_ball.tscn")
func spawn_projectile_little_slime_ball(grid_x:int,grid_y:int, direction:int, host:BattleEntity = null):
	var bullet:Projectile = projectile_little_slime_ball.instance()
	G.projectile_pivot.add_child(bullet)
	bullet.position = G.grid_manager.get_grid_at(grid_x,grid_y).position
	bullet.host = host
	bullet.life_time = 1
	match direction:
		G.DIRECTION.UP:
			bullet.velocity.y = -64*3.5
			bullet.rotation_degrees = 270
		G.DIRECTION.DOWN:
			bullet.velocity.y = +64*3.5
			bullet.rotation_degrees = 90
		G.DIRECTION.LEFT:
			bullet.velocity.x = -64*3.5
			bullet.rotation_degrees = 180
		G.DIRECTION.RIGHT:
			bullet.velocity.x = +64*3.5
	

# 生成 攻击 向前砍
var projectile_chop_attack:PackedScene = load("res://Projectile/chop.tscn")
func spawn_projectile_chop_attack(grid_x:int,grid_y:int, direction:int, host:BattleEntity = null):
	var bullet:Projectile = projectile_chop_attack.instance()
	G.projectile_pivot.add_child(bullet)
	bullet.position = G.grid_manager.get_grid_at(grid_x,grid_y).position
	bullet.host = host
	bullet.life_time = 1
	match direction:
		G.DIRECTION.UP:
			bullet.velocity.y = -64*1.5
			bullet.rotation_degrees = 270
		G.DIRECTION.DOWN:
			bullet.velocity.y = +64*1.5
			bullet.rotation_degrees = 90
		G.DIRECTION.LEFT:
			bullet.velocity.x = -64*1.5
			bullet.rotation_degrees = 180
		G.DIRECTION.RIGHT:
			bullet.velocity.x = +64*1.5

# 生成 攻击 大范围像前砍
func spawn_projectile_gread_chop_attack(grid_x:int,grid_y:int, direction:int, host:BattleEntity = null):
	var bullet_a:Projectile = projectile_chop_attack.instance()
	var bullet_b:Projectile = projectile_chop_attack.instance()
	var bullet_c:Projectile = projectile_chop_attack.instance()
	G.projectile_pivot.add_child(bullet_a)
	G.projectile_pivot.add_child(bullet_b)
	G.projectile_pivot.add_child(bullet_c)
	bullet_a.position = G.grid_manager.get_grid_at(grid_x,grid_y).position
	bullet_b.position = G.grid_manager.get_grid_at(grid_x,grid_y).position
	bullet_c.position = G.grid_manager.get_grid_at(grid_x,grid_y).position
	bullet_a.host = host
	bullet_a.life_time = 1
	bullet_b.host = host
	bullet_b.life_time = 1
	bullet_c.host = host
	bullet_c.life_time = 1
	match direction:
		G.DIRECTION.UP:
			bullet_a.velocity.y = -64*1.5
			bullet_a.rotation_degrees = 270
			bullet_b.velocity.y = -64*1.5
			bullet_b.rotation_degrees = 180
			bullet_c.velocity.y = +64*1.5
		G.DIRECTION.DOWN:
			bullet_a.velocity.y = +64*1.5
			bullet_a.rotation_degrees = 90
			bullet_b.velocity.y = -64*1.5
			bullet_b.rotation_degrees = 180
			bullet_c.velocity.y = +64*1.5
		G.DIRECTION.LEFT:
			bullet_a.velocity.x = -64*1.5
			bullet_a.rotation_degrees = 180
			bullet_b.velocity.y = -64*1.5
			bullet_b.rotation_degrees = 270		
			bullet_c.velocity.y = +64*1.5
			bullet_c.rotation_degrees = 90
		G.DIRECTION.RIGHT:
			bullet_a.velocity.x = +64*1.5
			bullet_b.velocity.y = -64*1.5
			bullet_b.rotation_degrees = 270		
			bullet_c.velocity.y = +64*1.5
			bullet_c.rotation_degrees = 90
			
			
			
# 生成 投射物 标枪
var projectile_javelin:PackedScene = load("res://Projectile/javelin.tscn")
func spawn_projectile_javelin(grid_x:int,grid_y:int, direction:int, host:BattleEntity = null):
	var bullet:Projectile = projectile_javelin.instance()
	G.projectile_pivot.add_child(bullet)
	bullet.position = G.grid_manager.get_grid_at(grid_x,grid_y).position
	bullet.host = host
	bullet.life_time = 1
	match direction:
		G.DIRECTION.UP:
			bullet.velocity.y = -64*3.5
			bullet.rotation_degrees = 270
		G.DIRECTION.DOWN:
			bullet.velocity.y = +64*3.5
			bullet.rotation_degrees = 90
		G.DIRECTION.LEFT:
			bullet.velocity.x = -64*3.5
			bullet.rotation_degrees = 180
		G.DIRECTION.RIGHT:
			bullet.velocity.x = +64*3.5
			
			
#生成 投射物 火焰
var projectile_flame:PackedScene = load("res://Projectile/flame.tscn")
func spawn_projectile_flame(grid_x:int,grid_y:int, direction:int, host:BattleEntity = null):
	var bullet:Projectile = projectile_flame.instance()
	G.projectile_pivot.add_child(bullet)
	bullet.position = G.grid_manager.get_grid_at(grid_x,grid_y).position
	bullet.host = host
	bullet.life_time=1
	match direction:
		G.DIRECTION.UP:
			bullet.velocity.y = -64*2.5
			bullet.rotation_degrees = 270
		G.DIRECTION.DOWN:
			bullet.velocity.y = +64*2.5
			bullet.rotation_degrees = 90
		G.DIRECTION.LEFT:
			bullet.velocity.x = -64*2.5
			bullet.rotation_degrees = 180
		G.DIRECTION.RIGHT:
			bullet.velocity.x = +64*2.5
			

var projectile_arrow:PackedScene = load("res://Projectile/arrow.tscn")
#生成 投射物 箭
func spawn_projectile_arrow(grid_x:int,grid_y:int, target_x:int, target_y:int, host:BattleEntity = null):
	var _arrow = projectile_arrow.instance()
	G.projectile_pivot.add_child(_arrow)
	_arrow.initialize(grid_x,grid_y,target_x,target_y,host)
	
# ---------------------------------------------------------------------------------
# 地面
# 地面种类枚举
enum GROUND_ID{
	DIRT,
}
# 地面的资源字典
var ground_dict:Dictionary= {
	GROUND_ID.DIRT: load("res://System/Ground/Ground.tscn"),
	
}
# 通用的生成地面
func spawn_ground(G_ID:int,grid_x:int, grid_y:int , version:int = 0):
	var obj:Ground = ground_dict[G_ID].instance()
	var g = G.grid_manager.get_grid_at(grid_x, grid_y)
	obj.grid = g
	g.ground = obj
	obj.position = g.position
	obj.version = version
	G.ground_pivot.add_child(obj)

# 生成 地面 泥土
func spawn_ground_dirt(grid_x:int, grid_y:int , version:int = 0):
	spawn_ground(GROUND_ID.DIRT, grid_x, grid_y, version)

# ---------------------------------------------------------------------------------
# 特效

var effect_damage_num = load("res://Effect/damage_num.tscn")

func spawn_effect_damage_num(grid_x:int, grid_y:int ,num:int, color:Color = Color.white):
	var e = effect_damage_num.instance()
	G.effect_pivot.add_child(e)
	e.position = G.grid_manager.get_grid_at(grid_x, grid_y).position
	e.text = str(num)
	e.color = color
