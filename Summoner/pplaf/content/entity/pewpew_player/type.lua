return {
	union = 'player',
  weapons = {'pewpew_player_gun'},
  destructor = function(entity)
		pewpew.entity_destroy(entity.id)
  end
}