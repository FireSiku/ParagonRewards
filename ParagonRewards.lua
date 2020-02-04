--local addonname, ns = ...

-- Reward Types
local MOUNT = MOUNT
local PET = PET
local TOY = TOY
local HEIRLOOM = ITEM_QUALITY7_DESC
local ESSENCE = AZERITE_ESSENCE_ITEM_TYPE
-- --local RECIPE = TRANSMOG_SOURCE_6

-- Others
local RETRIEVING_ITEM_INFO = RETRIEVING_ITEM_INFO
local MISSING = ADDON_MISSING
local KNOWN = ITEM_SPELL_KNOWN
local REWARDS = REWARDS

local MEDALS_ID = {Alliance = 1717, Horde = 1716}

local function Known() return format('(|cFF00FF00%s|r)', KNOWN) end
local function Missing() return format('(|cFFFF0000%s|r)', MISSING) end

-------------------------------------------------------------------------------
----------------------------------- Mixin -------------------------------------
-------------------------------------------------------------------------------
local RewardMixin = {}

function RewardMixin:IsCollected()
    if self.rewardType == MOUNT then
        return select(11, C_MountJournal.GetMountInfoByID(self.id))
        
    elseif self.rewardType == PET then
        return C_PetJournal.GetNumCollectedInfo(self.id) > 0
        
    elseif self.rewardType == TOY then
        return PlayerHasToy(self.item)
        
    elseif self.rewardType == HEIRLOOM then
        return C_Heirloom.PlayerHasHeirloom(self.item)
        
    elseif self.rewardType == ESSENCE then
        local info = C_AzeriteEssence.GetEssenceInfo(self.id)
        return info and info.rank == 4
        
    end
end

function RewardMixin:IsUsable()
    if self.rewardType == ESSENCE then
        local info = C_AzeriteEssence.GetEssenceInfo(self.id)
        return type(info) == "table"
        -- --elseif self.rewardType == RECIPE then
    end
    return true
end

function RewardMixin:GetRewardText()
    if self.cost then
        return format("%s (%s, %d)", self.itemLink, self.rewardType, self.cost)
    end
    return format("%s (%s)", self.itemLink, self.rewardType)
end

function RewardMixin:Render(tooltip)
    if self:IsUsable() then
        local collected = self:IsCollected()
        local status = collected and Known() or Missing()
        tooltip:AddDoubleLine(self:GetRewardText(), status)
        tooltip:AddTexture(self.itemIcon, {margin={left=10, top=2, right=2}})
    end
end

local function AddReward(rtype, data)
    data.rewardType = rtype
    data.itemLink = RETRIEVING_ITEM_INFO
    data.itemIcon = 'Interface\\Icons\\Inv_misc_questionmark'
    local item = Item:CreateFromItemID(data.item)
    item:ContinueOnItemLoad(function()
        data.itemLink = item:GetItemLink()
        data.itemIcon = item:GetItemIcon()
    end)
    return Mixin(data, RewardMixin)
end

-------------------------------------------------------------------------------
---------------------------------- REWARDS ------------------------------------
-------------------------------------------------------------------------------
--To gather ID from mounts and Pets:
--/run local p = "NAME"; for i,m in ipairs(C_MountJournal.GetMountIDs()) do if (C_MountJournal.GetMountInfoByID(m) == p) then print(m,"=",p); end end
--/run local p = "NAME"; print(C_PetJournal.FindPetIDByName(p),"=",p)

