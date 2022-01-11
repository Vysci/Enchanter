local TOCNAME,EC=...

--Options
-------------------------------------------------------------------------------------
function EC.UpdateTags()
	-- Undecided if I should keep this in or not
	--[[ 
		for k, v in pairs(EC.DB.Custom) do 
		if v == nil or v == "" then
			local txt = EC.Tool.Combine(EC.RecipeTags["enGB"][k],",")
			EC.DB.Custom[k] = txt
		end
	end
--]]
	for k, _ in pairs(EC.DBChar.RecipeList) do
		if EC.DB.Custom[k] ~= nil and EC.DB.Custom[k] ~= "" then
			EC.DBChar.RecipeList[k] = EC.Tool.Split(EC.DB.Custom[k]:lower(),",")
		end
	end
end

function EC.DefaultCustomTags()

	EC.RecipeTags = EC.DefaultRecipeTags
	for k,v in pairs(EC.RecipeTags["enGB"]) do
		local txt = EC.Tool.Combine(EC.RecipeTags["enGB"][k],",")
		EC.DB.Custom[k] = txt
	end

end

function EC.Default()
	EC.EnchanterTags = EC.DefaultEnchanterTags
	EC.PrefixTags = EC.DefaultPrefixTags
	EC.RecipeTags = EC.DefaultRecipeTags
	EC.DefaultCustomTags()
end

function EC.OptionsUpdate() 

	EC.UpdateTags()
	EC.BlackList = EC.Tool.Split(EC.DB.Custom.BlackList:lower(), ",")
	EC.PrefixTags = EC.Tool.Split(EC.DB.Custom.SearchPrefix:lower(), ",")
	EC.EnchanterTags = EC.Tool.Split(EC.DB.Custom.GenericPrefix:lower(), ",")
end

function EC.OptionsInit ()
	EC.Options.Init(
		function() -- ok button			
			EC.Options.DoOk() 
			EC.OptionsUpdate()	
		end,
		function() -- Chancel/init button
			EC.Options.DoCancel() 
		end, 
		function() -- default button
			EC.Options.DoDefault()
			EC.OptionsUpdate()	
		end
		)
	
	EC.Options.SetScale(0.85)

	-- Tags Tab
	EC.Options.AddPanel("Enchanter",false,true)
	
	EC.Options.AddCategory("General Options")
	EC.Options.Indent(10)
	EC.Options.InLine()
	EC.Options.AddCheckBox(EC.DB, "AutoInvite", true, "Auto Invite")
	EC.Options.AddCheckBox(EC.DB, "NetherRecipes", false, "Disable Nether Recipes")
	EC.Options.AddCheckBox(EC.DB, "WhisperLfRequests", false, "Reply to LF Enchanter requests")
	EC.Options.EndInLine()
	
	-- AFK options
	EC.Options.InLine()
	EC.Options.AddCheckBox(EC.DB, "AfkStop", false, "Automatically stop when AFK")
	EC.Options.AddCheckBox(EC.DB, "AfkStart", false, "Automatically start when no longer AFK")
	EC.Options.EndInLine()	
	
	EC.Options.Indent(-10)	
	EC.Options.AddSpace()
	
	-- Delay timers for auto behavior
	EC.Options.AddEditBox(EC.DB, "WhisperTimeDelay", 0, "WhisperTimeDelay", 50, nil, true)
	EC.Options.AddEditBox(EC.DB, "InviteTimeDelay", 0, "InviteTimeDelay", 50, nil, true)

	EC.Options.AddCategory("Search Patterns")
	EC.Options.Indent(10)
	EC.Options.AddText('Enter your own unique search patterns here. You must use "," (comma) as the seperator with no space after it', 450+200)
	EC.Options.AddSpace()

	-- Message String
	EC.Options.AddEditBox(EC.DB, "MsgPrefix", "I can do ", "Message Prefix", 445, 200, false)
	EC.Options.AddEditBox(EC.DB, "MsgSuffix", "", "Message Suffix", 445, 200, false)

	-- LF Enchanter Msg String
	EC.Options.AddEditBox(EC.DB, "LfWhisperMsg", "What you looking for?", "Generic request wisper message", 445, 200, false)
	EC.Options.AddSpace()

	local prefixTags = EC.Tool.Combine(EC.PrefixTags, ",")
	EC.Options.AddEditBox(EC.DB.Custom, "SearchPrefix", prefixTags, "Prefix to search for", 445, 200, false)

	local genericSearchWords = EC.Tool.Combine(EC.EnchanterTags, ",")
	EC.Options.AddEditBox(EC.DB.Custom, "GenericPrefix", genericSearchWords, "Generic request match phrases", 445, 200, false)

	-- Blacklist
	EC.Options.AddEditBox(EC.DB.Custom, "BlackList", "", "BlackList", 445, 200, false)	
	EC.Options.AddSpace()

	-- Recipe Tags
	for k,v in pairsByKeys(EC.RecipeTags["enGB"]) do
		local txt = EC.Tool.Combine(EC.RecipeTags["enGB"][k],",")
		EC.Options.AddEditBox(EC.DB.Custom, k, txt, k, 445, 200, false)
	end

	EC.OptionsUpdate() 
end

function pairsByKeys (t,f)
	local a = {}
	for n in pairs(t) do table.insert(a,n) end
	table.sort(a,f)
	local i = 0
	local iter = function ()
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end