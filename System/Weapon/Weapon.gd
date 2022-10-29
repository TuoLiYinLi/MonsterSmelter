# 武器
# 决定角色行为和战斗方式的武器

extends Node2D
class_name Weapon

# 获取自己的主人
func get_host():
	if(!get_parent()):
		printerr("[Weapon] 没有找到父级对象")
		return null	
	return get_parent().get_parent()

# 获取目标敌人
func get_target():
	var host = get_host()
	if(host and host.attack_target and is_instance_valid(host.attack_target)):
		return host.attack_target
	return null

# 武器开始发挥作用（不同武器的工作效果不一样）
func behavior():
	# 如果当前角色有攻击目标
	if(get_target()):
		# 在攻击范围内则进行攻击
		if(G.grid_manager.distance(get_host().grid, get_target().grid) == 1):
			if(get_host().attack_cd<=0):
				print("[Weapon] 进入攻击范围，发动战斗")
				get_host().offence(get_target())
		# 在范围外则进行寻路靠近目标
		else:
			if(get_host().moving_cd <= 0):
				var mt = G.grid_manager.to_navigate_matrix(G,"simple_navigate_matrix")
				var ns = PathFinder.next_step(mt, get_host().grid.index_x, get_host().grid.index_y, get_target().grid.index_x, get_target().grid.index_y)
				if(ns):
					get_host().move_to(G.grid_manager.get_grid_at(ns[0], ns[1]))
				print("[Weapon] 角色导航中")
#			else:
#				print("[Weapon] 角色移动冷却")
				
				
	# 如果当前角色有移动目标，则开始寻路
		
		
		
	# 否则闲置
	
	pass
	
