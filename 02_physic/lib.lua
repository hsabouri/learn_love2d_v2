
-- x : Position x 
-- y : Position y
-- w : Width of the rectangle
-- w : Height of the rectangle
-- type : can be "static" or "dynamic"

function new_object(x, y, w, h, type)
	ret = {}
	ret.w = w
	ret.h = h
	ret.body = love.physics.newBody(world, x, y, type)
	ret.shape = love.physics.newRectangleShape(w, h)
	ret.fixture = love.physics.newFixture(ret.body, ret.shape)
	ret.fixture:setFriction(0)
	ret.image = "none"
	return ret
end

-- obj : Any object created with new_object(...)
-- image : an image craeted with love.graphics.newImage("any.png")

function attach_image(obj, image)
	obj.ratio_w = obj.w / image:getWidth()
	obj.ratio_h = obj.h / image:getHeight()
	obj.image = image
	return obj
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