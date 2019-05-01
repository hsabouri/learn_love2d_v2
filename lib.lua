
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