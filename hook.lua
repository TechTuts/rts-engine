hook = {}
hooks = {}

function hook.Add( funcname, uniqueid, func )
	if not hooks[funcname] then hooks[funcname] = {} end
	hooks[funcname][uniqueid] = func
end

function hook.Remove( funcname, uniqueid )
	hooks[funcname][uniqueid] = nil
end

function hook.Call( funcname, uniqueid, ... )
	hooks[funcname][uniqueid](...)
end

function hook.CallAll( funcname, ... )
	if not hooks[funcname] then hooks[funcname] = {} end
	for k,v in pairs(hooks[funcname]) do
		v(...)
	end
end

function love.load()
	hook.CallAll("load")
	require("LoveFrames")
end

function love.update(dt)
	loveframes.update(dt)
	hook.CallAll("update", dt)
end

function love.draw()
	hook.CallAll("draw")
	loveframes.draw()
end

function love.quit()
	hook.CallAll("quit")
end


function love.keypressed( key, unicode )
	loveframes.keypressed(key, unicode)
	hook.CallAll("keypressed", key, unicode)

end

function love.keyreleased( key )
	loveframes.keyreleased(key)
	hook.CallAll("keyreleased", key)
end

function love.mousepressed( x, y, button )
	loveframes.mousepressed(x, y, button)
	hook.CallAll( "mousepressed", x, y, button )
end

function love.mousereleased( x, y, button )
	loveframes.mousereleased(x, y, button)
	hook.CallAll( "mousereleased", x, y, button )
end