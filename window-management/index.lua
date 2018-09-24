local grid = require "grid"
local hotkeys = require "hotkeys"

function start ()
  hotkeys.bindWindowManagementHotkeys()
  grid.listenForGridUpdates()
  grid.listenForArrangeApps()
  grid.watch()
end

return {
  start = start
}
