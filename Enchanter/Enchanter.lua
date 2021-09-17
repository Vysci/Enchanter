local TOCNAME,EC=...
Enchanter_Addon=EC


EC.Initalized = false
EC.PlayerList = {}
EC.LfRecipeList = {}

-- Scans the users known recipes and stores them
-- Additionally it also stores the recipes clickable link, that will be used when messaging the user (for those people asks what are the mats?)
function EC.GetItems()
	EC.DBChar.RecipeList = {}
	EC.DBChar.RecipeLinks = {}

	CastSpellByName("Enchanting")
	for i = 1, GetNumCrafts(), 1 do
        local craftName, _, craftType, numAvailable = GetCraftInfo(i);
		if EC.RecipeTags["enGB"][craftName] ~= nil then 
			EC.DBChar.RecipeLinks[craftName] = GetCraftRecipeLink(i)

			for k,v in pairs(EC.RecipeTags["enGB"][craftName]) do
				EC.DBChar.RecipeList[v:lower()] = craftName
			end
		end
    end
end

function EC.Init()

	-- Initalize options
	if not EnchanterDB then EnchanterDB = {} end -- fresh DB
	if not EnchanterDBChar then EnchanterDBChar = {} end -- fresh DB
	
	EC.DB=EnchanterDB
	EC.DBChar=EnchanterDBChar

	-- Initialize DB Variables if not set
	if not EC.DBChar.RecipeList then EC.DBChar.RecipeList = {} end
	if not EC.DBChar.RecipeLinks then EC.DBChar.RecipeLinks = {} end
	if not EC.DBChar.Stop then EC.DBChar.Stop = false end
	if not EC.DBChar.Debug then EC.DBChar.Debug = false end


	EC.Tool.SlashCommand({"/ec", "/enchanter"},{
		{"scan","MUST BE RAN PRIOR TO /ec start. Scans and stores your enchanting recipes to be used when filter for requests. NOTE: You need to rerun this when you learn new recipes",function()
			EC.GetItems()
			print("Scan Completed")
			end},
		{{"stop", "pause"},"Pauses addon",function()
			EC.DBChar.Stop = true
			print("Paused")
		end},
		{"start","Starts the addon. It will begin parsing chat looking for requests",function()
			EC.DBChar.Stop = false
			print("Started...")
		end},
		{"debug","Enables/Disabled debug messages",function()
			if EC.DBChar.Debug== true then
				EC.DBChar.Debug = false
				print("Debug mode is now off")
			else 
				EC.DBChar.Debug = true
				print("Debug mode is now on")
			end
		end},
		{{"about", "usage"},"You need to first run /ec scan this will store your known recipes and will be parsing chat for them (only need to do it 1 time or if you learned new recipes) after run /ec start to start looking for requests"},
	})

    EC.Initalized = true
end

-- Sends a msg with the enchanting links that enchanter is capable of doing
function EC.SendMsg(name)
		if EC.LfRecipeList[name] ~= nil then
			-- Iterates over the matches requested enchants (that is capable of doing) adds them to the message
			local msg = ""
			for _, v in pairs(EC.LfRecipeList[name]) do 
				msg = msg .. EC.DBChar.RecipeLinks[v]
			end
			SendChatMessage(msg, "WHISPER", nil, name)
			EC.LfRecipeList[name] = nil -- Clearing it so it doesn't growing larger unnecessarily 
		end
end

-- For a message it will attempt to filter the request based on any of the words in EC.PrefixTags
-- If the message contains any of those words it will then attempt to check if any of the users recipes(tags) are contained in the message
-- If their is, it will then invite and message the user with a link to all desired recipes that the enchanter is capable of doing
function EC.ParseMessage(msg, name)
	if EC.Initalized==false or name==nil or name=="" or msg==nil or msg=="" or string.len(msg)<4 or EC.DBChar.Stop == true then
		return
	end

	local isRequestValid = false
	for _, v in pairs(EC.PrefixTags) do 
		if string.find(msg:lower(), "%f[%w_]" .. v .. "%f[^%w_]") then -- Important so it doesn't match things like LFW
			isRequestValid = true
		end
	end

	if isRequestValid == false then return end
	local shouldInvite = false

	-- The storing of the recipe links is really un-needed (leftover from another iteration) but I'm too lazy to change the code
	for k, v in pairs(EC.DBChar.RecipeList) do
		if string.find(msg:lower(), k, 1, true) then
			if not EC.LfRecipeList[name] then EC.LfRecipeList[name] = {} end
			if EC.DBChar.Debug == true then
				print("User should be invited for msg: " .. msg)
				print("Due to tag: " .. k)
			end
			shouldInvite = true
			EC.LfRecipeList[name][v] = v
		end 
	end
	
	if shouldInvite == true then
		-- This check is in case there is a bug and it wrongly matches we don't continue spamming invite to the same user every time they post
		if EC.PlayerList[name] == nil then 
			if EC.DBChar.Debug == true then
				print("Inviting Player: " .. name .. " for request: " .. msg)
			end
			EC.PlayerList[name] = 1
			InviteUnit(name)
			-- Reason for whispering them before the join the group is in case they are already in a group
			EC.SendMsg(name)
		else
			-- Due to the laziness of keeping the whole recipe storage thing, this is an optimization to clear it for users that have already been invited
			EC.LfRecipeList[name] = nil
		end
	end
end


local function Event_CHAT_MSG_CHANNEL(msg,name,_3,_4,_5,_6,_7,channelID,channel,_10,_11,guid)
	if not EC.Initalized then return end
	--[[ To be used later when I add an option to select which channels to parse from
	if channelID ~= 4 then
		EC.ParseMessage(msg, name)
	end
	--]]
	EC.ParseMessage(msg, name)
end

local function Event_ADDON_LOADED(arg1)
	if arg1 == TOCNAME then
		EC.Init()
	end
end

function EC.OnLoad()
    EC.Tool.RegisterEvent("ADDON_LOADED",Event_ADDON_LOADED)
	EC.Tool.RegisterEvent("CHAT_MSG_CHANNEL",Event_CHAT_MSG_CHANNEL)
	EC.Tool.RegisterEvent("CHAT_MSG_SAY",Event_CHAT_MSG_CHANNEL)
	EC.Tool.RegisterEvent("CHAT_MSG_YELL",Event_CHAT_MSG_CHANNEL)
end

