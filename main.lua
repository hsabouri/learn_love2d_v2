jump_force = 6
run_speed = 5
air_jumps = 1
start_x = 200
start_y = 490

function new_object(x, y, w, h, image, type)
	ret = {}
	ret.w = w
	ret.h = h
	if image ~= "none" then
		ret.ratio_w = w / image:getWidth()
		ret.ratio_h = h / image:getHeight()
	end
	ret.body = love.physics.newBody(world, x, y, type)
	ret.shape = love.physics.newRectangleShape(w, h)
	ret.fixture = love.physics.newFixture(ret.body, ret.shape)
	ret.fixture:setFriction(0)
	ret.image = image
	return ret
end

function love.load()
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81 * 256, true)

	platform_image = love.graphics.newImage("platform.png")
	player_image = love.graphics.newImage("player.png")
	background_image = love.graphics.newImage("background.png")
	win_image = love.graphics.newImage("you_win.png")
	goal_image = love.graphics.newImage("goal.png")
	
	objects = {}
	objects.platforms = {}
	objects.platforms[1] = new_object(200, 750, 100, 25, platform_image, "static")
	objects.platforms[2] = new_object(400, 650, 100, 25, platform_image, "static")
	objects.platforms[3] = new_object(500, 540, 100, 25, platform_image, "static")
	objects.platforms[4] = new_object(250, 400, 100, 25, platform_image, "static")

	objects.player = new_object(start_x, start_y, 25, 50, player_image, "dynamic")
	objects.goal = new_object(450, 170, 50, 50, goal_image, "static")

	current_air_jumps = air_jumps
	jump = false
	win = false

	love.window.setMode(800, 800)
end

function love.keypressed(key)
	if key == "space" then
		jump = true
	end
	if key == "escape" then
		love.event.quit(0)
	end
end

function min_ground_dis()
	min = 1000

	for key, value in ipairs(objects.platforms) do
		tmp = love.physics.getDistance(value.fixture, objects.player.fixture)
		if tmp < min then
			min = tmp
		end
	end
end

function love.update(dt) -- Amount of time spent from last frame
	if win == false then
		world:update(dt)
	end

	-- freeze orientation of player
	objects.player.body:setAngle(0)
	
	x, y = objects.player.body:getPosition()
	v_x, v_y = objects.player.body:getLinearVelocity()

	ground_player_dis = min_ground_dis()

	if v_y == 0 then -- reset air_jumps when player is on the floor
		current_air_jumps = air_jumps
	end

	if love.keyboard.isDown("a") then -- handle left-rigth keys
		objects.player.body:setLinearVelocity(-run_speed * 64, v_y)
		v_x = -run_speed * 64
	elseif love.keyboard.isDown("d") then
		objects.player.body:setLinearVelocity(run_speed * 64, v_y)
		v_x = run_speed * 64
	else
		objects.player.body:setLinearVelocity(0, v_y)
		v_x = 0
	end

	if jump == true then
		if current_air_jumps > 0 then
			objects.player.body:setLinearVelocity(v_x, jump_force * -156.8) -- Set a vertical velocity to make the player jump
			current_air_jumps = current_air_jumps - 1
		end
		jump = false
	end

	if love.physics.getDistance(objects.goal.fixture, objects.player.fixture) == 0 then -- check if player is touching win zone
		win = true
	elseif objects.player.body:getX() > 800 or objects.player.body:getX() < 0 or objects.player.body:getY() > 800 then
		objects.player.body:setX(start_x)
		objects.player.body:setY(start_y)
	end
end

function love.draw()
	love.graphics.setColor(1, 1, 1, 1) -- Reset drawing color

	if win == false then -- player is trying to win ;)
		love.graphics.draw(background_image)

		for key, value in ipairs(objects.platforms) do -- draw all platforms
			love.graphics.draw(
				value.image,
				value.body:getX() - value.w / 2,
				value.body:getY() - value.h / 2,
				0,
				value.ratio_w,
				value.ratio_h
			)
		end

		love.graphics.draw( -- draw player
			objects.player.image,
			objects.player.body:getX() - objects.player.w / 2,
			objects.player.body:getY() - objects.player.h / 2,
			0,
			objects.player.ratio_w,
			objects.player.ratio_h
		)

		love.graphics.draw( -- draw player
			objects.goal.image,
			objects.goal.body:getX() - objects.goal.w / 2,
			objects.goal.body:getY() - objects.goal.h / 2,
			0,
			objects.goal.ratio_w,
			objects.goal.ratio_h
		)

	else -- player has win
		love.graphics.draw(
			win_image,
			400 - win_image:getWidth() / 2,
			400 - win_image:getHeight() / 2
		)
	end
end