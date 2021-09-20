local TOCNAME,EC=...

local function langSplit(source)
	local ret={}
	for lang,pat in pairs(source) do
			ret[lang]=EC.Tool.Split(pat:lower(),",")
	end
	return ret
end

EC.PrefixTags = {"lf", "wtb", "looking for"}
-- MIGHT NEED THIS ONE LATER 
-- EC.EnchanterTags = {"enchant", "enchanter"}

-- ******IMPORTANT******
-- You can't have just a token number be part of the pattern or it will wrongly match on item links
-- ie "spellpower to weapon,40" will match LF JC [Relentless Earthstorm Diamond] due to the "40"
-- if instead of "40" it would be "+40" or "40+" thats okay
EC.RecipeTags={
	enGB = langSplit({
	["Enchant 2H Weapon - Major Agility"] = "Enchant 2H Weapon - Major Agility,35 agi,35+ agi",
	--["Enchant 2H Weapon - Major Intellect"] = "",
	--["Enchant 2H Weapon - Major Spirit"] = " ",
	["Enchant 2H Weapon - Savagery"] = "Enchant 2H Weapon - Savagery,savagery",
	["Enchant Boots - Boar's Speed"] = "Enchant Boots - Boar's Speed,boar",
	["Enchant Boots - Cat's Swiftness"] = "Enchant Boots - Cat's Swiftness,cats,cat's,cat swift",
	["Enchant Boots - Dexterity"] = "Enchant Boots - Dexterity,dex to boots,dex to feet,12 agi to boots,12 agi to feet,12 agi boot,dexterity to boot,boots agil",
	["Enchant Boots - Fortitude"] = "Enchant Boots - Fortitude,fortitude to boots,fortitude to feet,fort to boots,fort boot,fort to feet,12 stam to boot,boots stamina",
	["Enchant Boots - Minor Speed"] = "Enchant Boots - Minor Speed,minor speed,speed to boot,speed to feet,minor move speed,minor movespeed",
	["Enchant Boots - Surefooted"] = "Enchant Boots - Surefooted,surefoot",
	["Enchant Boots - Vitality"] = "Enchant Boots - Vitality,vitality to feet,vitality to boots",
	["Enchant Bracer - Assault"] = "Enchant Bracer - Assault,bracers assault,assault to bracer,bracers assault,24 ap,24 attack power,ap to bracer",
	["Enchant Bracer - Brawn"] = "Enchant Bracer - Brawn,12 strength,12 str,brawn", 
	["Enchant Bracer - Fortitude"] = "Enchant Bracer - Fortitude,fortitude to wrist,fortitude to bracer,12 stam to bracers,12 stam to wrist,12 stamina to wrist,12 stamina to bracer",
	["Enchant Bracer - Healing Power"] = "Enchant Bracer - Healing Power,24 healing,24 heal,healing power to wrist,healing power to bracer",
	["Enchant Bracer - Major Defense"] = "Enchant Bracer - Major Defense,12 def,def to bracer,def to wrist,defense to bracer",
	["Enchant Bracer - Major Intellect"] = "Enchant Bracer - Major Intellect,12 int to wrist,12 int to bracer,major intellect to bracer,major intellect to wrist",
	["Enchant Bracer - Restore Mana Prime"] = "Enchant Bracer - Restore Mana Prime,mp5 to wrist,mp5 to bracer,restore mana prime",
	["Enchant Bracer - Spellpower"] = "Enchant Bracer - Spellpower,sp to wrist,sp to bracer,spell damage to wrist,spell damage to bracer,spelldamage to wrist,spelldamage to bracer,spellpower to wrist,spellpower to bracer,15sp,15 sp,bracer spell",
	["Enchant Bracer - Stats"] = "Enchant Bracer - Stats,stats to bracer,stats to wrist",
	["Enchant Bracer - Superior Healing"] = "Enchant Bracer - Superior Healing,healing to bracer,healing to wrist,heal to bracer,heal to wrist,superior healing bracer,30 healing to bracer,30 healing bracer,30 healing wrist,30 healing to wrist",
	--["Enchant Bracer - Superior Stamina"] = " ",
	--["Enchant Chest - Defense"] = " ",
	["Enchant Chest - Exceptional Health"] = "Enchant Chest - Exceptional Health,150 hp,150hp,exceptional health,health to chest,150 health,150+ health",
	--["Enchant Chest - Exceptional Mana"] = " ",
	["Enchant Chest - Exceptional Stats"] = "Enchant Chest - Exceptional Stats,6 stat,exceptional stats",
	["Enchant Chest - Greater Stats"] = "Enchant Chest - Greater Stats,+4 stat,greater stat,4+ chest,4+ to chest,4 to chest,4 stat",
	["Enchant Chest - Major Resilience"] = "Enchant Chest - Major Resilience,resil to chest,15 resil,major resilience,resil chest,15 res,15+ res,res to chest,res chest,15 resil to chest,major resil",
	--["Enchant Chest - Major Spirit"] = " ",
	["Enchant Chest - Restore Mana Prime"] = "Enchant Chest - Restore Mana Prime,mp5 to chest",
	["Enchant Cloak - Dodge"] = "Enchant Cloak - Dodge,dodge",
	["Enchant Cloak - Greater Agility"] = "Enchant Cloak - Greater Agility,greater agility to back,greater agility to cloak,12 agi to back,12 agi to cloak,12 agility to cloak,12 agility to back,agi to cloak,agility to cloak,agility to back",
	["Enchant Cloak - Greater Arcane Resistance"] = "Enchant Cloak - Greater Arcane Resistance,arcane res",
	["Enchant Cloak - Greater Fire Resistance"] = "Enchant Cloak - Greater Fire Resistance,fire res",
	["Enchant Cloak - Greater Nature Resistance"] = "Enchant Cloak - Greater Nature Resistance,nature res",
	["Enchant Cloak - Greater Shadow Resistance"] = "Enchant Cloak - Greater Shadow Resistance,shadow res",
	["Enchant Cloak - Major Armor"] = "Enchant Cloak - Major Armor,major armor,120 armor,120 armour,120+",
	["Enchant Cloak - Major Resistance"] = "Enchant Cloak - Major Resistance,major resis,7 resis",
	["Enchant Cloak - Spell Penetration"] = "Enchant Cloak - Spell Penetration,spell pen,pen to cloak,pen to back",
	["Enchant Cloak - Stealth"] = "Enchant Cloak - Stealth,stealth",
--	["Enchant Cloak - Steelweave"] = " ",
	["Enchant Cloak - Subtlety"] = "Enchant Cloak - Subtlety,subtlety,2%",
	["Enchant Gloves - Advanced Herbalism"] = "Enchant Gloves - Advanced Herbalism,advanced herb,herb to hand,herb to glove,+herb,herbalism to hand,herbalism to glove",
	["Enchant Gloves - Advanced Mining"] = "Enchant Gloves - Advanced Mining,advanced mining,mining to hand, mining to glove",
	["Enchant Gloves - Assault"] = "Enchant Gloves - Assault,assault to glove,assault to hand,gloves assault,glove assault,26 ap,26 attack power",
	["Enchant Gloves - Blasting"] = "Enchant Gloves - Blasting,blasting to gloves,blasting to hands,crit to glove,crit to hand",
	["Enchant Gloves - Fire Power"] = "Enchant Gloves - Fire Power,fire power,20 fire",
	["Enchant Gloves - Frost Power"] = "Enchant Gloves - Frost Power,frost power,20 frost",
	--["Enchant Gloves - Healing Power"] = "Enchant Gloves - Healing Power,",
	["Enchant Gloves - Major Healing"] = "Enchant Gloves - Major Healing,35 heal,healing to glove,healing to hand,heal to glove,heal to hand",
	["Enchant Gloves - Major Spellpower"] = "Enchant Gloves - Major Spellpower,sp to hand,20sp to glove,20 sp to glove,20+ sp to glove,20sp glove,",
	["Enchant Gloves - Major Strength"] = "Enchant Gloves - Major Strength,major str,15 str,15+ str,str glove",
	["Enchant Gloves - Riding Skill"] = "Enchant Gloves - Riding Skill,riding speed,riding skill,+riding",
	["Enchant Gloves - Shadow Power"] = "Enchant Gloves - Shadow Power,shadow power,20 shadow",
	["Enchant Gloves - Spell Strike"] = "Enchant Gloves - Spell Strike,spell strike,hit to glove,hit to hand,15 hit,15 spell hit",
	["Enchant Gloves - Superior Agility"] = "Enchant Gloves - Superior Agility,superior agility,15 agi,15agi,15+ agi ",
	["Enchant Gloves - Threat"] = "Enchant Gloves - Threat,threat",
	["Enchant Shield - Intellect"] = "Enchant Shield - Intellect,12 int to shield,12 intellect to shield",
	["Enchant Shield - Major Stamina"] = "Enchant Shield - Major Stamina,stam to shield,18 stam,18+ stam,stamina to shield",
	["Enchant Shield - Resilience"] = "Enchant Shield - Resilience,res to shield,resilience to shield,12 res",
	["Enchant Shield - Resistance"] = "Enchant Shield - Resistance",
	["Enchant Shield - Shield Block"] = "Enchant Shield - Shield Block,shield block,15 block,block rating",
	["Enchant Shield - Tough Shield"] = "Enchant Shield - Tough Shield,block value,18 block,18 value",
	["Enchant Weapon - Battlemaster"] = "Enchant Weapon - Battlemaster,battlemaster",
	["Enchant Weapon - Crusader"] = "Enchant Weapon - Crusader,crusader",
	--["Enchant Weapon - Executioner"] = " ",
	["Enchant Weapon - Fiery Weapon"] = "Enchant Weapon - Fiery Weapon,fiery",
	["Enchant Weapon - Healing Power"] = "Enchant Weapon - Healing Power,55 heal,55+",
	["Enchant Weapon - Lifestealing"] = "Enchant Weapon - Lifestealing,lifesteal,life steal",
	["Enchant Weapon - Major Healing"] = "Enchant Weapon - Major Healing,81 heal,81+ heal",
	["Enchant Weapon - Major Intellect"] = "Enchant Weapon - Major Intellect,30 int,30+ int",
	["Enchant Weapon - Major Spellpower"] = "Enchant Weapon - Major Spellpower,40 sp,40 spell,40+ spell",
	--["Enchant Weapon - Major Striking"] = " ",
	--["Enchant Weapon - Mighty Intellect"] = " ",
	["Enchant Weapon - Mighty Spirit"] = "Enchant Weapon - Mighty Spirit,20 spirit,20+ spirit",
	["Enchant Weapon - Mongoose"] = "Enchant Weapon - Mongoose,mongoose",
	["Enchant Weapon - Potency"] = "Enchant Weapon - Potency,potency",
	["Enchant Weapon - Soulfrost"] = "Enchant Weapon - Soulfrost,soulfrost,soul frost",
	["Enchant Weapon - Spell Power"] = "Enchant Weapon - Spell Power,30 sp,30+ sp",
	["Enchant Weapon - Spellsurge"] = "Enchant Weapon - Spellsurge,spellsurge,spell surge",
	["Enchant Weapon - Sunfire"] = "Enchant Weapon - Sunfire,sunfire,sun fire",
	--["Enchant Weapon - Superior Striking"] = " ",
	["Enchant Weapon - Greater Agility"] = "Enchant Weapon - Greater Agility,20 agi",
	["Superior Mana Oil"] = "Superior Mana Oil",
	["Superior Wizard Oil"] = "Superior Wizard Oil",
	--["Enchant Weapon - Deathfrost"] = " ",
	}),
}