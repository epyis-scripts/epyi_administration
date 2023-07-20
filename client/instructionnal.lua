---setInstructionnalButtons → Define instructionnals buttons
---@param buttons table
---@param layout integer
---@return void
function setInstructionnalButtons(buttons, layout)
	Citizen.CreateThread(function()
		if not HasScaleformMovieLoaded(_var.instructionnal.buttons) then
			_var.instructionnal.buttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(_var.instructionnal.buttons) do
				Citizen.Wait(0)
			end
		end
		local sf = _var.instructionnal.buttons
		local w, h = GetScreenResolution()
		PushScaleformMovieFunction(sf, "INSTRUCTIONAL_BUTTONS")
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf, "SET_DISPLAY_CONFIG")
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PushScaleformMovieFunctionParameterFloat(0.02)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterFloat(0.02)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterBool(true)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf, "SET_MAX_WIDTH")
		PushScaleformMovieFunctionParameterInt(1)
		PopScaleformMovieFunction()
		for i, btn in pairs(buttons) do
			PushScaleformMovieFunction(sf, "SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(i - 1)
			PushScaleformMovieFunctionParameterString(btn[1])
			PushScaleformMovieFunctionParameterString(btn[2])
			PopScaleformMovieFunction()
		end
		if layout ~= 1 then
			PushScaleformMovieFunction(sf, "SET_PADDING")
			PushScaleformMovieFunctionParameterInt(10)
			PopScaleformMovieFunction()
		end
		PushScaleformMovieFunction(sf, "DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(layout)
		PopScaleformMovieFunction()
	end)
end

---drawInstructionnalButtons → Draw instructionnals buttons
---@return void
function drawInstructionnalButtons()
	if HasScaleformMovieLoaded(_var.instructionnal.buttons) then
		DrawScaleformMovie(_var.instructionnal.buttons, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
	end
end
