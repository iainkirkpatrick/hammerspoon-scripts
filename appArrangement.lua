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

local appArrangement = {}

-- constants
mainScreen = "Color LCD"
homeScreen = "U28D590"

workBrowser = "Google Chrome"
homeBrowser = "Safari"
editor = "Atom"
terminal = "Iterm2"
mail = "Airmail"

secondaryArrangementHome = {
	{workBrowser, nil, homeScreen, hs.layout.left50, nil, nil},
	{editor, nil, homeScreen, hs.layout.right50, nil, nil}
}
-- TODO: fix for work
-- secondaryArrangementWork = {
--   {"Google Chrome", nil, "U28D590", hs.layout.left50, nil, nil},
--   {"Atom", nil, "U28D590", hs.layout.right50, nil, nil}
-- }

function atHome()
	screens = hs.screen.allScreens()
	if screens[2]:name() == homeScreen then
		return true
	else
		return false
	end
end

function mainArrangement (location)
	return {
    	{"Slack", nil, mainScreen, hs.layout.right50, nil, nil},
    	{"Spotify", nil, mainScreen, hs.layout.right50, nil, nil},
    	{mail, nil, mainScreen, hs.layout.right50, nil, nil},
    	{homeBrowser, nil, mainScreen, hs.layout.left50, nil, nil},
    	{terminal, nil, mainScreen, hs.layout.maximized, nil, nil}
    }
end

function rearrange ()
	arrangement = mainArrangement()
	if atHome() == true then
		for k,v in pairs(secondaryArrangementHome) do
			table.insert(arrangement, v)
		end
	end

	hs.layout.apply(arrangement)
end

function appArrangement.watch ()
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

return appArrangement