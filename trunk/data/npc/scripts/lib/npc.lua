function getDistanceToCreature(id)
	if id == 0 or id == nil then
		selfGotoIdle()
	end

	local creaturePosition = getCreaturePosition(id)
	cx = creaturePosition.x
	cy = creaturePosition.y
	cz = creaturePosition.z
	if cx == nil then
		return nil
	end

	sx, sy, sz = selfGetPosition()
	return math.max(math.abs(sx - cx), math.abs(sy - cy))
end

function moveToPosition(x,y,z)
	selfMoveTo(x, y, z)
end

function moveToCreature(id)
	if id == 0 or id == nil then
		selfGotoIdle()
	end

	tx, ty, tz = getCreaturePosition(id)
	if tx == nil then
		selfGotoIdle()
	else
		moveToPosition(tx, ty, tz)
	end
end

function selfGotoIdle()
	-- is there any need for this function?
end

function isPlayerPremiumCallback(cid)
	return isPremium(cid) == TRUE and true or false
end

-- keyword is supposed to be lowercase without lowering it
function msgcontains(message, keyword)
	message = string.lower(message)
	if (message == keyword or 										-- exact match
		string.sub(message, 1, string.len(keyword)) == keyword and 
		string.find(message, keyword .. ' ') or 					-- starts with a greeting 
		string.find(message, ' ' .. keyword .. ' ')) then 			-- greeting somewhere in the sentence
		return true
	end
	
	return false
end

function selfSayChannel(cid, message)
	return selfSay(message, cid, FALSE)
end

function doPosRemoveItem(_itemid, n, position)
	local thing = getThingfromPos({x = position.x, y = position.y, z = position.z, stackpos = 1})
	if thing.itemid == _itemid then
		doRemoveItem(thing.uid, n)
	else
		return false
	end
	return true
end

function isInArray2(arr, val)
	for i = 1, table.getn(arr) do
		if (string.find(val, arr[i])) then
			return arr[i]
		end
	end
	
	return nil
end

function isGreeting(message, greetings)
	message = string.lower(message)
	local greeting = isInArray2(greetings, message)
	if (greeting ~= nil) then
		if (msgcontains(message, greeting)) then
			return true
		end
	end
	
	return false
end









