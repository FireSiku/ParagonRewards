max_line_length = false

exclude_files = {
	"libs",
    ".luacheckrc",
}

ignore = {
	"12.", -- ignore "Setting a read-only global variable/Setting a read-only field of a global variable."
	"43.", -- Shadowed upvalues happens often when writing scripts or trying to work with another module.
	"542", -- disable warnings for empty if branches. These are useful sometimes and easy to notice otherwise.
	"611", -- disable "line contains only whitespace"
    "211/L", -- Nice to declare even if a file isn't currently using localization.
    "21[23]", -- Disable unused loop/arguments warnings.
}

std = "+WoW"

-- Most of the FrameXML related globals
stds["WoW"] = {
	globals = {
		-- Lua Additions
		string = { fields = { "join", "rtgsub", "split", "trim", }},
		table = { fields = { "removemulti", "wipe", }},

		-- Localized Strings
		"CALLINGS_QUESTS", "MOUNT", "PET", "TOY", "ITEM_QUALITY7_DESC", "AZERITE_ESSENCE_ITEM_TYPE", "ADDON_MISSING", "REWARDS", "REPUTATION_PROGRESS_FORMAT",
		"RETRIEVING_ITEM_INFO", "FONT_COLOR_CODE_CLOSE", "HIGHLIGHT_FONT_COLOR_CODE", "ITEM_SPELL_KNOWN",

		-- Namespaces
		"C_PetJournal", "C_MountJournal", "C_Heirloom", "C_AzeriteEssence", "C_Reputation", "C_CurrencyInfo", "C_GossipInfo", "C_QuestLog",

		-- Global API
		"hooksecurefunc", "Mixin", "Item", "GameTooltip", "BreakUpLargeNumbers", "PlayerHasToy",
		"GetNumFactions", "GetFactionInfo", "IsFactionInactive", "UnitFactionGroup",
	}
}
