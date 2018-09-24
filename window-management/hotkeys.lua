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

return {
	bindWindowManagementHotkeys = bindWindowManagementHotkeys
}
