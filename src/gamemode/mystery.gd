extends "res://src/gamemode/gamemode.gd"

var killer = null

func _init():
	name = "Mystery mode"
	connect("gamemode_prepare", self, "prepare_mystery")
	connect("gamemode_check_win", self, "mystery_check_win")
	
	
func prepare_mystery():
	if timeline.is_server:
		randomize()
		var player_count = timeline.get_node("Clients").get_child_count()
		var killer_number = randi()%player_count
		killer = timeline.get_node("Clients").get_children()[killer_number]
		if killer.get_mob():
			killer.get_mob().rset("role", s_role.killer)
			killer.get_mob().role = s_role.killer
			
func mystery_check_win():
	if (killer.state & s_flag.DEAD):
		timeline.send_global_message("The killer is dead. The innocents win!")