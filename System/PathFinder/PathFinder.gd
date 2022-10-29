class_name PathFinder

#动态规划寻路算法（BFS宽度优先搜索）Z
#--------------------------------------------------------

static func bfs(map, x:int,y:int,m:int,n:int)->Array:
	var pre_route = [] # 宽度搜索得到的节点
	var q = []  # 队列结构控制循环次数
	var xx = [0, 1, 0, -1] # 右移、下移、左移、上移
	var yy = [1, 0, -1, 0]
	var visited = []  # 记录节点是否已遍历
	var father = []  # 每一个pre_route节点的父节点
#	var x:int = start_position.x/64
#	var y:int = start_position.y/64
#	var m:int = dinal_position.x/64
#	var n:int = dinal_position.y/64
	print(x,y,m,n)
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


static func get_route(father, pre_route): #寻找并输出最短路径Z
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
static func next_step(navigation_matrix,start_x,start_y,end_x,end_y):
	var path = bfs(navigation_matrix,start_x,start_y,end_x,end_y)
	if(!path):
		return null
	return [path[1][0],path[1][1]]
