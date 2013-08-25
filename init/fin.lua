ciel = love.graphics.newImage("img/ending/ciel.png")
terre = {}

for i=1,20,1 do
	terre[i] = love.graphics.newImage("img/ending/terre_1.png")
end
for i=1,13,1 do
	terre[20+i] = love.graphics.newImage("img/ending/terre_"..i..".png")
end