local constants = require "constants"

local defaultGridBreakpoints = {
  widths = {
    ['0'] = 2,
    ['1920'] = 2,
    ['3840'] = 3,
    ['5120'] = 3
  },
  heights = {
    ['0'] = 1,
    ['1200'] = 2,
    ['2160'] = 2,
    ['2880'] = 3
  }
}
local orderedWidths = {'0', '1920', '3840', '5120'}
local orderedHeights = {'0', '1200', '2160', '2880'}

-- https://stackoverflow.com/questions/2705793/how-to-get-number-of-entries-in-a-lua-table
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function getGridsForScreens (screens)
	local grids = {}
	for id,screen in pairs(screens) do
		table.insert(grids, hs.grid.getGrid(screen))
	end
	return grids
end

function arrangeApps (screens)
  local arrangement = {}
  local numScreens = tablelength(screens)
  local grids = getGridsForScreens(screens)
  local notificationText = ''

  -- only includes arrangements i'm accounting for, add more if necessary
  -- trying unit rects for arguments for now, which avoids some logic getting the position of the grid cells
  if numScreens == 1 then
    if grids[1].w == 2 and grids[1].h == 2 then
      table.insert(arrangement, { constants.programs.workBrowser, nil, screens[1], constants.positions.leftHalf, nil, nil })
      table.insert(arrangement, { constants.programs.workBrowser2, nil, screens[1], constants.positions.leftHalf, nil, nil })
      table.insert(arrangement, { constants.programs.homeBrowser, nil, screens[1], constants.positions.fullScreen, nil, nil })
      table.insert(arrangement, { constants.programs.editor, nil, screens[1], constants.positions.rightHalf, nil, nil })
      table.insert(arrangement, { constants.programs.music, nil, screens[1], constants.positions.rightHalf, nil, nil })
      table.insert(arrangement, { constants.programs.terminal, nil, screens[1], constants.positions.rightHalf, nil, nil })
      table.insert(arrangement, { constants.programs.mail, nil, screens[1], constants.positions.fullScreen, nil, nil })
      table.insert(arrangement, { constants.programs.workChat, nil, screens[1], constants.positions.rightHalf, nil, nil })
    elseif grids[1].w == 3 and grids[1].h == 3 then
      table.insert(arrangement, { constants.programs.workBrowser, nil, screens[1], constants.positions.leftThirdColumn, nil, nil })
      table.insert(arrangement, { constants.programs.workBrowser2, nil, screens[1], constants.positions.leftThirdColumn, nil, nil })
      table.insert(arrangement, { constants.programs.homeBrowser, nil, screens[1], constants.positions.middleThirdColumn, nil, nil })
      table.insert(arrangement, { constants.programs.editor, nil, screens[1], constants.positions.rightThirdColumnTwoThirdsHeight, nil, nil })
      table.insert(arrangement, { constants.programs.music, nil, screens[1], constants.positions.rightThirdColumnTwoThirdsHeight, nil, nil })
      table.insert(arrangement, { constants.programs.terminal, nil, screens[1], constants.positions.rightThirdColumnOneThirdHeightBottom, nil, nil })
      table.insert(arrangement, { constants.programs.mail, nil, screens[1], constants.positions.rightThirdColumnTwoThirdsHeight, nil, nil })
      table.insert(arrangement, { constants.programs.workChat, nil, screens[1], constants.positions.rightThirdColumnTwoThirdsHeight, nil, nil })
    end
    notificationText = screens[1]:name() .. ': ' .. grids[1].w .. 'x' .. grids[1].h
  elseif numScreens == 2 then
    if grids[1].w == 3 and grids[1].h == 2 and grids[2].w == 2 and grids[2].h == 2 then
      table.insert(arrangement, { constants.programs.workBrowser, nil, screens[1], constants.positions.leftThirdColumn, nil, nil })
      table.insert(arrangement, { constants.programs.workBrowser2, nil, screens[1], constants.positions.leftThirdColumn, nil, nil })
      table.insert(arrangement, { constants.programs.homeBrowser, nil, screens[2], constants.positions.fullScreen, nil, nil })
      table.insert(arrangement, { constants.programs.editor, nil, screens[1], constants.positions.rightThirdColumn, nil, nil })
      table.insert(arrangement, { constants.programs.music, nil, screens[2], constants.positions.rightHalf, nil, nil })
      table.insert(arrangement, { constants.programs.terminal, nil, screens[2], constants.positions.fullScreen, nil, nil })
      table.insert(arrangement, { constants.programs.mail, nil, screens[2], constants.positions.fullScreen, nil, nil })
      table.insert(arrangement, { constants.programs.workChat, nil, screens[2], constants.positions.rightHalf, nil, nil })
    end
    notificationText = screens[1]:name() .. '1: ' .. grids[1].w .. 'x' .. grids[1].h .. ', ' .. screens[2]:name() .. '2: ' .. grids[2].w .. 'x' .. grids[2].h
  elseif numScreens == 3 then
    if grids[1].w == 2 and grids[1].h == 2 and grids[2].w == 2 and grids[2].h == 2 and grids[3].w == 2 and grids[3].h == 2 then
      table.insert(arrangement, { constants.programs.workBrowser, nil, screens[2], constants.positions.leftHalf, nil, nil })
      table.insert(arrangement, { constants.programs.workBrowser2, nil, screens[2], constants.positions.leftHalf, nil, nil })
      table.insert(arrangement, { constants.programs.homeBrowser, nil, screens[1], constants.positions.fullScreen, nil, nil })
      table.insert(arrangement, { constants.programs.editor, nil, screens[2], constants.positions.rightHalf, nil, nil })
      table.insert(arrangement, { constants.programs.music, nil, screens[1], constants.positions.rightHalf, nil, nil })
      table.insert(arrangement, { constants.programs.terminal, nil, screens[1], constants.positions.fullScreen, nil, nil })
      table.insert(arrangement, { constants.programs.mail, nil, screens[1], constants.positions.fullScreen, nil, nil })
      table.insert(arrangement, { constants.programs.workChat, nil, screens[1], constants.positions.rightHalf, nil, nil })
    end
    notificationText = screens[1]:name() .. '1: ' .. grids[1].w .. 'x' .. grids[1].h .. ', ' .. screens[2]:name() .. '2: ' .. grids[2].w .. 'x' .. grids[2].h .. ', ' .. screens[3]:name() .. '3: ' .. grids[3].w .. 'x' .. grids[3].h
  end

  hs.layout.apply(arrangement)
	hs.notify.show('Window layout updated', '', notificationText)
