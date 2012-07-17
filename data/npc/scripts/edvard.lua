
_delay = 750

function getNext()
	nextPlayer = getQueuedPlayer()
	if (nextPlayer ~= nil) then
		if (getDistanceToCreature(nextPlayer) <= 4) then
			setFocus(nextPlayer)
			selfSay('Welcome to Edron Furniture Store, ' .. getCreatureName(cid) .. '.', _delay * 2)
			updateNpcIdle()
			return
		else
			getNext()
		end
	end
	
	setNpcFocus(0)
	resetNpcIdle()
end

function _selfSay(message)
	selfSay(message, _delay)
	updateNpcIdle()
end

function onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
	if (getNpcFocus() == cid) then
		selfSay('Good bye. Recommend us, if you were satisfied with our service.')
		getNext()
	else
		unqueuePlayer(cid)
	end
end

function onCreatureMove(cid, oldPos, newPos)
	if (getNpcFocus() == cid) then
		faceCreature(cid)
		
		if (oldPos.z ~= newPos.z or getDistanceToCreature(cid) > 4) then
			selfSay('Good bye.', _delay)
			getNext()
		end
	else
		if (oldPos.z ~= newPos.z or getDistanceToCreature(cid) > 4) then
			unqueuePlayer(cid)
		end
	end
end

function onCreatureSay(cid, type, msg)
	if (getNpcFocus() == 0) then
		if ((msgcontains(msg, 'hi') or msgcontains(msg, 'hello')) and getDistanceToCreature(cid) <= 4) then
			setNpcFocus(cid)
			updateNpcIdle()
			selfSay('Welcome to Edron Furniture Store, ' .. getCreatureName(cid) .. '.', _delay)
		end
		
	elseif (getNpcFocus() ~= cid) then 
		if ((msgcontains(msg, 'hi') or msgcontains(msg, 'hello')) and getDistanceToCreature(cid) <= 4) then
			selfSay('One moment please, ' .. getCreatureName(cid) .. '.', _delay)
			queuePlayer(cid)
		end
		
	else
		if (msgcontains(msg, 'bye') or msgcontains(msg, 'farewell')) then
			selfSay('Good bye.', _delay)
			getNext()
		
		elseif (msgcontains(msg, 'name')) then
			_selfSay('My name is Edvard. I run this store.')
		
		elseif (msgcontains(msg, 'job')) then
			_selfSay('Have you moved to a new home? I\'m the specialist for equipping it.')
		
		elseif (msgcontains(msg, 'time')) then
			_selfSay('It is ' .. getTibiaTime() .. '. Do you need a clock for your house?')
		
		elseif (msgcontains(msg, 'news')) then
			_selfSay('You mean my specials, don\'t you?')
		
		elseif (msgcontains(msg, 'special')) then
			_selfSay('My offers are permanently extraordinary cheap.')
		
		elseif (msgcontains(msg, 'offer') or msgcontains(msg, 'goods') or 
			msgcontains(msg, 'furniture') or msgcontains(msg, 'equipment')) then
			_selfSay('I sell statues, tables, chairs, flowers, pillows, pottery, instruments, decoration, tapestries and containers.')
		end
	end
end

function onThink()
	if (getNpcFocus() ~= 0) then
		if (isNpcIdle()) then
			selfSay('Good bye.', _delay)
			getNext()
		end
	end
end


