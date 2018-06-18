local L = AceLibrary("AceLocale-2.2"):new("Looter")

Looter = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceHook-2.1", "AceModuleCore-2.0")-- Shhhhh

Looter.revision  = tonumber((string.gsub("$Revision: 1 $", "^%$Revision: (%d+) %$$", "%1")))

Looter:SetModuleMixins("AceEvent-2.0", "AceConsole-2.0", "AceHook-2.1")
Looter.dewdrop = AceLibrary("Dewdrop-2.0")

local AutoLootItemList = {
	[774] = true, -- Malachite
	[818] = true, -- Tigerseye
	[1210] = true, -- Shadowgem
	[1206] = true, -- Moss Agate
	[1705] = true, -- Lesser Moonstone
	[1529] = true, -- Jade
	[3864] = true, -- Citrine
	[7909] = true, -- Aquamarine
	[7910] = true, -- Star Ruby
	[12361] = true, -- Blue Sapphire
	[12799] = true, -- Large Opal
	[12364] = true, -- Huge emerald
	[12800] = true, -- Azerothian diamond
	[23079] = true, -- Deep Peridot
	[21929] = true, -- Flame Spessarite
	[23112] = true, -- Golden Draenite
	[23107] = true, -- Shadow Draenite
	[23117] = true, -- Azure Moonstone
	[23077] = true, -- Blood Garnet
	[23436] = true, -- Living Ruby
	[23441] = true, -- Nightseye
	[23440] = true, -- Dawnstone
	[23437] = true, -- Talasite
	[23439] = true, -- Noble Topaz
	[23438] = true, -- Star of Elune
	[24186] = true, -- Copper Powder
	[24188] = true, -- Tin Powder
	[24190] = true, -- Iron Powder
	[24234] = true, -- Mithril Powder
	[24235] = true, -- Thorium Powder
	[24242] = true, -- Fel Iron Powder
	[24243] = true, -- Adamantite Powder

	[10938] = true, --Lesser Magic Essence
	[10939] = true, --Greater Magic Essence
	[10998] = true, --Lesser Astral Essence
	[11082] = true, --Greater Astral Essence
	[11134] = true, --Lesser Mystic Essence
	[11135] = true, --Greater Mystic Essence
	[11174] = true, --Lesser Nether Essence
	[11175] = true, --Greater Nether Essence
	[16202] = true, --Lesser Eternal Essence
	[16203] = true, --Greater Eternal Essence
	[22447] = true, --Lesser Planar Essence
	[22446] = true, --Greater Planar Essence
	[10940] = true, --Strange Dust
	[11083] = true, --Soul Dust
	[11137] = true, --Vision Dust
	[11176] = true, --Dream Dust
	[16204] = true, --Illusion Dust
	[22445] = true, --Arcane Dust
	[10978] = true, --Small Glimmering Shard
	[11084] = true, --Large Glimmering Shard
	[11138] = true, --Small Glowing Shard
	[11139] = true, --Large Glowing Shard
	[11177] = true, --Small Radiant Shard
	[11178] = true, --Large Radiant Shard
	[14343] = true, --Small Brilliant Shard
	[14344] = true, --Large Brilliant Shard
	[22448] = true, --Small Prismatic Shard
	[22449] = true, --Large Prismatic Shard
	[20725] = true, --Nexus Crystal
	[22450] = true --Void Crystal

}

function Looter:OnEnable()
	self:RegisterEvent("LOOT_OPENED", "OnOpen")
end

function Looter:OnOpen()
	Looter:Print("Loot opened"); 
	for slotnum = 1, GetNumLootItems() do
		local isItem = LootSlotIsItem(slotnum)
		local isCoin = LootSlotIsCoin(slotnum)
		Looter:Print("Slot " .. tostring(slotnum) .. ": isItem=" .. tostring(isItem) .. " isCoin=" .. tostring(isCoin))

		local texture, item, quantity, quality
		texture, item, quantity, quality = GetLootSlotInfo(slotnum)
		
		local link = GetLootSlotLink(slotnum)
		local _, _
		itemID = nil
		if(link) then
			_, _, itemID = string.find(link, "item:(%d+)")
		elseif(isCoin) then
			link = "Gold"
			itemID = "Gold"
		end
		if(link) then
			if(isCoin) then Looter:Print("Slot " .. tostring(slotnum) .. ": " .. " Gold ") end
			if(isItem) then Looter:Print("Slot " .. tostring(slotnum) .. ": " .. link .. " => " .. "[" .. itemID .. "] of quality " .. quality .. " x " .. quantity ) end

			if (isCoin) then 
				Looter:Print("Looting Slot " .. tostring(slotnum) .. " containing " .. link)
				LootSlot(slotnum)
				ConfirmLootSlot(slotnum)
			end
		end
	end
end