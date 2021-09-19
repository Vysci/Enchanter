local TOCNAME,EC=...

--Options
-------------------------------------------------------------------------------------
function EC.UpdateTags()
	for k, v in pairs(EC.DB.Custom) do 
		if v == nil or v == "" then
			local txt = EC.Tool.Combine(EC.RecipeTags["enGB"][k],",")
			EC.DB.Custom[k] = txt
		end
	end

	for k, _ in pairs(EC.DBChar.RecipeList) do
		if EC.DB.Custom[k] ~= nil and EC.DB.Custom[k] ~= "" then
			if EC.DBChar.Debug == true then
				print("Updating recipe: " .. k .. " with custom pattern: " .. EC.DB.Custom[k])
			end
			EC.DBChar.RecipeList[k] = EC.Tool.Split(EC.DB.Custom[k]:lower(),",")
		else
			if EC.DBChar.Debug == true then
				print("Defaulting tags for recipe: " .. k)
			end
			EC.DBChar.RecipeList[k] = EC.RecipeTags["enGB"][k]
		end
	end
end

function EC.UpdateMsg()
	if EC.DB.MsgPrefix == nil or EC.DB.MsgPrefix == "" then
		EC.DB.MsgPrefix = EC.DefaultMsg
	end
end

function EC.OptionsUpdate() 
	EC.UpdateMsg()
	EC.UpdateTags()
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
	
	EC.Options.AddCategory("Search Patterns")
	EC.Options.Indent(10)
	EC.Options.InLine()
	EC.Options.AddSpace()

	-- Message String
	EC.Options.AddEditBox(EC.DB, "MsgPrefix", EC.DB.MsgPrefix, "Message Prefix", 445, 200, false, nil, EC.DB.MsgPrefix)
	EC.Options.AddSpace()

	-- Recipe Tags
	for k,v in pairs(EC.RecipeTags["enGB"]) do
		local txt = EC.Tool.Combine(EC.RecipeTags["enGB"][k],",")
		EC.Options.AddEditBox(EC.DB.Custom, k, txt, k, 445, 200, false, nil, txt)
	end
end
