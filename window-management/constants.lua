local screens = {
  mainScreen = "Color LCD",
  homeScreen = "U28D590",
  workScreenLeft = "2450W",
  workScreenRight = "LG FULL HD",
  dansWorkScreen = "PHL BDM4065"
}

local programs = {
  workBrowser = "Firefox Developer Edition",
  homeBrowser = "Safari",
  editor = "Atom",
  music = "Spotify",
  terminal = "iTerm2",
  mail = "Mailspring",
  workChat = "Slack"
}

local positions = {
  fullScreen = hs.geometry.rect(0, 0, 1, 1),
  leftHalf = hs.geometry.rect(0, 0, 0.5, 1),
  rightHalf = hs.geometry.rect(0.5, 0, 0.5, 1),
  leftThirdColumn = hs.geometry.rect(0, 0, 0.3333, 1),
  rightThirdColumn = hs.geometry.rect(0.6666, 0, 0.3333, 1),
  middleThirdColumn = hs.geometry.rect(0.3333, 0, 0.3333, 1),
  rightThirdColumnTwoThirdsHeight = hs.geometry.rect(0.6666, 0, 0.3333, 0.6666),
  rightThirdColumnOneThirdHeightBottom = hs.geometry.rect(0.6666, 0.6666, 0.3333, 0.3333)
}

return {
  screens = screens,
  programs = programs,
  positions = positions
}
