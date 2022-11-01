# test_4.gd
# 寻路测试 Z

extends Node2D

func _ready():
	var gm = G.grid_manager
	
	gm.init_grids(10,10)
	
	for grid in gm.get_grids_range(3,3,3,8):
		var b = G.building.instance()
		add_child(b)
		grid.building = b
		b.grid = grid

	for i in [[0,0,0,8],[0,0,9,0],[9,1,9,9],[0,9,8,9]]:
		for grid in gm.get_grids_range(i[0],i[1],i[2],i[3]):
			var b = G.building.instance()
			add_child(b)
			grid.building = b
			b.grid = grid
			
	for grid in gm.get_grids_range(5,4,6,4):
			var b = G.building.instance()
			add_child(b)
			grid.building = b
			b.grid = grid
	
	for grid in gm.get_grids_range(7,4,7,7):
		var b = G.building.instance()
		add_child(b)
		grid.building = b
		b.grid = grid
	
	var m1 = G.battle_entity.instance()
	add_child(m1)
	m1.teleport_to(gm.get_grid_at(5,8))
	m1.description = "p1"
	
	var w1 = G.weapon.instance()
	m1.get_node("weapon_pivot").add_child(w1)
	
	#目标点列表
	var target_position_list = [[2,6],[3,8],[8,8]]
	var mt = G.grid_manager.to_navigate_matrix(G,"simple_navigate_matrix")
	var ma = G.grid_manager.to_navigate_matrix(G,"simple_navigate_weight_matrix")
		
	#进入列表寻路
	print("普通地图计算最短路径的点为",G.path_finder.next_step_multi(mt,5,8,target_position_list))
	print("权重地图计算最短路径的点为",G.path_finder.next_step_multi_A(ma,5,8,target_position_list))
	
	var ss = G.grid_manager.to_navigate_matrix(G,"simple_navigate_weight_matrix")
	
	#print(G.path_finder.next_step_A(ss,1,1,8,8))
