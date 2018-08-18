hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

package.path = package.path .. ";../Development/iainkirkpatrick/hammerspoon-scripts/?.lua"
main = require "main"

main.windowManagement.start()
main.appArrangement.watch()
