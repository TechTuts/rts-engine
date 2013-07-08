RTS.unit = {}

function RTS.unit:init()
	local units = GetDirectoryContents("units")
	
	for k, v in ipairs(units) do
		if v.extension == "lua" then
			require(v.requirepath)
		end
	end
end

local unit = {}

function unit.new(self, unit)
    if unit then
		for i=1, #unit.move do
			unit.move[i]:setFilter("nearest", "linear")
		end
		for i=1, #unit.still do
			unit.still[i]:setFilter("nearest", "linear")
		end
		for i=1, #unit.shoot do
			unit.shoot[i]:setFilter("nearest", "linear")
		end
		local t = setmetatable(unit, getmetatable(RTS.unit))
		RTS.unit[unit.uniquename] = t
		return t
	else
		return false
	end
end

function unit.draw(self, x, y)
	love.graphics.draw(self.image, x, y)
end

unit.__index=unit

setmetatable(RTS.unit, unit)

RTS.unit:init()