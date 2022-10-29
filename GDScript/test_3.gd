# test_3.gd
# 网格管理器测试

extends Node2D

func _ready():
	var gm:GridManager = G.grid_manager.instance()
	
	add_child(gm)
	
	gm.init_grids(10,10)
	
	for grid in gm.get_grids_range(3,3,3,7):
		var b = G.building.instance()
		add_child(b)
		grid.building = b
		b.grid = grid
	
	for grid in gm.get_grids_range(7,4,7,7):
		var b = G.building.instance()
		add_child(b)
		grid.building = b
		b.grid = grid
	
	var slime = G.battle_entity.instance()
	add_child(slime)
	
	slime.teleport_to(gm.get_grid_at(5,1))
	
	print(gm.to_navigate_matrix(G,"simple_navigate_matrix"))
	
	slime.move_to(gm.get_grid_at(5,2))
	
	yield(get_tree().create_timer(2),"timeout")
	slime.move_to(gm.get_grid_at(5,3))
	
	
	yield(get_tree().create_timer(2),"timeout")
	slime.move_to(gm.get_grid_at(6,3))
	
	
	print(gm.to_navigate_matrix(G,"simple_navigate_matrix"))
	
	yield(get_tree().create_timer(2),"timeout")
	slime.move_to(gm.get_grid_at(6,4))
	
	
	print(gm.to_navigate_matrix(G,"simple_navigate_matrix"))
	
	slime.teleport_to(gm.get_grid_at(5,1))
	
	print(gm.to_navigate_matrix(G,"simple_navigate_matrix"))
	
	slime.move_to(gm.get_grid_at(5,2))
	
	yield(get_tree().create_timer(2),"timeout")
	slime.move_to(gm.get_grid_at(5,3))
	
	
	yield(get_tree().create_timer(2),"timeout")
	slime.move_to(gm.get_grid_at(6,3))
	
	
	print(gm.to_navigate_matrix(G,"simple_navigate_matrix"))
	
	yield(get_tree().create_timer(2),"timeout")
	slime.move_to(gm.get_grid_at(9,9))
