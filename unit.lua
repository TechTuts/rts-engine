RTS.unit = {}
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
