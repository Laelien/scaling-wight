ennemi_image = { 	love.graphics.newImage("img/ennemis/tourelle_double_1.png"), 
					love.graphics.newImage("img/ennemis/tourelle_double_2.png"),
					love.graphics.newImage("img/ennemis/tourelle_double_3.png"),
					love.graphics.newImage("img/ennemis/tourelle_double_4.png"),
					love.graphics.newImage("img/ennemis/tourelle_double_1_spotted.png"), 
					love.graphics.newImage("img/ennemis/tourelle_double_2_spotted.png"),
					love.graphics.newImage("img/ennemis/tourelle_double_3_spotted.png"),
					love.graphics.newImage("img/ennemis/tourelle_double_4_spotted.png") }
					
ennemis = { 
				{380,260,42,50,ennemi_image,0.1,6, love.graphics.newImage("img/ennemis/tir/tourelle_double.png"),150,20,0,180,1,-1,ennemi_image[1]:getWidth(),0 }, 
				{380,260,42,50,ennemi_image,0.1,6, love.graphics.newImage("img/ennemis/tir/tourelle_double.png"),150,20,0,180,1,1,0,0 }
			}

--[[ ennemis contient en [i][1] sa position en x, en [i][2] sa position en y, en [i][3] sa largeur, en [i][4] sa hauteur, en [i][5] le fichier image, 
	en [i][6] la cadence de tir, en [i][7] la taille du tir, en [i][8] l'image du tir, en i[9] sa vitesse, en i[10] son offset sur x, en i[11] son offset sur y,
	en i[12] son angle de tir, en i[13] 2 s'il a spot l'hélico ou 1 sinon, en i[14] le miroir ou non, en i[15] l'offset nécessaire en cas de miroir, 
	en i[16] l'instant du dernier tir ]] 
pas_mouvement_ennemis = 2

pos_x = 700
pos_y = 550

arrivee = {}
for i=1,4,1 do
	arrivee[i] = love.graphics.newImage("img/arrivee/arrivee_"..i..".png")
end
coordonnees_arrivee = {345,450,30,30}-- Arrivée. x,y,largeur,hauteur

poutre_fine = love.graphics.newImage("img/obstacles/poutre_fine.png")
obstacles = { 
				{ 600, 500, 5, 200, poutre_fine,math.pi/2 },
				{ 600, 300, 5, 200, poutre_fine,math.pi/2 },
				{ 600, 100, 5, 200, poutre_fine,math.pi/2 },
				{ 200, 100, 200, 5, poutre_fine },
				{ 400, 100, 200, 5, poutre_fine },
				{ 200, 100, 5, 200, poutre_fine,math.pi/2 },
				{ 200, 300, 5, 200, poutre_fine,math.pi/2 },
				{ 200, 500, 200, 5, poutre_fine },
				{ 400, 300, 5, 200, poutre_fine,math.pi/2 },
				{ 300, 300, 200, 5, poutre_fine }
			}