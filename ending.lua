function ending(dt)
	if outro_jouee == false then son_outro:play() outro_jouee = true end
	dofile("init/fin.lua")
	
	timer_frame = timer_frame+dt
	if timer_frame > 0.1 then
		if frame == 4 then frame = 1
		else frame = frame + 1 end
		timer_frame = 0
	end
	if x==nil or x==0 then x=timer_frame
	else x=x+50*timer_frame end
	if son_outro:isStopped() == false then
		love.graphics.draw(ciel,x,0)	love.graphics.draw(ciel,x-800,0)		love.graphics.draw(ciel,x-1600,0)
		love.graphics.printf("THANKS FOR PLAYING AND NOT HAVING RAGEQUITTED AFTER ALL THESE MEAN WORDS !",0,325,800,"center")
		love.graphics.printf("Hope you enjoyed !",0,425,800,"center")
		love.graphics.draw(helico[frame],400,300,0)
	else
		son_explosion:setLooping(true)
		son_explosion:play()
		love.graphics.draw(background,0,0)
		love.graphics.draw(love.graphics.newImage("img/timer/10.png"),0,0)	
		love.graphics.setColor(0,0,0)
		love.graphics.printf("CREDITS",0,125,800,"center")
		love.graphics.printf("EVERYTHING",0,350,800,"center")
		love.graphics.printf("Me",0,400,800,"center")
		love.graphics.setColor(255,255,255)		
	end
end
