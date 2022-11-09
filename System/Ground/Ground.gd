extends Node2D
class_name Ground

enum TYPE{
	DIRT,
	SAND,
}

# 自己的所在网格
var grid = null

# 此地面的种类
var ground_type = TYPE.DIRT

# 此地面的类似编号
var version:int = 0 setget set_version

func set_version(value:int):
	$Sprite.frame = value


#------------------------------------------------------
static func is_Ground(obj)->bool:
	return obj.has_method("is_Ground")
