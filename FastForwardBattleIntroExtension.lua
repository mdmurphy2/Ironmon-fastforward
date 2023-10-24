local function FastForwardBattleIntro()
	local self = {
		version = "1.1",
		name = "Fast Forward Battle Intro",
		author = "Subwild & UTDZac",
		description = "Automatically speeds up the battle animation for a Pokémon or Trainer sliding in, and the player throwing out their Pokémon.",
		url = nil, -- Remove or set to nil if no host website available for this extension
	}

	function self.startFastForward()
		Utils.tempDisableBizhawkSound()
		client.speedmode(6400) -- Max framerate
		self.isFastForwarding = true
	end

	function self.endFastForward()
		Utils.tempEnableBizhawkSound()
		client.speedmode(self.normalSpeed)
		self.isFastForwarding = false
	end

	function self.isFightMenuAvailable()
		return Memory.readdword(GameSettings.gBattleMainFunc) == GameSettings.HandleTurnActionSelectionState
	end

	-- Executed only once: When the extension is enabled by the user, and/or when the Tracker first starts up, after it loads all other required files and code
	function self.startup()
		self.isFastForwarding = false
		local bizhawkConfig = client.getconfig() or {}
		self.normalSpeed = bizhawkConfig.SpeedPercent or 100
	end

	-- Executed after a new battle begins (wild or trainer), and only once per battle
	function self.afterBattleBegins()
		if not Main.IsOnBizhawk() then return end

		local bizhawkConfig = client.getconfig() or {}
		self.normalSpeed = bizhawkConfig.SpeedPercent or 100
		self.startFastForward()
	end

	function self.afterBattleDataUpdate()
		if self.isFastForwarding and self.isFightMenuAvailable() then
			self.endFastForward()
		end
	end

	return self
end
return FastForwardBattleIntro