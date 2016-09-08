/area/elevator
	luminosity = 5
	name = "Elevator"

	/area/elevator/New()
		spawn ..()
		name = "Elevator on floor [z]"
		spawn(50)
			world << "[src] is alive on floor [src.z]"
		elevator.elevators.Add(src)
		looper.schedule(elevator)

	/area/elevator/proc/floor_up()
		for (var/atom/movable/other in src)
			var/atom/oloc = locate(other.x, other.y, other.z + 1)
			var/area/elevator/a = oloc.GetArea()
			if (istype(a))
				a.opacity = 0
				other.Move(oloc)
				elevator.elevator_z = oloc.z
				other << "<b> Floor:</b><big> [elevator.elevator_z] </big>"
			else
				return
		opacity = 1

	/area/elevator/proc/floor_down()
		if (elevator.elevator_z >= 1)
			for (var/atom/movable/other in src)
				var/atom/oloc = locate(other.x, other.y, other.z - 1)
				var/area/elevator/a = oloc.GetArea()
				if (istype(a))
					a.opacity = 0
					other.Move(oloc)
					elevator.elevator_z = oloc.z
					other << "<b> Floor:</b><big> [elevator.elevator_z] </big>"
				else
					return
			opacity = 1
