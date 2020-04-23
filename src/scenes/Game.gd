extends Node2D

onready var Baddies := $Baddies
onready var BaddieSpawner := $BaddieSpawner
onready var HUD := $HUD
onready var Player := $Player

var died := false



func _ready():
	Events.connect("player_has_hit", self, "_on_Events_player_has_hit")
	BaddieSpawner.setup(Baddies, Rect2(0, -50, 500, 50))


func _input(event: InputEvent):
	if died and event.is_action_pressed("ui_accept"):
		BaddieSpawner.restart_spawn()
		HUD.restart_hud()
		Player.restart_position()
		
		_clean_spawner()
		died = false


func _clean_spawner():
	for baddie in Baddies.get_children():
		baddie.queue_free()


func _on_Events_player_has_hit():
	died = true
