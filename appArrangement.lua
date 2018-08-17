--[[
CONST's for text editor, work browser, home browser
- if only one secondary screen to the left of main
  - put all work browser windows on left half of secondary
  - all editor windows on right half of secondary
  - slack / spotify / airmail on right half of main
  - safari on left half of main
  - iterm full on main
- if one secondary screen to the left of main, and one to the right of main (test that at work this isn't 2 above the main monitor)
  - put all work browser windows full on screen 2
    - maybe a work browser window with the name / url localhost:3000 on left half of screen 3 if possible?
  - all editor windows on right half of secondary
  - slack / spotify / airmail on right half of main
  - safari on left half of main
  - iterm full on main
--]]

local shared = require "shared"
local constants = shared.constants

singleArrangement = {
	{constants.workBrowser, nil, constants.mainScreen, hs.layout.left50, nil, nil},
	{constants.editor, nil, constants.mainScreen, hs.layout.right50, nil, nil}
}

secondaryArrangementHome = {
	{constants.workBrowser, nil, constants.homeScreen, hs.layout.left50, nil, nil},
	{constants.editor, nil, constants.homeScreen, hs.layout.right50, nil, nil}
}

secondaryArrangementWork = {
    {constants.workBrowser, nil, constants.workScreenLeft, hs.layout.maximized, nil, nil},
    {constants.editor, nil, constants.workScreenRight, hs.layout.right50, nil, nil}
}

function mainArrangement (location)
	return {
    	{constants.workChat, nil, constants.mainScreen, hs.layout.right50, nil, nil},
    	{constants.music, nil, constants.mainScreen, hs.layout.right50, nil, nil},
    	{constants.mail, nil, constants.mainScreen, hs.layout.right50, nil, nil},
    	{constants.homeBrowser, nil, constants.mainScreen, hs.layout.left50, nil, nil},
    	{constants.terminal, nil, constants.mainScreen, hs.layout.maximized, nil, nil}
    }
end

function rearrange ()
	arrangement = mainArrangement()
	if shared.justLaptop() == true then
		for k,v in pairs(singleArrangement) do
			table.insert(arrangement, v)
		end
	elseif shared.atHome() == true then
		for k,v in pairs(secondaryArrangementHome) do
			table.insert(arrangement, v)
		end
	else
		for k,v in pairs(secondaryArrangementWork) do
			table.insert(arrangement, v)
		end
	end

	hs.layout.apply(arrangement)
end

function watch ()
	watching = hs.screen.watcher.new(function()
		rearrange()
	end)
	watching:start()
end

-- TODO: more intelligent screen selection for main / secondary / third
--[[
function getScreenAndPosition()
	screens = hs.screen.screenPositions()
	for screen,positions in pairs(screens) do
		print(screen)
		for k,v in pairs(positions) do
			print(k,v)
		end
	end
end
--]]

return {
	watch = watch
}
