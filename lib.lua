
-- x : Position x 
-- y : Position y
-- w : Width of the rectangle
-- w : Height of the rectangle
-- image : image given by love.graphics.newImage("any.png") or "none" to have no image
-- type : can be "static" or "dynamic"

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

function display_object(obj)
	if obj.image ~= "none" then
		love.graphics.draw(
			obj.image,
			obj.body:getX() - obj.w / 2,
			obj.body:getY() - obj.h / 2,
			0,
			obj.ratio_w,
			obj.ratio_h
		)
	else
		love.graphics.rectangle(
			"fill",
			obj.body:getX() - obj.w / 2,
			obj.body:getY() - obj.h / 2,
			obj.w,
			obj.h
		)
	end
end