extends Button

var click_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Totalni noobak bez kliku"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_pressed():
	click_count += 1
	text = "Player: " + str(click_count)
