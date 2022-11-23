# test_3.gd
# 网格管理器测试

extends Node2D

func _ready():
	var gm = G.grid_manager
	
	gm.init_grids(10,10)
	
	for i in range(3,9):
		G.spawn_manager.spawn_building_dirt_wall(3,i,randi()%3)

	for i in [[0,0,0,8],[0,0,9,0],[9,1,9,9],[0,9,8,9]]:
		for grid in gm.get_grids_range(i[0],i[1],i[2],i[3]):
			G.spawn_manager.spawn_building_dirt_wall(grid.index_x,grid.index_y,randi()%3)
			
			
	for i in range(5,7):
		G.spawn_manager.spawn_building_dirt_wall(i,4,randi()%3)
	
	for i in range(4,8):
		G.spawn_manager.spawn_building_dirt_wall(7,i,randi()%3)
	
	
	var m1 = G.spawn_manager.spawn_battle_entity_slime(2,5)
	var m2 = G.spawn_manager.spawn_battle_entity_slime(7,2)
	var m3 = G.spawn_manager.spawn_battle_entity_slime(8,8)
	
	m1.attack_target = m2
	m2.attack_target = m1
	m3.attack_target = m2
	
	for i in range(10):
		for j in range(10):
			G.spawn_manager.spawn_ground_dirt(i,j,randi()%8)
	
	
	#G.spawn_manager.spawn_projectile_little_slime_ball(1,1,G.DIRECTION.DOWN)
	G.spawn_manager.spawn_projectile_chop_attack(1,1,G.DIRECTION.DOWN)
