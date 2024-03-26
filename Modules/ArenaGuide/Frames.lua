---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()
local debug = PvPAssistant.DEBUG:GetDebugPrint()

---@class PvPAssistant.ArenaGuide
PvPAssistant.ARENA_GUIDE = PvPAssistant.ARENA_GUIDE

---@class PvPAssistant.ArenaGuide.Frames
PvPAssistant.ARENA_GUIDE.FRAMES = {}

local debug = false

function PvPAssistant.ARENA_GUIDE.FRAMES:Init()
    local sizeX = 320
    local sizeY = 445
    PvPAssistant.ARENA_GUIDE.frame = GGUI.Frame {
        parent = UIParent, anchorParent = UIParent,
        sizeX = sizeX, sizeY = sizeY,
        frameConfigTable = PvPAssistantGGUIConfig, frameID = PvPAssistant.CONST.FRAMES.ARENA_GUIDE,
        frameTable = PvPAssistant.MAIN.FRAMES,
        backdropOptions = PvPAssistant.CONST.ARENA_GUIDE_BACKDROP,
        moveable = true, hide = true,
    }

    local content = PvPAssistant.ARENA_GUIDE.frame.content

    content.logo = PvPAssistant.UTIL:CreateLogo(content,
        { { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetY = -10, } })

    content.title = GGUI.Text {
        parent = content, anchorPoints = { { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetY = -35, } },
        text = f.e("Arena Quick Guide"), scale = 1.3,
    }

    content.closeButton = GGUI.Button {
        parent = content, anchorParent = content, anchorA = "TOPRIGHT", anchorB = "TOPRIGHT",
        offsetX = -8, offsetY = -8,
        label = f.white("x"),
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
        fontOptions = {
            fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
        },
        sizeX = 15,
        sizeY = 15,
        clickCallback = function()
            PvPAssistant.ARENA_GUIDE.frame:Hide()
        end
    }

    -- icons

    --- TODO: Make a GGUI Util Function or even a Widget
    ---@param parent Frame
    ---@param anchorPoint GGUI.AnchorPoint
    ---@param numIcons number
    local function createClassIconRow(parent, anchorPoint, numIcons, iconSize, spacingX)
        local iconList = {}
        local lastAnchor
        for i = 1, numIcons do
            local offsetX = spacingX
            local offsetY = 0
            local anchorParent = lastAnchor
            local anchorB = "RIGHT"
            local anchorA = "LEFT"
            if i == 1 then
                offsetX = anchorPoint.offsetX
                offsetY = anchorPoint.offsetY
                anchorA = anchorPoint.anchorA
                anchorB = anchorPoint.anchorB
                anchorParent = anchorPoint.anchorParent
            end
            local classIcon = GGUI.ClassIcon {
                parent = parent, anchorParent = anchorParent,
                anchorA = anchorA, anchorB = anchorB, offsetX = offsetX, offsetY = offsetY, sizeX = iconSize, sizeY = iconSize,
                initialSpecID = PvPAssistant.CONST.SPEC_IDS.BEAST_MASTERY, showTooltip = true,
                showBorder = true,
            }
            lastAnchor = classIcon.frame

            classIcon:Hide()

            tinsert(iconList, classIcon)
        end
        return iconList
    end

    local offsetX_P2 = -100
    local offsetX_P3 = offsetX_P2 - 28
    local offsetX_E2 = 60
    local offsetX_E3 = offsetX_E2 - 12
    local offsetY = -70
    local spacingX = 10
    local iconSize = 30

    content.playerTeamIcons2 = createClassIconRow(content,
        { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetX = offsetX_P2, offsetY = offsetY }, 2,
        iconSize,
        spacingX)
    content.playerTeamIcons3 = createClassIconRow(content,
        { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetX = offsetX_P3, offsetY = offsetY }, 3,
        iconSize, spacingX)


    content.vsHeader = GGUI.Text {
        parent = content, anchorPoints = { { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetY = (offsetY - 7) / 1.5 } },
        text = f.r("VS"), scale = 1.5
    }
    content.enemyTeamIcons2 = createClassIconRow(content,
        { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetX = offsetX_E2, offsetY = offsetY }, 2,
        iconSize,
        spacingX)
    content.enemyTeamIcons3 = createClassIconRow(content,
        { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetX = offsetX_E3, offsetY = offsetY }, 3,
        iconSize, spacingX)

    content.strategyBackground = GGUI.Frame {
        parent = content, anchorParent = content, anchorA = "TOP", anchorB = "TOP", sizeX = sizeX - 10, sizeY = 130, offsetY = -105,
        backdropOptions = PvPAssistant.CONST.STRAGETY_TEXT_BACKDROP,
    }

    content.strategyBackground.frame:SetFrameLevel(content:GetFrameLevel() + 1)

    content.strategyText = GGUI.Text {
        parent = content.strategyBackground.frame, anchorPoints = { { anchorParent = content.strategyBackground.frame, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetX = 20, offsetY = -20 } },
        justifyOptions = { type = "H", align = "LEFT" }, fixedWidth = sizeX - 55,
        text = f.l("Here be Strategies"),
    }

    content.enemyAbilityList = GGUI.FrameList {
        columnOptions = {
            {
                -- specIcon
                width = 30,
                justifyOptions = { type = "H", align = "LEFT" },
            },
            {
                -- spell
                width = 120,
                justifyOptions = { type = "H", align = "LEFT" },
            },
            {
                -- type
                width = 120,
                justifyOptions = { type = "H", align = "CENTER" },
            },
        },
        rowConstructor = function(columns, row)
            local specColumn = columns[1]
            local spellColumn = columns[2]
            local typeColumn = columns[3]

            local classIconSize = 24
            local spellIconSize = 24

            specColumn.icon = GGUI.ClassIcon {
                parent = specColumn, anchorParent = specColumn, sizeX = classIconSize, sizeY = classIconSize,
                showTooltip = true
            }
            spellColumn.icon = GGUI.SpellIcon {
                parent = spellColumn, anchorParent = spellColumn, sizeX = spellIconSize, sizeY = spellIconSize, anchorA = "LEFT", anchorB = "LEFT",
                enableMouse = false,
            }
            spellColumn.spellName = GGUI.Text {
                parent = spellColumn, anchorParent = spellColumn.icon.frame, justifyOptions = { type = "H", align = "LEFT" }, text = "?",
                anchorA = "LEFT", anchorB = "RIGHT", offsetX = 3, wrap = true, fixedWidth = 150, scale = 0.9,
            }

            ---@type PvPAssistant.PVPSeverity
            row.spellSeverity = nil

            spellColumn.SetSpell = function(self, spellID, severity)
                spellColumn.icon:SetSpell(spellID)
                local spellname = select(1, GetSpellInfo(spellID))
                if severity and severity == PvPAssistant.CONST.PVP_SEVERITY.HIGH then
                    spellname = spellname .. f.r(" (!)")
                end
                spellColumn.spellName:SetText(spellname)
            end

            typeColumn.text = GGUI.Text {
                parent = typeColumn, anchorParent = typeColumn,
                text = "",
            }
        end,
        showBorder = true,
        parent = content,
        sizeY = 180,
        anchorPoints = { { anchorParent = content.strategyBackground.frame, anchorA = "TOP", anchorB = "BOTTOM", offsetY = -25, offsetX = -10, } },
        rowBackdrops = { PvPAssistant.CONST.TOOLTIP_FRAME_ROW_BACKDROP_A, {} },
        selectionOptions = { noSelectionColor = true, hoverRGBA = PvPAssistant.CONST.FRAME_LIST_HOVER_RGBA },
    }

    content.listHeader = GGUI.Text {
        parent = content, anchorPoints = { { anchorParent = content.enemyAbilityList.frame, anchorA = "BOTTOM", anchorB = "TOP", offsetY = 10, } },
        text = f.grey("Important Enemy Abilites"),
    }
