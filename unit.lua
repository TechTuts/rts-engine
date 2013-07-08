RTS.unit = {}

function RTS.unit:init()
	local units = loveframes.util.GetDirectoryContents("units")
	
	for k, v in ipairs(units) do
		if v.extension == "lua" then
			require(v.requirepath)
		end
	end
end

local unit = {}

function unit.new(self, unit)
    if unit then
		local t = setmetatable(unit, getmetatable(RTS.unit))
		table.insert(RTS.unit, t)
		return t
	else
		return false
	end
end

function unit.print(self)
	print(self.name)
end

unit.__index=unit

setmetatable(RTS.unit, unit)


RTS.unit:init()