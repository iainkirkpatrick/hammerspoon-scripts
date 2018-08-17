local constants = {
  mainScreen = "Color LCD",
  homeScreen = "U28D590",
  workScreenLeft = "2450W",
  workScreenRight = "LG FULL HD",

  workBrowser = "Google Chrome",
  homeBrowser = "Safari",
  editor = "Atom",
  music = "Spotify",
  terminal = "iTerm2",
  mail = "Mailspring",
  workChat = "Slack"
}

function justLaptop()
	screens = hs.screen.allScreens()
	count = 0
	for k,v in pairs(screens) do
		count = count + 1
	end
	if count == 1 then
		return true
	else
		return false
	end
end

function atHome()
	screens = hs.screen.allScreens()
	if screens[2]:name() == homeScreen then
		return true
	else
		return false
	end
end

return {
  constants = constants,
  justLaptop = justLaptop,
  atHome = atHome
}
