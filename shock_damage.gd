extends Area2D

func damage_all_in_area():
	var targets = get_overlapping_areas()
	
	if targets.is_empty():
		return
	
	for target in targets:
		if target.is_in_group('target'):
			target.emit_signal('hurt', 6)
	
