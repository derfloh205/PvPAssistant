---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.PVP_DATA
PvPAssistant.DB.PVP_DATA = {}

---@class PlayerPvPData
---@field ratings table<PvPAssistant.Const.PVPModes, number>
---@field shuffleSpecRatings table<number, number> specID -> rating

function PvPAssistant.DB.PVP_DATA:Init()
    PvPAssistant.DB.DEBUG:ClearAll()

    local libCBOR = LibStub("LibCBOR-1.0")

    local cborString = PvPAssistant.PVP_DATA
    local luaTable = libCBOR:Deserialize(cborString)

    print(tostring(luaTable))
    DevTool:AddData(luaTable, "DeserializedTable")
end

---@return PlayerPvPData? bracketData
function PvPAssistant.DB.PVP_DATA:GetByUnit(unit)
    if not unit then return nil end

    local unitName, unitRealm = UnitNameUnmodified(unit)
    unitRealm = unitRealm or GetNormalizedRealmName()
    unitRealm = PvPAssistant.UTIL:CamelCaseToDashSeparated(unitRealm) -- temporary adaption to pvp data format

    return self:Get(unitName, unitRealm)
end

---@param characterName string -- e.g. Slarky
---@param realmName string -- e.g. tarren-mill
---@param class? ClassFile
function PvPAssistant.DB.PVP_DATA:Get(characterName, realmName, class)
    local realmPlayers = PvPAssistant.PVP_DATA[realmName]
    if not realmPlayers then return end

    ---@diagnostic disable-next-line: undefined-field
    local playerPvPData = realmPlayers[characterName]

    if not playerPvPData then
        return
    end

    ---@type PlayerPvPData
    local playerPvPData = {
        ratings = {},
        shuffleSpecRatings = {},
    }

    --- 2v2,3v3,rbg,shuffle-1,shuffle-2,shuffle-3,shuffle-4
    for index, mode in ipairs(PvPAssistant.CONST.PVP_DATA_BRACKET_ORDER) do
        local rating = playerPvPData[index]
        if index < 4 then
            playerPvPData.ratings[mode] = rating
        elseif class then
            local unitClassID = select(3, class)
            local specIndex = (3 - index) * -1
            local specID = GetSpecializationInfoForClassID(unitClassID, specIndex)
            if specID then
                playerPvPData.shuffleSpecRatings[specID] = rating
            end
        end
    end

    return playerPvPData
end
