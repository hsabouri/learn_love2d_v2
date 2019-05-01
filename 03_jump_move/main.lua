 -- 1: Faites sauter le joueur en changeant sa vitesse verticale
 -- 2: Faites bouger le joueur à gauche et droite en changeant sa vitesse horizontale 

require "lib"

gravity = 9.81

function love.load()
	love.window.setMode(800, 800)
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81 * 64, true)

	ground_image = love.graphics.newImage("platform.png")
	player_image = love.graphics.newImage("player.png")

	ground = new_object(400, 775, 800, 50, "static")
	player = new_object(400, 200, 25, 50, "dynamic")

	attach_image(ground, ground_image)
	attach_image(player, player_image)
end

function love.keypressed(key)
	-- Pour le saut :
	-- https://love2d.org/wiki/love.keypressed
	-- https://love2d.org/wiki/Body:setLinearVelocity
end

function love.update(dt)
	world:update(dt) -- Met à jour le moteur physique

	if love.keyboard.isDown("left") then
		-- https://love2d.org/wiki/Body:setLinearVelocity
	end
	if love.keyboard.isDown("right") then
		-- https://love2d.org/wiki/Body:setLinearVelocity
	end
end

function love.draw()
	display_object(ground)
	display_object(player)
end

-- Bonus 1: Vous ne trouvez pas que quelque chose de bizzare se passe ? Appelez moi si vous avez trouvé !
-- Bonus 2: Empechez le joueur de sauter alors qu'il ne touche pas le sol :
--    - Appelez pour moi cet indice, ou cherchez sur le site ! Comment peut-on savoir que le joueur touche le sol ?...