gamestate = "menu" 
offset_background = {0,0}
cinematique_fin = false
if preums == true then level = 1 end
police_50 = love.graphics.newFont(50)
police_30 = love.graphics.newFont(30)
nom_levels = {"Field trip","Sp(am)iral Nemesis","Prepare for trouble !...","... and make it double !","The light at the end of the tunnel"}

function charger_level(level)
	if level<6 then dofile("init/"..level..".lua") end
end

son_shoot = love.audio.newSource( "son/shoot.ogg", "static" )
son_explosion = love.audio.newSource( "son/explosion.ogg", "static" )
son_helico = love.audio.newSource( "son/helico.ogg", "static" )
son_propulsion = love.audio.newSource( "son/propulsion.ogg", "static" )
son_victoire = love.audio.newSource( "son/victoire.ogg", "static" )
son_intro = love.audio.newSource ( "son/intro.ogg", "static" )
son_outro = love.audio.newSource ( "son/outro.ogg", "static" )

charger_level(level)

if not love.filesystem.exists("save") then
	love.filesystem.write("save", "") 
end

record = {}
for line in love.filesystem.lines("save") do
	table.insert(record, line)
end




humiliation = {	
				"And that sucks.",
				"Classment : second-to-last, you, last, Paris Hilton. Tough.",
				"Did you even try ?",
				"Seriously ? Did I Jam so hard just to see you fail miserably ?",
				"You're just as competent as a player as I am as a game designer.",
				"Oh come ON you're not even trying anymore.",
				"You're the best at being last, pal.",
				"I guess I have to make a super easy mode now...",
				"Please don't let your kids play. They might humiliate you.",
				"Blame it on the weather.",
				"Please tell me you just lost on purpose.",
				"Coolness level : paramecium.",
				"Which is pretty great for a five years-old.",
				"Is that you, Gaeel ?",
				"Isn't playing with two broken arms too painful ?",
				"Insert humiliation here"
				}
humiliation_du_moment = humiliation[math.random(1,#humiliation)]

felicitron = {
				"Well THAT was awesome. Punctuated for emphasis.",
				"Wow, I'm so almost impressed.",
				"YOU ROCK !",
				"You make me proud !",
				"People like you keep me jamming !",
				"Now that's how it's done.",
				"Is that you, Stringfellow Hawke ?"
			}
felicitron_du_moment = felicitron[math.random(1,#felicitron)]
			
helico = { love.graphics.newImage("img/helico1.png"), love.graphics.newImage("img/helico2.png"), love.graphics.newImage("img/helico1.png"), love.graphics.newImage("img/helico2.png")  }

tirs = { }
carburant = 10 -- Timer total des 10 secondes de carburant
carburant_avant = 11
helico_largeur = helico[1]:getWidth() helico_hauteur = helico[1]:getHeight()
frame = 1
timer_frame = 0
timer_tir = debut
timer_mouvement = 0
miroir = 1
offset = 0
collision = false
background = love.graphics.newImage("img/background.png")
background_timer = love.graphics.newImage("img/timer/10.png")
ecran_titre = love.graphics.newImage("img/ecran_titre.png")

for i=1,5,1 do
	table.insert(obstacles,{200*(i-1),0,200,5,poutre_fine,0})
	table.insert(obstacles,{200*(i-1),595,200,5,poutre_fine,0})
end
for i=1,3,1 do
	table.insert(obstacles,{5,200*(i-1),5,200,poutre_fine,math.pi/2})
	table.insert(obstacles,{795,200*i,5,200,poutre_fine,-math.pi/2})
end
-- en 1 la position en x, en 2 la position en y, en 3 sa largeur, en 4 sa hauteur, en 5 le fichier image

timer_explosion = 0	frame_explosion = 1
explosion = { }
for i=1, 8, 1 do
	table.insert(explosion,love.graphics.newImage("img/explosion/"..i..".png"))
end

affichage_timer = { } son_timer = { }
for i=0, 10, 1 do
	table.insert(affichage_timer,love.graphics.newImage("img/timer/".. i ..".png"))
	table.insert(son_timer,love.audio.newSource("son/timer/".. i ..".ogg"))
end

ciel = love.graphics.newImage("img/ending/ciel.png")
