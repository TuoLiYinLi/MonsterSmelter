extends Node2D
class_name PathFinder


#全局变量
const xx = [0, 1, 0, -1] # 右移、下移、左移、上移
const yy = [1, 0, -1, 0]
#动态规划寻路算法（BFS宽度优先搜索）Z
#--------------------------------------------------------

func bfs(map, x:int,y:int,m:int,n:int)->Array:
	var pre_route = [] # 宽度搜索得到的节点
	var q = []  # 队列结构控制循环次数
	var visited = []  # 记录节点是否已遍历
	var father = []  # 每一个pre_route节点的父节点
#	var x:int = start_position.x/64
#	var y:int = start_position.y/64
#	var m:int = dinal_position.x/64
#	var n:int = dinal_position.y/64
	for i in range(len(map[0])):
		visited.push_back([])
		for j in range(len(map)):
			visited[i].push_back(0)
	visited[x][y] = 1 # 入口节点设置为已遍历
	q.push_back([x,y])
	while !q.empty(): # 队列为空则结束循环
		var now = q[0] 
		q.pop_at(0) # 移除队列头结点
		for i in range(4):
			var point = [now[0] + xx[i], now[1] + yy[i]]#当前节点
			if point[0]<0 or point[1]<0 or point[0]>=len(map) or point[1] >= len(map[0]) or visited[point[0]][point[1]]==1 or map[point[0]][point[1]]!=0 :
				continue
			father.push_back(now)
			visited[point[0]][point[1]] = 1
			q.push_back((point))
			pre_route.push_back(point)
			if point[0] == m and point[1] == n:
				print("success")
				var path = get_route(father, pre_route)
				return path
	print("false")
	return []


func get_route(father, pre_route): #寻找并输出最短路径Z
	var route = [pre_route[-1], father[-1]]
	for i in range(len(pre_route) -1, -1, -1):
		if pre_route[i] == route[-1]:
			route.push_back(father[i])			
	route.invert()
	print("最短路径为：",route)
	print("步长",len(route)-1)
	return route
				


#---------------------------------------------------------------------------
# 外部接口
# 寻找前往目的地的下一个二维索引
func next_step(navigation_matrix,start_x,start_y,end_x,end_y):
	var path = bfs(navigation_matrix,start_x,start_y,end_x,end_y)
	if(!path):
		return null
	return [path[1][0],path[1][1]]

#-----------------------------------------------------------------------------------

#普通地图多目标寻路
#多目标的寻路，输入地图,初始坐标，目标坐标列表， 返回最短目标点坐标 Z
func next_step_multi(navigation_matrix,start_x,start_y, target_position_list:Array):
	var min1 = 999
	var path
	for i in len(target_position_list):
		var route = bfs(navigation_matrix,start_x,start_y,target_position_list[i][0],target_position_list[i][1])
		print(route)
		if min1>len(route) and len(route)>0:
			min1 = len(route)
			path = route
		
	if(!path):
		return null
	return [path[len(path)-1][0],path[len(path)-1][1]]
	






#A*算法实现 Z
#------------------------------------------------
# 外部接口函数，进入地图处理递归函数 Z
var map2:Array
var start_position:Array

func next_step_A(navigation_matrix,start_x,start_y,end_x,end_y)->Array:
	#将初始坐标赋值为1防止进入函数卡死
	navigation_matrix[start_x][start_y]=1
	
	#设置地图备份与初始坐标备份
	map2 = navigation_matrix.duplicate(true)
	start_position=[start_x,start_y]
	
	#进入地图递归函数
	A(navigation_matrix,start_x,start_y)

	#进入路径选择函数
	var route = get_A_route(navigation_matrix,start_x,start_y,end_x,end_y)
	
#	for i in range(len(navigation_matrix[0])):
#		print(navigation_matrix[i])
	print(route)
	return [route[0][0],route[0][1]]
	

#地图处理递归函数 Z
#（地图，初始x,初始y,结束x，结束y）无输出
func A(map,x:int,y:int):
	for i in range(4):
		var next_x = x + xx[i]
		var next_y = y + yy[i]
		#所有情况变量控制写在这
		if next_x >= len(map[0]) or next_x < 0 or next_y >= len(map[0]) or next_y < 0 or (next_x == start_position[0] and next_y ==start_position[1]):
			continue
		if map[next_x][next_y] == 1 or map[next_x][next_y] == 500 or map[next_x][next_y] == 99999:
			map[next_x][next_y] = map[x][y] + map[next_x][next_y]
			A(map,next_x, next_y)
		elif map[x][y] + map2[next_x][next_y] < map[next_x][next_y]:
			map[next_x][next_y] = map[x][y] + map2[next_x][next_y]
			A(map, next_x, next_y)
			

#递归处理地图后寻找路径,返回路径列表 Z
func get_A_route(map,start_x,start_y,final_x,final_y)->Array:
	var l = []
	var next_x
	var next_y
	var start = [final_x, final_y]
	while start_x != start[0] or start_y != start[1]:
		var mins = 10000000
		next_x = 0
		next_y = 0
		final_x = start[0]
		final_y = start[1]
		for i in range(4):
			if final_x + xx[i]>=10 or final_x + xx[i]<0 or final_y + yy[i]>=10 or final_y + yy[i]<0:
				continue
			elif map[final_x + xx[i]][final_y + yy[i]] < mins:
				next_x = final_x + xx[i]
				next_y = final_y + yy[i]
				mins = map[final_x + xx[i]][final_y + yy[i]]
		l.append(start)
		start = [next_x,next_y]
	#翻转后输出
	l.invert()
	return l
		
		
		
#权重地图多目标寻路
#多目标的寻路，输入地图,初始坐标，目标坐标列表， 返回最短目标点坐标 Z
func next_step_multi_A(navigation_matrix,start_x,start_y, target_position_list:Array)->Array:
	var min1 = 1000000
	var path:Array
	#将初始坐标赋值为1防止进入函数卡死
	navigation_matrix[start_x][start_y]=1
	start_position=[start_x,start_y]
	map2 = navigation_matrix.duplicate(true)	
	A(navigation_matrix,start_x,start_y)	
	for i in len(target_position_list):
		var map3:Array = navigation_matrix.duplicate(true)
		var sum = 0
		var route = get_A_route(map3,start_x,start_y,target_position_list[i][0],target_position_list[i][1])
		print(route)
		#计算权值大小判断最短
		for j in len(route):
			sum = sum + map3[route[j][0]][route[j][1]]
		print(sum)
		if sum<min1:
			min1 = sum
			path = route
	if(!path):
		return []
	return [path[len(path)-1][0],path[len(path)-1][1]]

		
		


