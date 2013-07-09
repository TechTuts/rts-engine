function tableCount (t)
  local i = 0
  for k in pairs(t) do i = i + 1 end
  return i
end

function totable ( str )
    local tbl = {}
    
    for i = 1, string.len( str ) do
        tbl[i] = string.sub( str, i, i )
    end
    
    return tbl
end

function round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

local string_sub = string.sub
local string_gsub = string.gsub
local string_gmatch = string.gmatch

function string.Explode(str, separator, withpattern)
    if (separator == "") then return totable( str ) end
     
    local ret = {}
    local index,lastPosition = 1,1
     
    -- Escape all magic characters in separator
    if not withpattern then separator = string_gsub( separator, "[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1" ) end
     
    -- Find the parts
    for startPosition,endPosition in string_gmatch( str, "()" .. separator.."()" ) do
        ret[index] = string_sub( str, lastPosition, startPosition-1)
        index = index + 1
         
        -- Keep track of the position
        lastPosition = endPosition
    end
     
    -- Add last part by using the position we stored
    ret[index] = string_sub( str, lastPosition)
    return ret
end

function string.Left(str, num)
    return string.sub(str, 1, num)
end

function CheckIP(ip)
    -- must pass in a string value
    if ip == nil or type(ip) ~= "string" then
        return false
    end

    -- check for format 1.11.111.111 for ipv4
    local chunks = {ip:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")}
    if (#chunks == 4) then
        for _,v in pairs(chunks) do
            if (tonumber(v) < 0 or tonumber(v) > 255) then
                return 0
            end
        end
        return true
    else
        return false
    end

end

function shuffled(tab)
	local n, order, res = #tab, {}, {}
	
	for i=1,n do order[i] = { rnd = math.random(), idx = i } end
	table.sort(order, function(a,b) return a.rnd < b.rnd end)
	for i=1,n do res[i] = tab[order[i].idx] end
	return res
end

function SplitString(str, pat)

	local t = {}  -- NOTE: use {n = 0} in Lua-5.0
	
	if pat == " " then
		local fpat = "(.-)" .. pat
		local last_end = 1
		local s, e, cap = str:find(fpat, 1)
		while s do
			if s ~= #str then
				cap = cap .. " "
			end
			if s ~= 1 or cap ~= "" then
				table.insert(t,cap)
			end
			last_end = e+1
			s, e, cap = str:find(fpat, last_end)
		end
		if last_end <= #str then
			cap = str:sub(last_end)
			table.insert(t, cap)
		end
	else
		local fpat = "(.-)" .. pat
		local last_end = 1
		local s, e, cap = str:find(fpat, 1)
		while s do
			if s ~= 1 or cap ~= "" then
				table.insert(t,cap)
			end
			last_end = e+1
			s, e, cap = str:find(fpat, last_end)
		end
		if last_end <= #str then
			cap = str:sub(last_end)
			table.insert(t, cap)
		end
	end
	
	return t
	
end

function GetDirectoryContents(dir, t)

	local dir = dir
	local t = t or {}
	local files = love.filesystem.enumerate(dir)
	local dirs = {}
	
	for k, v in ipairs(files) do
		local isdir = love.filesystem.isDirectory(dir.. "/" ..v)
		if isdir == true then
			table.insert(dirs, dir.. "/" ..v)
		else
			local parts = SplitString(v, "([.])")
			local extension = parts[#parts]
			parts[#parts] = nil
			local name = table.concat(parts)
			table.insert(t, {path = dir, fullpath = dir.. "/" ..v, requirepath = dir .. "." ..name, name = name, extension = extension})
		end
	end
	
	if #dirs > 0 then
		for k, v in ipairs(dirs) do
			t = loveframes.util.GetDirectoryContents(v, t)
		end
	end
	
	return t
	
end

