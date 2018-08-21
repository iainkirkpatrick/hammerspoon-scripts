local shared = require "shared"
local constants = shared.constants

function setGridForScreens ()
	-- might be some way to DRY this up with code in shared
	-- consider moving this setup config to the shared file, or a config file
	local screens = hs.screen.allScreens()
	for id,screen in pairs(screens) do
		if screen:name() == constants.mainScreen then
			hs.grid.setGrid('2x1', screen).setMargins(hs.geometry.size(0,0))
		elseif screen:name() == constants.homeScreen then
		  hs.grid.setGrid('3x2', screen).setMargins(hs.geometry.size(0,0))
		elseif screen:name() == constants.dansWorkScreen then
			hs.grid.setGrid('3x3', screen).setMargins(hs.geometry.size(0,0))
		end
	end
end

function listenForGridUpdates ()
	hs.urlevent.bind("setGrid", function (eventName, params)
		local activeScreen = hs.screen.mainScreen()
		hs.grid.setGrid(params["grid"], activeScreen).setMargins(hs.geometry.size(0,0))
		for i,win in pairs(hs.window.allWindows()) do
			if win:screen() == activeScreen then
				hs.grid.snap(win)
			end
		end
	end)
end

function bindWindowManagementHotkeys ()
	-- disable animation of windows when moving
  hs.window.animationDuration = 0

	hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
	  local win = hs.window.focusedWindow()
		hs.grid.pushWindowLeft(win)
	end)
	hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
	  local win = hs.window.focusedWindow()
		hs.grid.pushWindowRight(win)
	end)
	hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
	  local win = hs.window.focusedWindow()
		hs.grid.pushWindowUp(win)
	end)
	hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
	  local win = hs.window.focusedWindow()
		hs.grid.pushWindowDown(win)
	end)

	hs.hotkey.bind({"cmd", "ctrl"}, "Left", function()
		local win = hs.window.focusedWindow()
		local winCell = hs.grid.get(win)

		if winCell.x == 0 then
			hs.grid.resizeWindowThinner(win)
		else
			hs.grid.resizeWindowWider(win)
		end
	end)

	hs.hotkey.bind({"cmd", "ctrl"}, "Right", function()
		local win = hs.window.focusedWindow()
		local screen = win:screen()
		local winCell = hs.grid.get(win)
		local screenGridWidth = hs.grid.getGrid(screen).w
		local isLeftEdge = (winCell.x + winCell.w) == (screenGridWidth)

		if isLeftEdge then
			hs.grid.adjustWindow(function(f) f.x = math.min(f.x + 1, screenGridWidth); f.w = math.max(f.w - 1, 1) end, win)
		else
			hs.grid.resizeWindowWider(win)
		end
	end)

	hs.hotkey.bind({"cmd", "ctrl"}, "Up", function()
	  local win = hs.window.focusedWindow()
		local winCell = hs.grid.get(win)

		if winCell.y == 0 then
			hs.grid.resizeWindowShorter(win)
		else
			hs.grid.resizeWindowTaller(win)
		end
	end)

	hs.hotkey.bind({"cmd", "ctrl"}, "Down", function()
		local win = hs.window.focusedWindow()
		local screen = win:screen()
		local winCell = hs.grid.get(win)
		local screenGridHeight = hs.grid.getGrid(screen).h
		local isBottomEdge = (winCell.y + winCell.h) == (screenGridHeight)

		if isBottomEdge then
			hs.grid.adjustWindow(function(f) f.y = math.min(f.y + 1, screenGridHeight); f.h = math.max(f.h - 1, 1) end, win)
		else
			hs.grid.resizeWindowTaller(win)
		end
	end)
end

function start ()
	setGridForScreens()
	listenForGridUpdates()
	bindWindowManagementHotkeys()
end

return {
	start = start
}
