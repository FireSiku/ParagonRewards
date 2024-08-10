---@enum ReputationTypeEnum
local ReputationType = {
	Standard = 1,
	Friendship = 2,
	MajorFaction = 3,
};

---@class ReputationEntryMixin
---@field TryInitParagonDisplay function
---@field elementData ReputationEntryMixinElementData
---@field factionID number
---@field factionIndex number
---@field reputationType ReputationTypeEnum
---@field Content ReputationEntryMixinContent

---@class ReputationEntryMixinContent
---@field ReputationBar ReputationEntryMixinBar
---@field Name FontString

---@class ReputationEntryMixinBar : StatusBar
---@field barProgressText string # ie: "6320 / 9500"
---@field reputationStandingText string # ie: Exalted
---@field BarText FontString

---@class ReputationEntryMixinElementData
---@field hasBonusRepGain boolean
---@field atWarWith boolean
---@field isHeaderWithRep boolean
---@field isHeader boolean
---@field description string
---@field currentReactionThreshold number # Reputation "Min" value
---@field canSetInactive boolean
---@field isWatched boolean
---@field isCollapsed boolean
---@field canToggleAtWar boolean
---@field nextReactionThreshold number # Reputation "Max" value
---@field currentStanding number # Reputation "Current" value
---@field factionIndex number
---@field factionID number
---@field name string
---@field isAccountWide boolean
---@field isChild boolean
---@field reaction number
