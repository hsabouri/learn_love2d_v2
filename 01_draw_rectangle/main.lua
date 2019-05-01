-- 1 : Afficher le rectangle1 dans une autre couleur
-- 2 : Afficher un deuxième rectangle plein en rouge
-- 3 : Remplacez les rectangle par des images que vous trouverez sur internet

-- AIDE : 
--    -https://love2d.org/wiki/love.graphics.rectangle
--    -https://love2d.org/wiki/love.graphics.setColor
--    -https://love2d.org/wiki/love.graphics.draw
--    -https://love2d.org/wiki/love.graphics.newImage

function love.load()
	rectangle1 = {}
	rectangle1.x = 100
	rectangle1.y = 100
	rectangle1.w = 150
	rectangle1.h = 350

	-- Ecrivez ici
end

function love.update(dt)
	-- Ici c'est pour le bonus !
end

function love.draw()
	-- Ecrivez ici
	love.graphics.rectangle("line", rectangle1.x, rectangle1.y, rectangle1.w, rectangle1.h)
end

-- Bonus : Faites bouger un des rectangles