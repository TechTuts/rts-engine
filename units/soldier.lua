local unit = {}

unit.name = "Soldier"
unit.uniquename = "soldier_1"
unit.type = "infantry"
unit.requirements = {}
unit.cost = {}
unit.move = {love.graphics.newImage("units/soldier/soldier_move1.png"),love.graphics.newImage("units/soldier/soldier_move2.png")}
unit.still = {love.graphics.newImage("units/soldier/soldier_still.png")}
unit.shoot = {love.graphics.newImage("units/soldier/soldier_shoot1.png"), love.graphics.newImage("units/soldier/soldier_shoot2.png")}



RTS.unit:new(unit)