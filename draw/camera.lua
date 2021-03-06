camera = {}
camera._x = 0
camera._y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0
 
 function math.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end
 
function camera:set()
	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
	love.graphics.translate(-self._x, -self._y)
end
 
function camera:unset()
	love.graphics.pop()
end
 
function camera:move(dx, dy)
	camera:setX(self._x + (dx or 0))
	camera:setY(self._y + (dy or 0))
end
 
function camera:rotate(dr)
	self.rotation = self.rotation + dr
end
 
function camera:scale(sx, sy)
	sx = sx or 1
	if math.clamp(self.scaleX * sx, 0.8, 1.2) == self.scaleX * sx then
		self.scaleX = math.clamp(self.scaleX * sx, 0.8, 1.2)
		self.scaleY = math.clamp(self.scaleY * (sy or sx), 0.8, 1.2)
		self._x = self._x*sx
	else
		self.scaleX = math.clamp(self.scaleX * sx, 0.8, 1.2)
		self.scaleY = math.clamp(self.scaleY * (sy or sx), 0.8, 1.2)
	end
	--self._y = self._y/sy
end
 
function camera:setX(value)
	if self._bounds then
		self._x = math.clamp(value, self._bounds.x1, self._bounds.x2)
	else
		self._x = value
	end
end
 
function camera:setY(value)
	if self._bounds then
		self._y = math.clamp(value, self._bounds.y1, self._bounds.y2)
	else
		self._y = value
	end
end
 
function camera:setPosition(x, y)
	if x then self:setX(x) end
	if y then self:setY(y) end
end
 
function camera:setScale(sx, sy)
	self._x = self._x*(sx/self.scaleX)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY
end
 
function camera:getBounds()
	return unpack(self._bounds)
end
 
function camera:setBounds(x1, y1, x2, y2)
	self._bounds = { x1 = x1, y1 = y1, x2 = x2, y2 = y2 }
end

camera.layers = {}

function camera:newLayer(scale, func)
	table.insert(self.layers, { draw = func, scale = scale })
	table.sort(self.layers, function(a, b) return a.scale < b.scale end)
end

function camera:draw()
	local bx, by = self.x, self.y
  
	for _, v in ipairs(self.layers) do
		self.x = bx * v.scale
		self.y = by * v.scale
		camera:set()
		v.draw()
		camera:unset()
	end
end

function camera:mousePosition()
	return love.mouse.getX() * self.scaleX + self._x, love.mouse.getY() * self.scaleY + self._y
end