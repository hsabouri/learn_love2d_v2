function is_touching(box1, box2)
	if box1.x < box2.x + box2.w and box1.x + box1.w > box2.x and box1.y < box2.y + box2.h and box1.y + box1.h > box2.y then
		return true
	end
	return false
end

function is_touching_any(player, boxes)
	for i, box in ipairs(boxes) do
		dis = is_touching(player, box)
		if dis then
			return true, box
		end
	end
	return false
end

function love.load()
	player = {
		x = 0, y = 0,
		w = 50, h = 100,
		speedz = 0,
		color = {255, 255, 255, 255}
	}
	start = {x = 100, y = 100}
	platforms = {
		{x = 90, y = 400, w = 200, h = 50},
		{x = 500, y = 400, w = 200, h = 50}
	}

	player.x = start.x
	player.y = start.y
end

function love.keypressed(key)
	if key == "space" then
		player.speedz = -20
	end
end

function love.update()
	if player.speedz + 2 < 30 then
		player.speedz = player.speedz + 2
	end
	player.y = player.y + player.speedz
	touched, box = is_touching_any(player, platforms)
	if touched then
		player.y = box.y - player.h
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - 10
	end
	if love.keyboard.isDown("d") then
		player.x = player.x + 10
	end
end

function love.draw()
	love.graphics.setColor(player.color)
	love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)

	love.graphics.setColor(128, 100, 112, 255)
	for i, platform in ipairs(platforms) do
		love.graphics.rectangle("fill", platform.x, platform.y, platform.w, platform.h)
	end
end