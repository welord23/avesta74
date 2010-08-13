GREETINGS = {'hi', 'welcome', 'greetings', 'hello'}

function hasPlayerLeft(cid)
	if (getDistanceToCreature(cid) > 4) then
		return true
	end

	return false
end

function getNextPlayer()
	if (not(isQueueEmpty())) then
		nextPlayer = getQueuedPlayer()
		if (nextPlayer) then
			if (getDistanceToCreature(nextPlayer) <= 4) then
				setFocus(nextPlayer)
				updateIdle()
				greet(nextPlayer)
				return
			else
				getNextPlayer()
			end
		end
	end
	
	setFocus(0)
	resetIdle()
end

function greet(cid)
	selfSay('Welcome to Edron Furniture Store, ' .. getCreatureName(cid) .. '.')
end

function onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
	unqueuePlayer(cid)
end

function onCreatureMove(cid, oldPos, newPos)
end

function onCreatureSay(cid, type, msg)
	if (getFocus() == 0) then
		if (isGreeting(msg, GREETINGS) and getDistanceToCreature(cid) <= 4) then
			setFocus(cid)
			updateIdle()
			greet(cid)
		end
	else
		if (getFocus() ~= cid and isGreeting(msg, GREETINGS) and getDistanceToCreature(cid) <= 4) then
			selfSay('One moment please, ' .. getCreatureName(cid) .. '.')
			queuePlayer(cid)
		end
		
		if (msgcontains(msg, 'bye') or msgcontains(msg, 'farewell')) then
			selfSay('Good bye.')
			getNextPlayer()
		end
		
		if (msgcontains(msg, 'name')) then
			selfSay('My name is Edvard. I run this store.')
			updateIdle()
		end
		
		if (msgcontains(msg, 'job')) then
			selfSay('Have you moved to a new home? I\'m the specialist for equipping it.')
			updateIdle()
		end
		
		if (msgcontains(msg, 'time')) then
			selfSay('It is ' .. getWorldTime() .. '. Do you need a clock for your house?')
			updateIdle()
		end
		
		if (msgcontains(msg, 'news')) then
			selfSay('You mean my specials, don\'t you?')
			updateIdle()
		end
		
		if (msgcontains(msg, 'special')) then
			selfSay('My offers are permanently extraordinary cheap.')
			updateIdle()
		end
		
		if (msgcontains(msg, 'offer') or 
			msgcontains(msg, 'goods') or 
			msgcontains(msg, 'furniture') or 
			msgcontains(msg, 'equipment')) then
			selfSay('I sell statues, tables, chairs, flowers, pillows, pottery, instruments, decoration, tapestries and containers.')
			updateIdle()
		end
	end
end

function onThink()
	if (getFocus() ~= 0) then
		if (isIdle() or hasPlayerLeft(getFocus())) then
			selfSay('Good bye.')
			getNextPlayer()
		end
	end
end


