function shoot(dt)
	for i=1,#ennemis,1 do
		ennemis[i][16] = ennemis[i][16]+dt
		if ennemis[i][16] + dt > ennemis[i][6] then
			local alpha = math.atan2(pos_x-ennemis[i][1],pos_y-ennemis[i][2])	local offset_shoot = 0	
			if ennemis[i][14] == -1 then 
				offset_shoot = ennemis[i][15]/2
			end
			if math.deg(ennemis[i][14]*alpha) >= 90-ennemis[i][12]/2 and math.deg(ennemis[i][14]*alpha) <= 90+ennemis[i][12]/2 then 
				ennemis[i][13] = 2
				local x = ennemis[i][9]*math.sin(alpha)		local y = ennemis[i][9]*math.cos(alpha)
				son_shoot:play()
				table.insert(tirs, {ennemis[i][8], ennemis[i][7], ennemis[i][1]+ennemis[i][10]-2*offset_shoot, ennemis[i][2]+ennemis[i][11], x,y } )
				-- 1 est l'image du tir, 2 sa taille, 3 sa position en x, 4 sa position en y, 5 sa destination en x, 6 sa destination en y
				ennemis[i][16] = 0
			else ennemis[i][13] = 1
			end
		end
	end
end

function mouvement_tirs(dt) -- Déplace tous les tirs dans la direction souhaitée
	for i=1,#tirs,1 do
		tirs[i][3] = tirs[i][3] + tirs[i][5]*dt 	tirs[i][4] = tirs[i][4] + tirs[i][6]*dt
	end
end

function dessin_tirs() -- Dessine tous les tirs sur la map avec leurs nouveaux emplacements
	for i=1,#tirs,1 do
		love.graphics.draw(tirs[i][1], tirs[i][3], tirs[i][4])
	end
end