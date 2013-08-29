function dofile(filename)
	local dothis = loadstring(love.filesystem.read(filename))
	if dothis then
		dothis()
	end
end
	

function love.load()
	preums=true	intro_jouee = false outro_jouee = false
	dofile("init.lua")
	dofile("collisions.lua")
	dofile("shoot.lua")
end

function love.keypressed(key)
	if key == "escape" then love.event.push("quit") end
	if gamestate == "menu" and cinematique_fin == false then
		if key == "up" then debut = love.timer.getTime() gamestate = "game" end
	elseif gamestate == "fin" and cinematique_fin == false then
		if key == "up" then preums = false dofile("init.lua")  gamestate = "menu" end
	end
end

function love.update(dt)
	if gamestate == "menu" then
		if preums and intro_jouee == false then son_intro:play() intro_jouee = true end
	elseif gamestate == "game" then
		if check_arrivee() then
			son_victoire:play()
			gamestate = "fin"
			level = level + 1
			if level<6 then charger_level(level) end
		elseif collision == true then
			son_explosion:play()
			if timer_explosion > 0.06 then
				if frame_explosion == 8 then return true
				else 
					frame_explosion = frame_explosion + 1 
					offset_background[1] = math.random(-20,20)
					offset_background[2] = math.random(-20,20)
				end
				timer_explosion = 0
			end
			timer_explosion = timer_explosion + dt
			if frame_explosion == 8 then gamestate = "fin" end
		else
			son_helico:play()
			if love.keyboard.isDown("up") and carburant > 0 then 
				son_propulsion:play()
				carburant = carburant - dt
				pos_y = pos_y - 250*dt
			end
			if love.keyboard.isDown("left") then
				pos_x = pos_x - 125*dt
				miroir = 1 offset = 0
			end	
			if love.keyboard.isDown("right") then
				pos_x = pos_x + 125*dt
				miroir = -1 offset = helico_largeur
			end
			
			pos_y = pos_y + 125*dt
			
			timer_frame = timer_frame + dt
			timer_mouvement = timer_mouvement + dt
			
			if timer_frame > 0.1 then
				if frame == 4 then frame = 1
				else frame = frame + 1 end
				timer_frame = 0
			end
			
			if timer_mouvement > 0.05 then
				for i=1,#ennemis,1 do
					if pas_mouvement_ennemis == 2 and i%2 == 0 then
						ennemis[i][1] = ennemis[i-1][1]
						ennemis[i][2] = ennemis[i-1][2]
					else
						local aleatoire = math.random(1,2)
						if aleatoire == 1 then ennemis[i][1] = ennemis[i][1] + math.random(-1,1)
						else ennemis[i][2] = ennemis[i][2] + math.random(-1,1) end
					end
				end
				timer_mouvement = 0
			end
			
			shoot(dt) 
			mouvement_tirs(dt)
			check_collision(dt)
			temps_survie = love.timer.getTime()-debut
			copie_dt = dt
		end
	end
end

function love.draw()	
	if gamestate == "menu" then
		if level==1 then 
			love.graphics.draw(background,offset_background[1],offset_background[2])
			love.graphics.draw(background_timer,0,0)	
			love.graphics.draw(ecran_titre,0,0)
			love.graphics.setFont(police_50) 
			love.graphics.setColor(0, 0, 0)
			love.graphics.printf("Press Up to navigate menus or start level",0,375,800,"center")	
			love.graphics.printf("Level 1 : "..nom_levels[1],0,525,800,"center")
			love.graphics.setColor(255, 255, 255)
			
		elseif level<6 then		
			love.graphics.draw(background,offset_background[1],offset_background[2])
			love.graphics.draw(background_timer,0,0)	
			love.graphics.draw(ecran_titre,0,0)
			love.graphics.setFont(police_50) 
			love.graphics.setColor(0, 0, 0)
			love.graphics.printf("LEVEL "..level,0,375,800,"center")
			love.graphics.printf(nom_levels[level],0,450,800,"center")
			love.graphics.setColor(255, 255, 255)
			
		else -- Endgame !
			cinematique_fin = true
			dofile("ending.lua")
			ending(copie_dt)
		end
	elseif gamestate == "fin" then
		love.graphics.draw(background,offset_background[1],offset_background[2])
		if collision == true then
			love.graphics.draw(explosion[8],0,0)
			love.graphics.setFont(police_50)	love.graphics.printf("GAME OVER",0,100,800,"center")
			love.graphics.setFont(police_30)	love.graphics.printf("Your time is "..temps_survie.." seconds.",0,350,800,"center")
			love.graphics.printf(humiliation_du_moment,0,400,800,"center")
		else
			love.graphics.draw(background,0,0)
			love.graphics.draw(background_timer,0,0)	
			love.graphics.setFont(police_50)	love.graphics.printf("VICTORY !",0,100,800,"center")
			love.graphics.setFont(police_30)	love.graphics.printf("Your time is "..temps_survie.." and you had "..carburant.." seconds of flight left.",0,300,800,"center")
			love.graphics.printf("Your score is ".. temps_survie - carburant,0,375,800,"center")
			if level<=6 then
				record[level-1] = tonumber(record[level-1])
				if record[level-1] == nil or 
					record[level-1] > temps_survie - carburant then 
					record[level-1] = temps_survie - carburant 
					local texte = ""
					for i=1,#record,1 do
						texte = texte..record[i].."\n"
					end
					love.filesystem.write("save",texte) 
				end
				love.graphics.printf(felicitron_du_moment,0,525,800,"center")			
				love.graphics.printf("Current best : "..record[level-1],0,450,800,"center")	
			end
		end
	elseif gamestate == "game" then
		love.graphics.draw(background,offset_background[1],offset_background[2])
		if carburant >= -1 then love.graphics.draw(affichage_timer[math.ceil(carburant)+1]) end
		if math.ceil(carburant) ~= math.ceil(carburant_avant) then son_timer[math.ceil(carburant)+1]:play() end
		love.graphics.draw(helico[frame], pos_x, pos_y,0,miroir,1,offset)
		for i=1,#ennemis,1 do
			love.graphics.draw(ennemis[i][5][ennemis[i][13]*(frame%4+1)],ennemis[i][1],ennemis[i][2],0,ennemis[i][14],1,ennemis[i][15])
		end
		for i=1,#obstacles,1 do
			love.graphics.draw(obstacles[i][5],obstacles[i][1],obstacles[i][2],obstacles[i][6])
		end
		dessin_tirs()	
		love.graphics.draw(arrivee[frame%4+1],coordonnees_arrivee[1],coordonnees_arrivee[2])
		if collision == true then love.graphics.draw(explosion[frame_explosion], pos_x+helico_largeur/2-explosion[frame_explosion]:getWidth()/2, pos_y+helico_hauteur/2-explosion[frame_explosion]:getWidth()/2) end
	end
	carburant_avant = carburant
end
