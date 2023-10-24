-- This is a template for a custom code extension for the Ironmon Tracker.
-- To use, first rename both this top-most function and the return value at the bottom: "CodeExtensionTemplate" -> "YourFileNameHere"
-- Then fill in each function you want to use with the code you want executed during Tracker runtime.
-- The name, author, and description attribute fields are used by the Tracker to identify this extension, please always include them.
-- You can safely remove unused functions; they won't be called.

local function FastForwardBattleIntro()
	local self = {}

	-- Define descriptive attributes of the custom extension that are displayed on the Tracker settings
	self.name = "Fast Forward Battle Intro"
	self.author = "Subwild"
	self.description = "Fast forwards the sliding in and throwing pokemon animation"
	self.version = "1.0"
	self.url = nil -- Remove or set to nil if no host website available for this extension

    
    self.isFastForwarding = false;
    -- Executed after a new battle begins (wild or trainer), and only once per battle
	function self.afterBattleBegins()
        self.isFastForwarding = true;
		self.normalSpeed = client.getconfig().SpeedPercent;
		Utils.tempDisableBizhawkSound()
        client.speedmode(6400);
	end


	-- Executed each frame of the game loop, after most data from game memory is read in but before any natural redraw events occur
	-- CAUTION: Avoid code here if possible, as this can easily affect performance. Most Tracker updates occur at 30-frame intervals, some at 10-frame.
	function self.afterEachFrame()
		if  self.isFastForwarding and Memory.readdword(GameSettings.gBattleMainFunc) == GameSettings.HandleTurnActionSelectionState  then
            client.speedmode(self.normalSpeed);
			Utils.tempEnableBizhawkSound()
            self.isFastForwarding = false;
        end
	end

	return self
end
return FastForwardBattleIntro