end

function PvPAssistant.ARENA_GUIDE.FRAMES:UpdateDisplay()
    local content = PvPAssistant.ARENA_GUIDE.frame.content

    local arenaSpecIDs = PvPAssistant.DATA_COLLECTION:GetArenaSpecIDs()

    if debug then
        arenaSpecIDs = {
            PLAYER_TEAM = {
                PvPAssistant.CONST.SPEC_IDS.FURY,
                PvPAssistant.CONST.SPEC_IDS.RETRIBUTION,
                PvPAssistant.CONST.SPEC_IDS.ASSASSINATION
            },
            ENEMY_TEAM = {
                PvPAssistant.CONST.SPEC_IDS.HOLY_PALADIN,
                PvPAssistant.CONST.SPEC_IDS.BLOOD,
                PvPAssistant.CONST.SPEC_IDS.ASSASSINATION
            },
        }
    end

    local specIDsPlayerTeam = arenaSpecIDs.PLAYER_TEAM
    local specIDsEnemyTeam = arenaSpecIDs.ENEMY_TEAM

    table.foreach(content.playerTeamIcons2, function(_, icon) icon:Hide() end)
    table.foreach(content.playerTeamIcons3, function(_, icon) icon:Hide() end)
    table.foreach(content.enemyTeamIcons2, function(_, icon) icon:Hide() end)
    table.foreach(content.enemyTeamIcons3, function(_, icon) icon:Hide() end)

    local playerTeamIcons
    local enemyTeamIcons
    if #specIDsPlayerTeam <= 2 then
        playerTeamIcons = content.playerTeamIcons2
    else
        playerTeamIcons = content.playerTeamIcons3
    end
    if #specIDsEnemyTeam <= 2 then
        enemyTeamIcons = content.enemyTeamIcons2
    else
        enemyTeamIcons = content.enemyTeamIcons3
    end

    for i, icon in ipairs(playerTeamIcons) do
        local specID = specIDsPlayerTeam[i]
        if specID then
            icon:SetClass(specID)
            icon:Show()
        end
    end
    for i, icon in ipairs(enemyTeamIcons) do
        local specID = specIDsEnemyTeam[i]
        if specID then
            icon:SetClass(specID)
            icon:Show()
        end
    end

    -- fill strategyText
    local strategy = PvPAssistant.ARENA_STRATEGIES:Get(specIDsEnemyTeam) or
        f.white("No Quick Guide was submitted yet for this enemy composition")

    content.strategyText:SetText(strategy)


    -- fill enemy ability list
    local specAbilities = PvPAssistant.ABILITIES:GetAbilitiesForSpecs(specIDsEnemyTeam)
    local abilityList = content.enemyAbilityList --[[@as GGUI.FrameList]]
    abilityList:Remove()

    for specID, abilityDataList in pairs(specAbilities) do
        for _, abilityData in ipairs(abilityDataList) do
            abilityList:Add(function(row, columns)
                local specColumn = columns[1]
                local spellColumn = columns[2]
                local typeColumn = columns[3]

                specColumn.icon:SetClass(specID)
                spellColumn:SetSpell(abilityData.spellID, abilityData.severity)
                typeColumn.text:SetText(f.l(abilityData.subType))

                row.spellSeverity = abilityData.severity
                row.abilityType = abilityData.abilityType
                local specInfo = { GetSpecializationInfoByID(specID) }
                if specInfo[6] then
                    row.classID = specInfo[6]
                else
                    row.classID = specID
                end

                row.tooltipOptions = {
                    spellID = abilityData.spellID,
                    anchor = "ANCHOR_RIGHT",
                    owner = row.frame,
                }
            end)
        end
    end

    abilityList:UpdateDisplay(function(rowA, rowB)
        local typeARank = PvPAssistant.CONST.PVP_ABILITY_SORT_RANK[rowA.abilityType]
        local typeBRank = PvPAssistant.CONST.PVP_ABILITY_SORT_RANK[rowB.abilityType]
        local sevARank = PvPAssistant.CONST.PVP_SEVERITY_RANK[rowA.spellSeverity]
        local sevBRank = PvPAssistant.CONST.PVP_SEVERITY_RANK[rowB.spellSeverity]
        local classA = rowA.classID
        local classB = rowB.classID

        if classA > classB then
            return true
        elseif classA < classB then
            return false
        end

        if typeARank > typeBRank then
            return true
        elseif typeARank < typeBRank then
            return false
        end

        return sevARank > sevBRank
    end)
end
