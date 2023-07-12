-- Threads pre init
_threads = {
	godmode = {},
    invisibility = {}
}

-- Thread initialization
-- Thread → God mode
_threads.godmode.isActivated = false
_threads.godmode.enable = function()
	Citizen.CreateThread(function()
        _threads.godmode.isActivated = true
		while _threads.godmode.isActivated do
			SetEntityInvincible(PlayerPedId(), true)
			Citizen.Wait(1000)
		end
	end)
end
_threads.godmode.disable = function()
	_threads.godmode.isActivated = false
	SetEntityInvincible(PlayerPedId(), false)
end

-- Thread initialization
-- Thread → Invisibility
_threads.invisibility.isActivated = false
_threads.invisibility.enable = function()
	Citizen.CreateThread(function()
        _threads.invisibility.isActivated = true
		while _threads.invisibility.isActivated do
			SetEntityVisible(PlayerPedId(), false, 0)
			Citizen.Wait(1000)
		end
	end)
end
_threads.invisibility.disable = function()
	_threads.invisibility.isActivated = false
	SetEntityVisible(PlayerPedId(), true, 0)
end
