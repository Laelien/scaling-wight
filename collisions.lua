function check_collision(dt) -- Gère les collisions
	local helico_hitbox = { pos_x+helico_largeur/2, pos_y+helico_hauteur/2, helico_largeur-helico_largeur*0.7 }
	local i = 1
	while i<=#ennemis do
		local ennemi_hitbox = { 
									ennemis[i][1] + ennemis[i][3]/2, 
									ennemis[i][2] + ennemis[i][4]/2,
									math.max(ennemis[i][3]-ennemis[i][3]*0.6, ennemis[i][4]-ennemis[i][4]*0.6 ) 
								}
								
		if ennemi_hitbox[3] + helico_hitbox[3] >= math.sqrt((ennemi_hitbox[2]-helico_hitbox[2])^2 + (ennemi_hitbox[1]-helico_hitbox[1])^2 ) then
			collision = true return true
		end
		i = i+1
	end
	
	local j = 1
	while j<=#tirs do
		local tir_hitbox = { 
									tirs[j][3] + tirs[j][2]/2, 
									tirs[j][4] + tirs[j][2]/2,
									tirs[j][2]-tirs[j][2]*0.5 
								}						
		if tir_hitbox[3] + helico_hitbox[3] >= math.sqrt((tir_hitbox[2]-helico_hitbox[2])^2 + (tir_hitbox[1]-helico_hitbox[1])^2 ) then
			collision = true return true
		end
		j=j+1
	end
	
	local k = 1
	while k<=#obstacles do
		if test_obstacle(k,helico_hitbox) then collision = true return true 
		else k=k+1 end
	end
end

function check_arrivee() -- Checke si c'est gagné !
	if 	(pos_x + helico_largeur/2 - coordonnees_arrivee[1] - coordonnees_arrivee[3]/2 )^2+
		(pos_y + helico_hauteur/2 - coordonnees_arrivee[2] - coordonnees_arrivee[4]/2 )^2 
		< 	
		((coordonnees_arrivee[3])^2 + (coordonnees_arrivee[4])^2) /4 +
		((helico_hauteur)^2 + (helico_largeur)^2) /4 then
		return true
	end
end

function test_obstacle(k,sphere_hitbox)
		if obstacles[k][2] > sphere_hitbox[2] + sphere_hitbox[3] then return false end -- Approche par le haut
		if obstacles[k][2] + obstacles[k][4] < sphere_hitbox[2] - sphere_hitbox[3] then return false end -- Approche par le bas
		if obstacles[k][1] > sphere_hitbox[1] + sphere_hitbox[3] then return false end -- Approche par la gauche
		if obstacles[k][1] + obstacles[k][3] < sphere_hitbox[1] - sphere_hitbox[3] then return false end -- Approche par la droite			
		if sphere_hitbox[3] > math.sqrt((obstacles[k][1]-sphere_hitbox[1])^2 + (obstacles[k][2]-sphere_hitbox[2])^2) then return false end
		if sphere_hitbox[3] > math.sqrt((obstacles[k][1]-sphere_hitbox[1]+obstacles[k][3])^2 + (obstacles[k][2]-sphere_hitbox[2])^2) then return false end
		if sphere_hitbox[3] > math.sqrt((obstacles[k][1]-sphere_hitbox[1]+obstacles[k][3])^2 + (obstacles[k][2]-sphere_hitbox[2]+obstacles[k][4])^2) then return false end
		if sphere_hitbox[3] > math.sqrt((obstacles[k][1]-sphere_hitbox[1])^2 + (obstacles[k][2]-sphere_hitbox[2]+obstacles[k][4])^2) then return false end
		return true
end


--Admiral, we're trapped in the giant alien base with only ten seconds worth of fuel in our supernuclear physically unrealistic helicopter, get us out of here !
--Admiral, we've finally made it out ! Just remind me to fire Rogers for these annoying countdowns when we get home. Wait, what is thi-