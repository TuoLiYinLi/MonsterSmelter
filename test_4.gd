# test_4.gd
# 寻路测试 Z

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
	
	var sm=G.spawn_manager
	
	var m1 = G.spawn_manager.spawn_battle_entity(0,1,1,sm.WEAPON_ID.BOW,[])
	var m2 = G.spawn_manager.spawn_battle_entity(0,8,8,sm.WEAPON_ID.BOW,[])
	var m3 = G.spawn_manager.spawn_battle_entity(0,8,5,sm.WEAPON_ID.BOW,[])
#
	m1.attack_target = m2
	m2.attack_target = m1
	m3.attack_target = m2

	
	for i in range(10):
		for j in range(10):
			G.spawn_manager.spawn_ground_dirt(i,j,randi()%8)
	
	
#	#目标点列表
#	var target_position_list = [[2,6],[3,8],[8,8]]
#	var mt = G.grid_manager.to_navigate_matrix(G,"simple_navigate_matrix")
#	var ma = G.grid_manager.to_navigate_matrix(G,"simple_navigate_weight_matrix")
#
#	#进入列表寻路
#	print("普通地图计算最短路径的点为",G.path_finder.next_step_multi(mt,5,8,target_position_list))
#	print("权重地图计算最短路径的点为",G.path_finder.next_step_multi_A(ma,5,8,target_position_list))
#
#	var ss = G.grid_manager.to_navigate_matrix(G,"simple_navigate_weight_matrix")
	
	#print(G.path_finder.next_step_A(ss,1,1,8,8))
	
	
	
