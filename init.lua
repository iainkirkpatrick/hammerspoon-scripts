hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

package.path = package.path .. ";../Development/iainkirkpatrick/hammerspoon-scripts/?.lua"
package.path = package.path .. ";../Development/iainkirkpatrick/hammerspoon-scripts/window-management/?.lua"
main = require "main"

main.index.start()
