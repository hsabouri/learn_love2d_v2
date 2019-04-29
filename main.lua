jump_force = 4
air_jumps = 2

function love.load()
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81 * 64, true)
	
	objects = {}
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, 400, 775)
	objects.ground.shape = love.physics.newRectangleShape(800, 50)
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

	objects.player = {}
	objects.player.body = love.physics.newBody(world, 400, 300, "dynamic")
	objects.player.shape = love.physics.newRectangleShape(25, 50)
	objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape)

	current_air_jumps = air_jumps

	love.window.setMode(800, 800)
end

function love.update(dt) -- Amount of time spent from last frame
	world:update(dt)
	
	x, y = objects.player.body:getPosition()
	v_x, v_y = objects.player.body:getLinearVelocity()
	ground_player_dis = love.physics.getDistance(objects.ground.fixture, objects.player.fixture)
	if ground_player_dis == 0 then
		curren_air_jumps = air_jumps
	end
	if love.keyboard.isDown("a") then
		objects.player.body:setPosition(x - 10, y)
	end
	if love.keyboard.isDown("d") then
		objects.player.body:setPosition(x + 10, y)
	end
	if ground_player_dis == 0 or current_air_jumps > 0 then
		if love.keyboard.isDown("space") then
			objects.player.body:setLinearVelocity(v_x, jump_force * -156.8)
			current_air_jumps = current_air_jumps - 1
		end
	end
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
	love.graphics.polygon("fill", objects.player.body:getWorldPoints(objects.player.shape:getPoints()))
end