local RewardList = {
    -- Alliance
    [2160] = {
        -- Proudmoore Admiralty
        AddReward(TOY, {item = 166702}),
        AddReward(PET, {item = 166714, id = 2566}),
    },
    [2161] = {
        -- Order of Embers
        AddReward(TOY, {item = 166808}),
        AddReward(PET, {item = 166718, id = 2568}),
    },
    [2162] = {
        -- Storm's Wake
        AddReward(PET, {item = 166719, id = 2569}),
    },
    [2159] = {
        -- 7th Legion
        AddReward(TOY, {item = 166879}),
        -- AddReward(RECIPE, {item = 166279}),
    },
    [2400] = {
        -- Waveblade Ankoan
        AddReward(TOY, {item = 170203}),
        AddReward(TOY, {item = 170469}),
        -- AddReward(RECIPE, {item = 170169}),
        AddReward(MOUNT, {item = 169198, id = 1237}),
        AddReward(ESSENCE, {item = 168866, id = 28}),
        AddReward(ESSENCE, {item = 168931, id = 17}),
        AddReward(ESSENCE, {item = 168840, id = 25}),
    },
    
    -- Horde
    [2103] = {
        -- -Zandalari Empire
        AddReward(TOY, {item = 166701}),
    },
    [2156] = {
        -- Talanji's Expedition
        AddReward(TOY, {item = 166308}),
        AddReward(PET, {item = 166716, id = 2567}),
    },
    [2158] = {
        -- Voldunai
        AddReward(TOY, {item = 166703}),
        AddReward(TOY, {item = 165021}),
        AddReward(TOY, {item = 166880}),
    },
    [2157] = {
        -- Honorbound
        AddReward(TOY, {item = 166879}),
        -- AddReward(RECIPE, {item = 166311}),
    },
    [2373] = {
        -- The Unshackled
        AddReward(TOY, {item = 170203}),
        AddReward(TOY, {item = 170469}),
        -- AddReward(RECIPE, {item = 170169}),
        AddReward(MOUNT, {item = 169198, id = 1237}),
        AddReward(ESSENCE, {item = 168866, id = 28}),
        AddReward(ESSENCE, {item = 168931, id = 17}),
        AddReward(ESSENCE, {item = 168840, id = 25}),
    },
    
    -- Neutral
    [2163] = {
        -- Tortollan Seekers
        AddReward(TOY, {item = 166704}),
        -- AddReward(RECIPE, {item = 166264}),
    },
    [2164] = {
        -- Champions of Azeroth
        AddReward(TOY, {item = 166877}),
    },
    [2391] = {
        -- Rustbolt Resistance
        AddReward(ESSENCE, {item = 168861, id = 6}),
        AddReward(ESSENCE, {item = 168935, id = 19}),
        AddReward(ESSENCE, {item = 168569, id = 13}),
    },
    [2417] = {
        -- Uldum Accord
        AddReward(PET, {item = 174481, id = 2850}),
    },
    [2415] = {
        -- Rajani
        AddReward(PET, {item = 174479, id = 2852}),
    },
    
    -- Legion Paragons
    [1900] = {
        -- Court of Farondis
        AddReward(MOUNT, {item = 147806, id = 943}),
    },
    [1828] = {
        -- Highmountain Tribe
        AddReward(MOUNT, {item = 147807, id = 941}),
    },
    [1883] = {
        -- Dreamweavers
        AddReward(MOUNT, {item = 147804, id = 942}),
    },
    [1948] = {
        -- Valarjar
        AddReward(MOUNT, {item = 147805, id = 944}),
    },
    [1859] = {
        -- The Nightfallen
        AddReward(MOUNT, {item = 143764, id = 905}),
    },
    [1894] = {
        -- The Wardens
        AddReward(TOY, {item = 147843}),
    },
    [2045] = {
        -- Armies of Legionfall
        AddReward(PET, {item = 147841, id = 2050}),
    },
    [2165] = {
        -- Army of the Light
        AddReward(TOY, {item = 153182}),
        AddReward(MOUNT, {item = 153044, id = 985}),
        AddReward(MOUNT, {item = 153043, id = 984}),
        AddReward(MOUNT, {item = 153042, id = 983}),
    },
}

