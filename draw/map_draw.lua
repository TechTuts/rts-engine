local grid_size = 20
RTS.grid = {}
for x = 1, grid_size do
   grid[x] = {}
   for y = 1,grid_size do
      grid[x][y] = 1
   end
end


local grass = love.graphics.newImage("grass.png")
local highlight = love.graphics.newImage("highlight.png")
local block_width = grass:getWidth()
local block_height = grass:getHeight()
local block_depth = block_height

local grid_x = 0--64*grid_size/2
local grid_y = 0

function Bounds()
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	camera:setBounds(0, 0, block_width*grid_size, block_width*grid_size)
end
hook.Add("load","Bounds",Bounds)


local function Grid()	
	--love.graphics.draw(background)
	camera:set()
	for x = 1,grid_size do
		for y = 1,grid_size do
			if grid[x][y] == 1 then
				local x1,y1 = x * block_width, y * block_depth
				love.graphics.draw(grass, grid_x + x1, grid_y + y1)
				--love.graphics.printf(x..","..y, grid_x + x1, grid_y + y1, 1 ,"center")
			elseif grid[x][y] == 2 then
				local x1,y1 = x * block_width, y * block_depth
				love.graphics.draw(highlight, grid_x + x1, grid_y + y1)
				love.graphics.printf(x..","..y, grid_x + x1, grid_y + y1, 1 ,"center")
			end
		end
	end
	camera:unset()
	
	love.graphics.printf(camera.scaleX, 10, 10, 10 ,"left")
end
hook.Add("draw","Grid",Grid)


local speed = 800
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

local highlighted = {}

local function Hover(dt)	
	local x, y = camera:mousePosition()
	x, y = math.floor(x / block_width), math.floor(y / block_depth)
	--x = x-1
	if highlighted.x then
		grid[highlighted.x][highlighted.y] = 1
	end
	if grid[x] and grid[x][y] then
		grid[x][y] = 2
		highlighted.x, highlighted.y = x, y
	end
end
hook.Add("update","Hover",Hover)


local function Zoom(x,y,key)	
	if key == "wu" then
		camera:scale(0.9, 0.9)
	elseif key == "wd" then
		camera:scale(1.1, 1.1)
	elseif key == "m" then
		camera:setScale(1, 1)
	end
end
hook.Add("mousepressed","Zoom",Zoom)