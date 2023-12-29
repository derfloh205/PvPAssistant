---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookup.Const
PvPLookup.CONST = {}

---@enum PvPLookup.Const.Frames
PvPLookup.CONST.FRAMES = {
    HISTORY_FRAME = "HISTORY_FRAME",
    NEWS = "NEWS",
}

---@enum PvPLookup.Const.PVPModes
PvPLookup.CONST.PVP_MODES = {
    SOLO = "SOLO",
    TWOS = "TWOS",
    THREES = "THREES",
    RGB = "RGB",
}
---@type GGUI.BackdropOptions
PvPLookup.CONST.HISTORY_BACKDROP = {
    borderOptions = {
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32,
        insets = { left = 5, right = 5, top = 5, bottom = 5 },
        colorR = 1,
        colorG = 1,
        colorB = 1,
        colorA = 1,
    },
    bgFile = "Interface\\Buttons\\WHITE8X8",
    tile = true,
    tileSize = 32,
    colorR = 0,
    colorG = 0,
    colorB = 0,
    colorA = 0.5,
}
---@type GGUI.BackdropOptions
PvPLookup.CONST.HISTORY_LIST_EDGE_BACKDROP = {
    borderOptions = {
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32,
        insets = { left = 5, right = 5, top = 5, bottom = 5 },
        colorR = 1,
        colorG = 1,
        colorB = 1,
        colorA = 1,
    },
}
---@type GGUI.BackdropOptions
PvPLookup.CONST.HISTORY_TITLE_BACKDROP = {
    borderOptions = {
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32,
        insets = { left = 5, right = 5, top = 5, bottom = 5 },
        colorR = 1,
        colorG = 1,
        colorB = 1,
        colorA = 1,
    },
    bgFile = "Interface\\Buttons\\WHITE8X8",
    tile = true,
    tileSize = 32,
    colorR = 0,
    colorG = 0,
    colorB = 0,
    colorA = 0.8,
}
---@type GGUI.BackdropOptions
PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    colorR = 0.149,
    colorG = 0.149,
    colorB = 0.149,
    colorA = 1,
}
PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    colorR = 0.098,
    colorG = 0.098,
    colorB = 0.098,
    colorA = 1,
}

PvPLookup.CONST.SPEC_ICONS = {
    
}