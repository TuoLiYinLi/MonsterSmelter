# bow.gd
extends Weapon

# 武器开始发挥作用
func behavior():
	# 如果当前角色有攻击目标
	if(get_target() and is_instance_valid(get_target())):
		# 在攻击范围内则进行攻击
		var res:Array = G.grid_manager.check_in_cross(get_host().grid,get_target().grid)
		if(res[0] and res[2] <= 3):
			if(get_host().attack_cd <= 0):
				print("[Weapon] 发射箭")
				var target_grid = get_target().grid
				G.spawn_manager.spawn_projectile_arrow(get_host().grid.index_x,get_host().grid.index_y,target_grid.index_x,target_grid.index_y,get_host())
				get_host().attack_cd = get_host().attack_speed
			
		# 在范围外则进行寻路靠近目标
		else:
			#使用权值地图计算 Z
			if(get_host().moving_cd <= 0):
				var mt = G.grid_manager.to_navigate_matrix(G,"simple_navigate_weight_matrix")
				var spot = G.grid_manager.check_in_rhombus(get_target().grid,3)
				var ns = G.path_finder.next_step_multi_A(mt,get_host().grid.index_x, get_host().grid.index_y, spot)
				
				if(ns):
					get_host().move_to(G.grid_manager.get_grid_at(ns[0], ns[1]))
					print("[Weapon] 角色导航中 %s %s"%[ns[0],ns[1]])
				else:
					print("[Weapon] 无目标点")