end

function setDefaultGrid (screen)
	-- doesn't look like there's a nice way to get table lengths in Lua, otherwise would default these to the largest values in widths / heights
	local screenRows = 3
	local screenColumns = 3

  -- these could be refactored possibly? lua-fu not good enough to battle with preventing extra looping
	for _,width in ipairs(orderedWidths) do
		if screen:currentMode()['w'] >= tonumber(width) then
			screenColumns = defaultGridBreakpoints.widths[width]
		end
	end
	for _,height in ipairs(orderedHeights) do
		if screen:currentMode()['h'] >= tonumber(height) then
			screenRows = defaultGridBreakpoints.heights[height]
		end
	end

  local gridString = screenColumns .. "x" .. screenRows
  hs.grid.setGrid(gridString, screen).setMargins(hs.geometry.size(0,0))
  hs.notify.show('Screen grid set', '', screen:name() .. ': ' .. gridString)
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
    hs.notify.show('Screen grid updated', '', activeScreen:name() .. ': ' .. params['grid'])
	end)
end

function listenForArrangeApps ()
	hs.urlevent.bind("arrangeApps", function (eventName, params)
		local screens = hs.screen.allScreens()
		arrangeApps(screens)
	end)
end


-- function compareScreens (old, new)
-- 	for id,screen in pairs(old) do
-- 		local match = false
-- 		for idNew,screenNew in pairs(new) do
-- 			if screen:name() == screenNew:name() then
-- 				match = true
-- 				break
-- 			end
-- 		end
-- 		if match == false then
-- 			return false
-- 		end
-- 	end
-- 	return true
-- end

-- function compareScreens (old, new)
--   for id,screen in pairs(new) do
--     for idOld,screenOld in pairs(old) do
--
--     end
--   end
-- end

function watch ()
	local initialScreens = hs.screen.allScreens()
  for id,screen in pairs(initialScreens) do
    setDefaultGrid(screen)
  end
  arrangeApps(initialScreens)
	watching = hs.screen.watcher.new(function()
		-- local isSameScreens = compareScreens(initialScreens, hs.screen.allScreens())
		-- if not isSameScreens then
		-- 	rearrange()
		-- end
    arrangeApps(initialScreens)
	end)
	watching:start()
end

return {
  setDefaultGrid = setDefaultGrid,
	listenForGridUpdates = listenForGridUpdates,
  listenForArrangeApps = listenForArrangeApps,
  watch = watch
}
