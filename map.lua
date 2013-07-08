RTS.map = {}

function RTS.map:init()
	local maps = GetDirectoryContents("maps")
	
	for k, v in ipairs(maps) do
		if v.extension == "lua" then
			require(v.requirepath)
		end
	end
end

local map = {}

function map.new(self, map)
    if map then
		local t = setmetatable(map, getmetatable(RTS.map))
		table.insert(RTS.map, t)
		return t
	else
		return false
	end
end

map.__index=map

setmetatable(RTS.map, map)

RTS.map:init()