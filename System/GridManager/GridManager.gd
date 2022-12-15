# Grid 网格管理器类
# 设计目的：可以从这里直接查询和调用所有的网格，方便管理
# 使用：实例化res://Scene/GridManager.tscn场景，所有的网格以二维列表的形式挂在此节点下

extends Node2D
class_name GridManager

# 预加载网格
var grid_scene:PackedScene = load("res://System/GridManager/Grid.tscn")

var width:int = 0
var height:int = 0

# 初始化所有的子网格
func init_grids(_width:int, _height:int):
	# 检测并清除已有的那些网格
	if(get_child_count()>0):
		print("[GridManager] 重置网格")
		for i in get_children():
			remove_child(i)
	# 创建新的网格，形成二维数组形式
	print("[GridManager] 初始化网格 宽：%s 高:%s" % [_width, _height])
	for x in range(_width):
		var n = Node2D.new()
		add_child(n)
		for y in range(_height):
			var g = grid_scene.instance()
			n.add_child(g)
			g.index_x = x
			g.index_y = y
	
	width = _width
	height = _height

# 获取某一位置的网格，index_x为横坐标，index_y为y坐标，返回值为Grid实例或null
# x坐标向右为正，y向下为正方向
func get_grid_at(index_x:int, index_y:int)->Grid:
	if(index_x>=0 and index_x < get_child_count()):
		var n = get_child(index_x)
		if(index_y>=0 and index_y < n.get_child_count()):
			return n.get_child(index_y)
	printerr("[GridManager] 尝试获取(%s,%s)的网格不存在"% [index_x, index_y])
	return null

# 类似get_grid_at获取特定位置上的角色
func get_battle_entity_at(index_x:int, index_y:int)->BattleEntity:
	var g = get_grid_at(index_x, index_y)
	if(g):
		return g.battle_entity
	return null

# 类似get_grid_at获取特定位置上的地面
func get_ground_at(index_x:int, index_y:int):
	var g = get_grid_at(index_x, index_y)
	if(g):
		return g.ground
	return null


# 类似get_grid_at获取特定位置上的建筑
func get_building_at(index_x:int, index_y:int):
	var g = get_grid_at(index_x, index_y)
	if(g):
		return g.building
	return null
	
# 寻找特定范围内的所有网格
func get_grids_range(x1:int, y1:int, x2:int, y2:int)->Array:
	var out: = []
	for x in range(x1, x2 + 1):
		for y in range(y1, y2 + 1):
			var g = get_grid_at(x, y)
			if(g):
				out.append(g)
			else:
				continue
	return out

#查看特定格子中是否有建筑
func find_building(index_x:int, index_y:int):
	var g = get_grid_at(index_x, index_y)
	if(g.building!=null):
		return true
	else:
		return false


# 导出寻路矩阵，配置一个实例上的方法作为处理网格的函数
func to_navigate_matrix(instance:Object, method_name:String)->Array:
	# 获得函数的回调
	var export_method:FuncRef = funcref(instance, method_name)
	
	# 检测导出函数是否可用
	if(export_method == null or !export_method.is_valid()):
		printerr("[GridManager] 调用的函数不可用 %s" % export_method)
		return []
	
	# 开始导出
	var out:Array = []
	for column in get_children():
		var row:Array = []
		out.append(row)
		for grid in column.get_children(): 
			var res = export_method.call_func(grid)
			row.append(res)
			
	return out


# 计算两个网格之间的距离
func distance(grid1:Grid, grid2:Grid)->int:
	return int(abs(grid1.index_x - grid2.index_x) + abs(grid1.index_y - grid2.index_y))
	
# 检测grid_target是否在grid_center的直线方向上、它在哪个方向以及距离
func check_in_cross(grid_center:Grid, grid_target:Grid)->Array:
	# 是否在十字方向上
	var in_cross:bool = false
	# 方向
	var direction:int
	# 距离
	var d:int
	if(grid_center.index_x == grid_target.index_x):
		d = abs(grid_center.index_y - grid_target.index_y)
		in_cross = true
		if(grid_target.index_y < grid_center.index_y):
			direction = G.DIRECTION.UP
		else:
			direction = G.DIRECTION.DOWN
	elif(grid_center.index_y == grid_target.index_y):
		in_cross =true
		d = abs(grid_center.index_x - grid_target.index_x)
		if(grid_target.index_x < grid_center.index_x):
			direction = G.DIRECTION.LEFT
		else:
			direction = G.DIRECTION.RIGHT
	return [in_cross, direction, d]


# 检测grid_target是否在grid_center的直线方向上、它在哪个方向以及距离
func check_in_crosss(grid_center:Grid, grid_target:BattleEntity,distance:int)->Array:
	
	for i in range(1,distance+1):
		var spot = [grid_center.index_x+i, grid_center.index_y]
		if(spot[0]>=width  or find_building(spot[0],spot[1])):
			break
		elif(get_battle_entity_at(spot[0],spot[1]) == grid_target):
			return [true, G.DIRECTION.RIGHT, i]
			
	for i in range(-1,(distance*-1)-1,-1):
		var spot = [grid_center.index_x+i, grid_center.index_y]
		if(spot[0]<0 or find_building(spot[0],spot[1])):
			break
		elif(get_battle_entity_at(spot[0],spot[1]) == grid_target):
			return [true, G.DIRECTION.LEFT, i*-1]
			
	for i in range(1,distance+1):
		var spot = [grid_center.index_x, grid_center.index_y+i]
		if(spot[1]>=height or find_building(spot[0],spot[1])):
			break
		elif(get_battle_entity_at(spot[0],spot[1]) == grid_target):
			return [true, G.DIRECTION.DOWN, i]
			
	for i in range(-1,(distance*-1)-1,-1):
		var spot = [grid_center.index_x, grid_center.index_y+i]
		if(spot[1]>=height or find_building(spot[0],spot[1])):
			break
			
		elif(get_battle_entity_at(spot[0],spot[1]) == grid_target):
			
			return [true, G.DIRECTION.UP, i*-1]
	return [false, 0, 0]


#输出目标周边可行点
func check_in_spot(grid_center:Grid, distance:int)->Array:
	var out = []
	for i in range(1,distance):
		var spot = [grid_center.index_x+i, grid_center.index_y]
		if(spot[0]>=width  or find_building(spot[0],spot[1])):
			break
		else:
			out.append(spot)
	for i in range(-1,(distance*-1),-1):
		var spot = [grid_center.index_x+i, grid_center.index_y]
		if(spot[0]<0 or find_building(spot[0],spot[1])):
			break
		else:
			out.append(spot)
	for i in range(1,distance):
		var spot = [grid_center.index_x, grid_center.index_y+i]
		if(spot[1]>=height or find_building(spot[0],spot[1])):
			break
		else:
			out.append(spot)
	for i in range(-1,(distance*-1),-1):
		var spot = [grid_center.index_x, grid_center.index_y+i]
		if(spot[1]>=height or find_building(spot[0],spot[1])):
			break
		else:
			out.append(spot)
	return out

func check_in_rhombus(grid_center:Grid, distance:int):
	var center = [grid_center.index_x,grid_center.index_y]
	pass
