local INVALID_DOORS = {1210, 1213, 1219, 1221, 1223, 1225, 1227, 1229, 1232, 1235, 
			1237, 1241, 1243, 1245, 1247, 1249, 1250, 1253, 1255, 1257, 1261}
			
local VALID_DOORS = {1209, 1212, 1231, 1234, 1249, 1252}

function onUse(cid, item, frompos, item2, topos)
	if (item.actionid > 0 and item.actionid == item2.actionid) then
		match = 1
	else
		match = 0
	end
	
	if (isInArray(item2.itemid, INVALID_DOORS)) then
		if (match == 1) then
			doTransformItem(item2.uid, item2.itemid + 1)
		else
			doPlayerSendCancel(cid, "The key does not match.")
		end
	elseif (isInArray(item2.itemid, VALID_DOORS)) then
		if (match == 1) then
			doTransformItem(item2.uid, item2.itemid + 2)
		else
			doPlayerSendCancel(cid,"The key does not match.")
		end
	else
		return false
	end

	return true
end