extends StaticBody2D

var trophies: Array[ItemResource]

func view():
	pass
	#TODO: show collected trophies

func put(trophy: ItemResource):
	#TODO: double chack that item is trophy
	trophies.append(trophy)
	if (trophies.size() >= 19):
		print("all trophies collected")
