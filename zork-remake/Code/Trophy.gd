class_name Trophy extends Item


func use():
	var case = get_node("../TrophyCase")
	if !case:
		print("No trophy case to put trophy into!")
		return
	
	var res_to_case = ItemResource.new()
	res_to_case.name = name
	res_to_case.texture = texture
	res_to_case.id = id
	
	case.put(res_to_case)
	
	queue_free()
