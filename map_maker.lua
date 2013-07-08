local grid_size = 20
local grid = {}
for x = 1, grid_size do
   grid[x] = {}
   for y = 1,grid_size do
      grid[x][y] = 1
   end
end
--grid[2][4] = 2
--grid[6][5] = 2

local grass = love.graphics.newImage("grass4.png")
local highlight = love.graphics.newImage("highlight.png")
local block_width = grass:getWidth()
local block_height = grass:getHeight()
local block_depth = block_height

local grid_x = 0--64*grid_size/2
local grid_y = 0

function ConvertToIso(cartX,cartY)
	isoX = cartX - cartY;
	isoY = (cartX + cartY) / 2;
	return isoX, isoY
end

function ConvertFromIso(isoX,isoY)
	cartX = (2 * isoY + isoX) / 2;
	cartY = (2 * isoY - isoX) / 2;
	return cartX, cartY
end





local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
camera:setBounds(0, 0, width, height)

local function Grid()	
	--love.graphics.draw(background)
	camera:set()
	for x = 1,grid_size do
		for y = 1,grid_size do
			if grid[x][y] == 1 then
				local x1,y1 = ConvertToIso((x * block_width/2), (y * (block_depth)))
				love.graphics.draw(grass, grid_x + x1, grid_y + y1)
				--love.graphics.printf(x..","..y, x1+block_width/2, y1+block_depth/2, 1 ,"center")
			elseif grid[x][y] == 2 then
				local x1,y1 = ConvertToIso((x * block_width/2), (y * (block_depth)))
				love.graphics.draw(highlight, grid_x + x1, grid_y + y1)
				--love.graphics.printf(x..","..y, x1+block_width/2, y1+block_depth/2, 1 ,"center")
			end
		end
	end
	camera:unset()
end
hook.Add("draw","Grid",Grid)


local speed = 400
local function MoveGrid(dt)	
	if love.keyboard.isDown('left') then
		camera:move(-speed*dt)
	elseif love.keyboard.isDown('right') then
		camera:move(speed*dt)
	end
	if love.keyboard.isDown('up') then
		camera:move(0,-speed*dt)
	elseif love.keyboard.isDown('down') then
		camera:move(0,speed*dt)
	end
end
hook.Add("update","MoveGrid",MoveGrid)

local function Hover(dt)	
	local x, y = camera:mousePosition()
	x, y = ConvertFromIso(x, y)
	x, y = round(x / block_width*2), round(y / (block_depth))
	x = x-1
	for x = 1,grid_size do
		for y = 1,grid_size do
			if grid[x][y] == 2 then
				grid[x][y]=1
			end
		end
	end
	if grid[x] and grid[x][y] then
		grid[x][y] = 2
	end
end
hook.Add("update","Hover",Hover)