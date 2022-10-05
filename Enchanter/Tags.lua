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
EC.EnchanterTags = {"lfenchanter", "lookingforenchanter", "anyenchantersonline", "needenchanter", "lfenchpst", "lfench"}

-- ******IMPORTANT******
-- You can't have just a token number be part of the pattern or it will wrongly match on item links
-- ie "spellpower to weapon,40" will match LF JC [Relentless Earthstorm Diamond] due to the "40"
-- if instead of "40" it would be "+40" or "40+" thats okay
EC.RecipeTags={
	enGB = langSplit({
		-- 2H Weapon 
		["Enchant 2H Weapon - Greater Savagery"] = "Enchant 2H Weapon - Greater Savagery,85 ap,85 attack,greater savagery",
		["Enchant 2H Weapon - Major Agility"] = "Enchant 2H Weapon - Major Agility,35 agi,35+ agi",
		["Enchant 2H Weapon - Massacre"] = "Enchant 2H Weapon - Massacre,massacre",
		["Enchant 2H Weapon - Savagery"] = "Enchant 2H Weapon - Savagery",

		-- Staff
		["Enchant Staff - Greater Spellpower"] = "Enchant Staff - Greater Spellpower,spellpower to staff,81 sp,81+ sp",
		["Enchant Staff - Spellpower"] = "Enchant Staff - Spellpower,69 sp,69+ sp",

		-- Weapon
		["Enchant Weapon - Accuracy"] = "Enchant Weapon - Accuracy",
		["Enchant Weapon - Battlemaster"] = "Enchant Weapon - Battlemaster,battlemaster",
		["Enchant Weapon - Berserking"] = "Enchant Weapon - Berserking,berserking",
		["Enchant Weapon - Black Magic"] = "Enchant Weapon - Black Magic,black magic",
		["Enchant Weapon - Crusader"] = "Enchant Weapon - Crusader,crusader",
		["Enchant Weapon - Exceptional Agility"] = "Enchant Weapon - Exceptional Agility,26 agi,exceptional agi",
		["Enchant Weapon - Exceptional Spellpower"] = "Enchant Weapon - Exceptional Spellpower,50 sp,50+ sp,50 spellpower",
		["Enchant Weapon - Exceptional Spirit"] = "Enchant Weapon - Exceptional Spirit",
		["Enchant Weapon - Fiery Weapon"] = "Enchant Weapon - Fiery Weapon,fiery",
		["Enchant Weapon - Giant Slayer"] = "Enchant Weapon - Giant Slayer",
		["Enchant Weapon - Greater Agility"] = "Enchant Weapon - Greater Agility",
		["Enchant Weapon - Greater Potency"] = "Enchant Weapon - Greater Potency,greater potency,50 ap to weapon,weapon 50 ap",
		["Enchant Weapon - Healing Power"] = "Enchant Weapon - Healing Power,55 heal,55+",
		["Enchant Weapon - Icebreaker"] = "Enchant Weapon - Icebreaker",
		["Enchant Weapon - Lifestealing"] = "Enchant Weapon - Lifestealing,lifesteal,life steal",
		["Enchant Weapon - Lifeward"] = "Enchant Weapon - Lifeward",
		["Enchant Weapon - Major Healing"] = "Enchant Weapon - Major Healing,81 heal,81+ heal,major healing weapon,weapon major healing",
		["Enchant Weapon - Major Intellect"] = "Enchant Weapon - Major Intellect,30 int,30+ int",
		["Enchant Weapon - Major Spellpower"] = "Enchant Weapon - Major Spellpower,40 sp,40 spell,40+ spell",
		["Enchant Weapon - Mighty Spellpower"] = "Enchant Weapon - Mighty Spellpower,63 sp,63+ sp",
		["Enchant Weapon - Mighty Spirit"] = "Enchant Weapon - Mighty Spirit,20 spirit,20+ spirit",
		["Enchant Weapon - Mongoose"] = "Enchant Weapon - Mongoose,mongoose",
		["Enchant Weapon - Potency"] = "Enchant Weapon - Potency",
		["Enchant Weapon - Scourgebane"] = "Enchant Weapon - Scourgebane",
		["Enchant Weapon - Soulfrost"] = "Enchant Weapon - Soulfrost,soulfrost,soul frost",
		["Enchant Weapon - Spell Power"] = "Enchant Weapon - Spell Power",
		["Enchant Weapon - Spellsurge"] = "Enchant Weapon - Spellsurge,spellsurge,spell surge",
		["Enchant Weapon - Sunfire"] = "Enchant Weapon - Sunfire,sunfire,sun fire",
		["Enchant Weapon - Superior Potency"] = "Enchant Weapon - Superior Potency,superior potency,65 ap",

		
		--  Shield
		["Enchant Shield - Defense"] = "Enchant Shield - Defense,def to shield,defense to shield,20 def",
		["Enchant Shield - Greater Intellect"] = "Enchant Shield - Greater Intellect,25 int to shield,25 intellect to shield,25 int shield,25 intellect shield",
		["Enchant Shield - Intellect"] = "Enchant Shield - Intellect,12 int to shield,12 intellect to shield,12 int shield,12 intellect shield",
		["Enchant Shield - Major Stamina"] = "Enchant Shield - Major Stamina,stam to shield,18 stam,18+ stam,stamina to shield",
		["Enchant Shield - Resilience"] = "Enchant Shield - Resilience,res to shield,resilience to shield,12 res",
		["Enchant Shield - Resistance"] = "Enchant Shield - Resistance",
		["Enchant Shield - Shield Block"] = "Enchant Shield - Shield Block,shield block,15 block,block rating",
		["Enchant Shield - Tough Shield"] = "Enchant Shield - Tough Shield,block value,18 block,18 value",

		-- Boots
		["Enchant Boots - Assault"] = "Enchant Boots - Assault",
		["Enchant Boots - Boar's Speed"] = "Enchant Boots - Boar's Speed,boar",
		["Enchant Boots - Cat's Swiftness"] = "Enchant Boots - Cat's Swiftness,cats,cat's,cat swift",
		["Enchant Boots - Dexterity"] = "Enchant Boots - Dexterity,dex to boots,dex to feet,12 agi to boots,12 agi to feet,12 agi boot,dexterity to boot",
		["Enchant Boots - Fortitude"] = "Enchant Boots - Fortitude",
		["Enchant Boots - Greater Assault"] = "Enchant Boots - Greater Assault,greater assault to boots,32 ap",
		["Enchant Boots - Greater Fortitude"] = "Enchant Boots - Greater Fortitude,fortitude to boots,fortitude to feet,fort to boot,fort boot,fort to feet,22 stam,boots stamina",
		["Enchant Boots - Greater Spirit"] = "Enchant Boots - Greater Spirit,spirit to boot,greater spirit",
		["Enchant Boots - Greater Vitality"] = "Enchant Boots - Greater Vitality,vitality to feet,vitality to boots",
		["Enchant Boots - Icewalker"] = "Enchant Boots - Icewalker,icewalker,ice walker",
		["Enchant Boots - Minor Speed"] = "Enchant Boots - Minor Speed,minor speed,speed to boot,speed to feet,minor move speed,minor movespeed",
		["Enchant Boots - Superior Agility"] = "Enchant Boots - Superior Agility,16 agi to boots,16 agi to feet,16 agi boot",
		["Enchant Boots - Surefooted"] = "Enchant Boots - Surefooted,surefoot",
		["Enchant Boots - Tuskarr's Vitality"] = "Enchant Boots - Tuskarr's Vitality,tuskarr,15 stam",
		["Enchant Boots - Vitality"] = "Enchant Boots - Vitality",

		-- Bracers
		["Enchant Bracer - Assault"] = "Enchant Bracer - Assault,24 ap,24 attack power",
		["Enchant Bracer - Brawn"] = "Enchant Bracer - Brawn,12 strength,12 str,brawn,str to bracer,strength to bracer", 
		["Enchant Bracer - Fortitude"] = "Enchant Bracer - Fortitude",
		["Enchant Bracer - Healing Power"] = "Enchant Bracer - Healing Power,24 healing,24 heal,healing power to wrist,healing power to bracer",
		["Enchant Bracer - Major Defense"] = "Enchant Bracer - Major Defense,12 def,def to bracer,def to wrist,defense to bracer",
		["Enchant Bracer - Major Intellect"] = "Enchant Bracer - Major Intellect,12 int to wrist,12 int to bracer,major intellect to bracer,major intellect to wrist",
		["Enchant Bracer - Major Stamina"] = "Enchant Bracers - Major Stamina,major stam to wrist,major stam to bracer,major stamina to wrist,major stamina to bracer,40 stam to bracers,40 stam to wrist,40 stamina to wrist,40 stamina to bracer",
		["Enchant Bracer - Restore Mana Prime"] = "Enchant Bracer - Restore Mana Prime,mp5 to wrist,mp5 to bracer,restore mana prime",
		["Enchant Bracer - Spellpower"] = "Enchant Bracer - Spellpower,15sp,15 sp,15 spell power",
		["Enchant Bracer - Stats"] = "Enchant Bracer - Stats",
		["Enchant Bracer - Superior Healing"] = "Enchant Bracer - Superior Healing,healing to bracer,healing to wrist,heal to bracer,heal to wrist,superior healing bracer,30 healing to bracer,30 healing bracer,30 healing wrist,30 healing to wrist",
		["Enchant Bracers - Superior Spellpower"] = "Enchant Bracers - Superior Spellpower,superior spellpower,30sp,30 sp,30 spell power,30 spellpower",
		["Enchant Bracers - Exceptional Intellect"] = "Enchant Bracers - Exceptional Intellect,exceptional int,16 int to bracers",
		["Enchant Bracers - Expertise"] = "Enchant Bracers - Expertise,expertise on glove",
		["Enchant Bracers - Greater Assault"] = "Enchant Bracers - Greater Assault,50 ap to bracer,50 ap to wrist,bracers assault,assault to bracer,bracers assault,50 ap bracer",
		["Enchant Bracers - Greater Spellpower"] = "Enchant Bracers - Greater Spellpower,23sp,23 sp,23 spell power",
		["Enchant Bracers - Greater Stats"] = "Enchant Bracers - Greater Stats,stats to bracer,stats to wrist,6 stat,6 all stat,6 to stat,exceptional stats",
		["Enchant Bracers - Major Spirit"] = "Enchant Bracers - Major Spirit,major spirit,spirit to bracer,spirit to wrist",
		["Enchant Bracers - Striking"] = "Enchant Bracers - Striking,38 ap,38ap",

		-- Chest
		["Enchant Chest - Exceptional Health"] = "Enchant Chest - Exceptional Health,150 hp,150hp,exceptional health,150 health,150+ health",
		["Enchant Chest - Exceptional Mana"] = "Enchant Chest - Exceptional Mana,exceptional mana,mana to chest",
		["Enchant Chest - Exceptional Resilience"] = "Enchant Chest - Exceptional Resilience,resil to chest,20 resil,exceptional resilience,resil chest,20 res,20+ res,res to chest,res chest,20 resil to chest,exceptional resil",
		["Enchant Chest - Exceptional Stats"] = "Enchant Chest - Exceptional Stats,",
		["Enchant Chest - Greater Defense"] = "Enchant Chest - Greater Defense,greater def,def to chest,defense to chest,22 def",
		["Enchant Chest - Greater Mana Restoration"] = "Enchant Chest - Greater Mana Restoration,mp5 to chest",
		["Enchant Chest - Greater Stats"] = "Enchant Chest - Greater Stats,+4 stat,greater stat,4+ chest,4+ to chest,4 to chest,4 stat",
		["Enchant Chest - Major Resilience"] = "Enchant Chest - Major Resilience,15 resil,major resilience,15 res,15+ res,15 resil to chest,major resil",
		["Enchant Chest - Major Spirit"] = "Enchant Chest - Major Spirit,spirit to chest",
		["Enchant Chest - Mighty Health"] = "Enchant Chest - Mighty Health,200 hp,200hp,mighty health,200 health,200+ health",
		["Enchant Chest - Powerful Stats"] = "Enchant Chest - Powerful Stats,10 stat,10 all stat,10 to stat,powerful stats",
		["Enchant Chest - Restore Mana Prime"] = "Enchant Chest - Restore Mana Prime",
		["Enchant Chest - Super Health"] = "Enchant Chest - Super Health,275 hp,275hp,super health,health to chest,275 health,275+ health",
		["Enchant Chest - Super Stats"] = "Enchant Chest - Super Stats,8 stat,8 all stat,8 to stat,super stats,8 to chest",

		-- Cloak
		["Enchant Cloak - Dodge"] = "Enchant Cloak - Dodge,dodge",
		["Enchant Cloak - Greater Agility"] = "Enchant Cloak - Greater Agility",
		["Enchant Cloak - Greater Arcane Resistance"] = "Enchant Cloak - Greater Arcane Resistance,arcane res",
		["Enchant Cloak - Greater Fire Resistance"] = "Enchant Cloak - Greater Fire Resistance,fire res",
		["Enchant Cloak - Greater Nature Resistance"] = "Enchant Cloak - Greater Nature Resistance,nature res",
		["Enchant Cloak - Greater Shadow Resistance"] = "Enchant Cloak - Greater Shadow Resistance,shadow res",
		["Enchant Cloak - Greater Speed"] = "Enchant Cloak - Greater Speed,23 haste,greater speed",
		["Enchant Cloak - Major Agility"] = "Enchant Cloak - Major Agility,major agility to back,major agility to cloak,22 agi to back,22 agi to cloak,22 agility to cloak,22 agility to back",
		["Enchant Cloak - Major Armor"] = "Enchant Cloak - Major Armor,major armor,120 armor,120 armour,120+",
		["Enchant Cloak - Major Resistance"] = "Enchant Cloak - Major Resistance,major resis,7 resis,major res to cloak",
		["Enchant Cloak - Mighty Armor"] = "Enchant Cloak - Mighty Armor,armor to cloak,armor to back,225 armor",
		["Enchant Cloak - Shadow Armor"] = "Enchant Cloak - Shadow Armor,stealth",
		["Enchant Cloak - Speed"] = "Enchant Cloak - Speed,15 haste",
		["Enchant Cloak - Spell Penetration"] = "Enchant Cloak - Spell Penetration",
		["Enchant Cloak - Spell Piercing"] = "Enchant Cloak - Spell Piercing,spell pen,pen to cloak,pen to back,35 spellpen,35 spell pen",
		["Enchant Cloak - Stealth"] = "Enchant Cloak - Stealth",
		["Enchant Cloak - Subtlety"] = "Enchant Cloak - Subtlety,subtlety,2%",
		["Enchant Cloak - Superior Agility"] = "Enchant Cloak - Superior Agility,superior agility to back,superior agility to cloak,16 agi to back,16 agi to cloak,16 agility to cloak,16 agility to back",
		["Enchant Cloak - Titanweave"] = "Enchant Cloak - Titanweave,titanweave,def to back,defense to back,16 def",
		["Enchant Cloak - Wisdom"] = "Enchant Cloak - Wisdom,wisdom",

		-- Gloves
		["Enchant Gloves - Advanced Herbalism"] = "Enchant Gloves - Advanced Herbalism,advanced herb,advance herb,herb to hand,herb to glove,+herb,herbalism to hand,herbalism to glove",
		["Enchant Gloves - Advanced Mining"] = "Enchant Gloves - Advanced Mining,advanced mining,mining to hand, mining to glove",
		["Enchant Gloves - Armsman"] = "Enchant Gloves - Armsman,threat",
		["Enchant Gloves - Assault"] = "Enchant Gloves - Assault",
		["Enchant Gloves - Blasting"] = "Enchant Gloves - Blasting,blasting to gloves,blasting to hands,crit to glove,crit to hand",
		["Enchant Gloves - Crusher"] = "Enchant Gloves - Crusher,44 ap,44 attack power,crusher",
		["Enchant Gloves - Exceptional Spellpower"] = "Enchant Gloves - Exceptional Spellpower,sp to hand,28sp to glove,28 sp to glove,28+ sp to glove,28sp glove,28 sp glove",
		["Enchant Gloves - Expertise"] = "Enchant Gloves - Expertise",
		["Enchant Gloves - Fire Power"] = "Enchant Gloves - Fire Power,fire power,20 fire",
		["Enchant Gloves - Frost Power"] = "Enchant Gloves - Frost Power,frost power,20 frost",
		["Enchant Gloves - Gatherer"] = "Enchant Gloves - Gatherer",
		["Enchant Gloves - Greater Assault"] = "Enchant Gloves - Greater Assault,35 ap,assault to glove,assault to hand,gloves assault,glove assault,35 attack power",
		["Enchant Gloves - Healing Power"] = "Enchant Gloves - Healing Power,+30 healing,30+ heal",
		["Enchant Gloves - Major Agility"] = "Enchant Gloves - Major Agility,20 agi",
		["Enchant Gloves - Major Healing"] = "Enchant Gloves - Major Healing,35 heal,healing to glove,healing to hand,heal to glove,heal to hand",
		["Enchant Gloves - Major Spellpower"] = "Enchant Gloves - Major Spellpower,major spellpower,major spell power,20sp to glove,20 sp to glove,20+ sp to glove,20sp glove",
		["Enchant Gloves - Major Strength"] = "Enchant Gloves - Major Strength,major str,15 str,15+ str,str glove",
		["Enchant Gloves - Precision"] = "Enchant Gloves - Precision,20 hit,20 spell hit,precision,hit to glove",
		["Enchant Gloves - Riding Skill"] = "Enchant Gloves - Riding Skill,riding speed,riding skill,+riding",
		["Enchant Gloves - Shadow Power"] = "Enchant Gloves - Shadow Power,shadow power,20 shadow",
		["Enchant Gloves - Spell Strike"] = "Enchant Gloves - Spell Strike,15 hit,15 spell hit",
		["Enchant Gloves - Superior Agility"] = "Enchant Gloves - Superior Agility,15 agi,15agi,15+ agi",
		["Enchant Gloves - Threat"] = "Enchant Gloves - Threat",

		-- Ring
		["Enchant Ring - Greater Spellpower"] = "Enchant Ring - Greater Spellpower",
		["Enchant Ring - Stamina"] = "Enchant Ring - Stamina",

		-- Oil
		["Superior Mana Oil"] = "Superior Mana Oil",
		["Superior Wizard Oil"] = "Superior Wizard Oil",
	}),
}