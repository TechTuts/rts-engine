RTS.State = ""

function RTS:setState(state)
	RTS.State = string.lower(state)
	loveframes.SetState(string.lower(state))
end

function RTS:getState(state)
	return RTS.State
end