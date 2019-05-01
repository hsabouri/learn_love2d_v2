-- 1 : Créez un object physique "dynamique" sercant de joueur
-- 2 : Attachez une image aux deux objets !

require "lib"

gravity = 9.81

function love.load()
	love.window.setMode(800, 800)
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81 * 64, true)

	ground = new_object(400, 775, 800, 50, "static")
	-- Ecrivez ici
end

function love.update(dt)
	world:update(dt) -- Met à jour le moteur physique
end

function love.draw()
	display_object(ground)
end
