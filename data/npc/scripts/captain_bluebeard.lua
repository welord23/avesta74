
_state = 0
_index = 0

destinations = {}
destinations[0] = {name = 'carlin', pos = {x = 32387, y = 31821, z = 7}, price = 110}
destinations[1] = {name = 'ab\'dendriel', pos = {x=32733,y=31668,z=7}, price = 130}
destinations[2] = {name = 'edron', pos = {x = 33175, y = 31764, z = 7}, price = 160}
destinations[3] = {name = 'venore', pos = {x = 32954, y = 32023, z = 7}, price = 170}

function hasPlayerLeft(cid)
	if (getDistanceToCreature(cid) > 4) then
		return true
	end

	return false
end

function getNext()
	if (not(isQueueEmpty())) then
		nextPlayer = getQueuedPlayer()
		if (nextPlayer) then
			if (getDistanceToCreature(nextPlayer) <= 4) then
				setFocus(nextPlayer)
				greet(nextPlayer)
				updateIdle()
				return
			else
				getNext()
			end
		end
	end
	
	setFocus(0)
	resetIdle()
end

function resetState()
	_state = 0
end

function greet(cid)
	local title = 'Sir'
	if (getPlayerSex(cid) == 0) then
		title = 'Madam'
	end
	
	selfSay('Welcome on board, ' .. title .. ' ' .. getCreatureName(cid) .. '.')
end

function _selfSay(message)
	selfSay(message)
	updateIdle()
end

function onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
	if (getFocus() == cid) then
		selfSay('Good bye. Recommend us, if you were satisfied with our service.')
		getNext()
	else
		unqueuePlayer(cid)
	end
end

function onCreatureMove(cid, oldPos, newPos)
	if (getFocus() == cid) then
		faceCreature(cid)
	end
end

function onCreatureSay(cid, type, msg)
	if (getFocus() == 0) then
		if ((msgcontains(msg, 'hi') or msgcontains(msg, 'hello')) and getDistanceToCreature(cid) <= 4) then
			updateIdle()
			setFocus(cid)
			greet(cid)
		end
	else
		if (getFocus() ~= cid and (msgcontains(msg, 'hi') or msgcontains(msg, 'hello')) and getDistanceToCreature(cid) <= 4) then
			selfSay('Just wait, ' .. getCreatureName(cid) .. '.')
			queuePlayer(cid)
		
		elseif (msgcontains(msg, 'bye')) then
			selfSay('Good bye. Recommend us, if you were satisfied with our service.')
			getNext()
		
		elseif (msgcontains(msg, 'name')) then
			_selfSay('My name is Captain Bluebear from the Royal Tibia Line.')
		
		elseif (msgcontains(msg, 'job') or msgcontains(msg, 'captain')) then
			_selfSay('I am the captain of this sailing-ship.')
		
		elseif (msgcontains(msg, 'ship') or msgcontains(msg, 'line') or
				msgcontains(msg, 'company') or msgcontains(msg, 'route') or
				msgcontains(msg, 'tibia')) then
			_selfSay('The Royal Tibia Line connects all seaside towns of Tibia.')
		
		elseif (msgcontains(msg, 'good')) then
			_selfSay('We can transport everything you want.')
		
		elseif (msgcontains(msg, 'passenger')) then
			_selfSay('We would like to welcome you on board.')
		
		elseif (msgcontains(msg, 'trip') or msgcontains(msg, 'passage') or
				msgcontains(msg, 'town') or msgcontains(msg, 'destinantion') or
				msgcontains(msg, 'sail') or msgcontains(msg, 'go')) then
			_selfSay('Where do you want to go? To Carlin, Ab\'Dendriel, Venore, Port Hope or Edron?')
		
		elseif (msgcontains(msg, 'ice') or msgcontains(msg, 'senja') or
				msgcontains(msg, 'folda') or msgcontains(msg, 'vega')) then
			_selfSay('I\'m sorry, but we don\'t serve the routes to the Ice Islands.')
		
		elseif (msgcontains(msg, 'darashia') or msgcontains(msg, 'darama')) then
			_selfSay('I\'m not sailing there. This route is afflicted by a ghostship! However I\'ve heard that Captain Fearless from Venore sails there.')
		
		elseif (msgcontains(msg, 'ghost')) then
			_selfSay('Many people who sailed to Darashia never returned because they were attacked by a ghostship! I\'ll never sail there!')
			
		elseif (msgcontains(msg, 'thais')) then
			_selfSay('This is Thais. Where do you want to go?')
			
		elseif (_state == 1) then
			if (msgcontains(msg, 'yes')) then
				if (not(hasCondition(cid, CONDITION_INFIGHT) == true)) then
					if (isPremium(cid)) then
						if (doPlayerRemoveMoney(cid, destinations[_index].price)) then
							_selfSay('Set the sails!')
							doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
							doTeleportThing(cid, destinations[_index].pos)
							doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
							getNext()
						else
							_selfSay('You don\'t have enough money.')
						end
					else
						_selfSay('I\'m sorry, but you need a premium account in order to travel onboard our ships.')
					end
				else
					_selfSay('First get rid of those blood stains! You are not going to ruin my vehicle!')
					getNext()
				end
			else
				selfSay('We would like to serve you some time.')
			end
			
			resetState()
			
		else
			for n = 0, table.getn(destinations) do
				if (msgcontains(msg, destinations[n].name)) then
					_index = n
					_state = 1
					
					_selfSay('Do you seek a passage to ' .. destinations[_index].name .. ' for ' .. destinations[_index].price .. ' gold?')
					break
				end
			end
		end
	end
end

function onThink()
	if (getFocus() ~= 0) then
		if (isIdle() or hasPlayerLeft(getFocus())) then
			selfSay('Good bye. Recommend us, if you were satisfied with our service.')
			getNext()
		end
	end
end