local ServiceMedals = {
    ["Alliance"] = {
        AddReward(HEIRLOOM, {item = 166770, cost = 75}),
        AddReward(HEIRLOOM, {item = 166766, cost = 75}),
        AddReward(HEIRLOOM, {item = 166767, cost = 75}),
        AddReward(HEIRLOOM, {item = 166768, cost = 75}),
        AddReward(HEIRLOOM, {item = 166769, cost = 75}),
        AddReward(PET, {item = 166346, id = 2539, cost = 100}),
        AddReward(TOY, {item = 166744, cost = 125}),
        AddReward(MOUNT, {item = 166465, id = 1214, cost = 300}),
        AddReward(MOUNT, {item = 166463, id = 1216, cost = 750}),
        AddReward(MOUNT, {item = 166436, id = 1204, cost = 350}),
    },
    ["Horde"] = {
        AddReward(HEIRLOOM, {item = 166752, cost = 75}),
        AddReward(HEIRLOOM, {item = 166756, cost = 75}),
        AddReward(HEIRLOOM, {item = 166755, cost = 75}),
        AddReward(HEIRLOOM, {item = 166754, cost = 75}),
        AddReward(HEIRLOOM, {item = 166753, cost = 75}),
        AddReward(PET, {item = 166347, id = 2540, cost = 100}),
        AddReward(TOY, {item = 166743, cost = 125}),
        AddReward(MOUNT, {item = 166464, id = 1215, cost = 300}),
        AddReward(MOUNT, {item = 166469, id = 1210, cost = 750}),
        AddReward(MOUNT, {item = 166436, id = 1204, cost = 350}),
    },
}

-------------------------------------------------------------------------------
--------------------------------- REPUTATION ----------------------------------
-------------------------------------------------------------------------------
local function GetParagonBarValues(factionID)
    local currentValue, rewardThreshold, _,  rewardPending = C_Reputation.GetFactionParagonInfo(factionID)
    currentValue = (currentValue - rewardThreshold) % rewardThreshold
    
    if rewardPending then
        return currentValue + rewardThreshold, rewardThreshold
    else
        return currentValue, rewardThreshold
    end
end

local function UpdateParagonBars()
    local numFactions = GetNumFactions()
    local factionOffset = FauxScrollFrame_GetOffset(ReputationListScrollFrame)
    for i=1, NUM_FACTIONS_DISPLAYED, 1 do
        local factionIndex = factionOffset + i;
        local factionRow = _G["ReputationBar"..i];
        local factionBar = _G["ReputationBar"..i.."ReputationBar"];
        local factionStanding = _G["ReputationBar"..i.."ReputationBarFactionStanding"];
        if ( factionIndex <= numFactions ) then
            local _, _, _, _, _, _, _, _, _, _, _, _, _, factionID = GetFactionInfo(factionIndex);
            if ( factionID and C_Reputation.IsFactionParagon(factionID) and not IsFactionInactive(factionIndex) ) then
                local barValue, barMax = GetParagonBarValues(factionID)
                factionBar:SetMinMaxValues(0, barMax)
                factionBar:SetValue(barValue)
                factionRow.standingText = "Paragon"
                factionStanding:SetText("Paragon")
                local progressFormat = format(REPUTATION_PROGRESS_FORMAT, BreakUpLargeNumbers(barValue), BreakUpLargeNumbers(barMax))
                factionRow.rolloverText = HIGHLIGHT_FONT_COLOR_CODE.." "..progressFormat..FONT_COLOR_CODE_CLOSE
            end
        end
    end
end

local function DisplayServiceMedalsRewards()
    local faction = UnitFactionGroup("player")
    local rewards = ServiceMedals[faction]
    EmbeddedItemTooltip:AddLine(" ")
    EmbeddedItemTooltip:AddLine(format("%s %s", GetCurrencyInfo(MEDALS_ID[faction]), REWARDS))
    for i = 1, #rewards do
        rewards[i]:Render(EmbeddedItemTooltip)
    end
end

local function UpdateParagonRewards(frame)
    local rewards = RewardList[frame.factionID]
    if rewards and #rewards > 0 then
        for i = 1, #rewards do
            rewards[i]:Render(EmbeddedItemTooltip)
        end
        
        if frame.factionID == 2159 or frame.factionID == 2157 then
            DisplayServiceMedalsRewards()
        end
        
        EmbeddedItemTooltip:AddLine(" ")
        EmbeddedItemTooltip:Show()
    end
end

hooksecurefunc("ReputationFrame_Update", UpdateParagonBars)
hooksecurefunc("ReputationParagonFrame_SetupParagonTooltip", UpdateParagonRewards)