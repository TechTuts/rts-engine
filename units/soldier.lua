local unit = {}

unit.name = "Soldier"
unit.uniquename = "soldier_1"
unit.type = "infantry"
unit.requirements = {}
unit.cost = {}
unit.image = love.graphics.newImage("units/soldier1.png")
unit.image:setFilter("nearest", "linear")


RTS.unit:new(unit)