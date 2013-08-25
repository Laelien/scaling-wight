ennemi_image = { 	love.graphics.newImage("img/ennemis/tourelle_1.png"), 
					love.graphics.newImage("img/ennemis/tourelle_2.png"),
					love.graphics.newImage("img/ennemis/tourelle_3.png"),
					love.graphics.newImage("img/ennemis/tourelle_4.png"),
					love.graphics.newImage("img/ennemis/tourelle_1_spotted.png"), 
					love.graphics.newImage("img/ennemis/tourelle_2_spotted.png"),
					love.graphics.newImage("img/ennemis/tourelle_3_spotted.png"),
					love.graphics.newImage("img/ennemis/tourelle_4_spotted.png") }
					
ennemis = { 
				{150,480,42,50,ennemi_image,1,10, love.graphics.newImage("img/ennemis/tir/tourelle.png"),100,40,0,70,1,1,0,0 }, 
				{650,280,42,50,ennemi_image,1,10, love.graphics.newImage("img/ennemis/tir/tourelle.png"),100,40,0,70,1,-1,ennemi_image[1]:getWidth(),0 },
				{100,80,42,50,ennemi_image,1,10, love.graphics.newImage("img/ennemis/tir/tourelle.png"),100,40,0,70,1,1,0,0 }
			}
			
--[[ ennemis contient en [i][1] sa position en x, en [i][2] sa position en y, en [i][3] sa largeur, en [i][4] sa hauteur, en [i][5] le fichier image, 
	en [i][6] la cadence de tir, en [i][7] la taille du tir, en [i][8] l'image du tir, en i[9] sa vitesse, en i[10] son offset sur x, en i[11] son offset sur y,
	en i[12] son angle de tir, en i[13] 2 s'il a spot l'hélico ou 1 sinon, en i[14] le miroir ou non, en i[15] l'offset nécessaire en cas de miroir, 
	en i[16] l'instant du dernier tir ]] 
	
pas_mouvement_ennemis = 1

pos_x = 600
pos_y = 500

arrivee = {}
for i=1,4,1 do
	arrivee[i] = love.graphics.newImage("img/arrivee/arrivee_"..i..".png")
end
coordonnees_arrivee = {5,5,30,30}-- Arrivée. x,y,largeur,hauteur

poutre_fine = love.graphics.newImage("img/obstacles/poutre_fine.png")
obstacles = { 
				{ 200, 400, 200, 5, poutre_fine },
				{ 400, 400, 200, 5, poutre_fine },
				{ 600, 400, 200, 5, poutre_fine }, 
				{ 0, 200, 200, 5, poutre_fine }, 
				{ 200, 200, 200, 5, poutre_fine },
				{ 400, 200, 200, 5, poutre_fine }
			}