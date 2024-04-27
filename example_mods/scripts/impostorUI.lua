local extraText = ''

function onUpdate(elapsed)
	setProperty('songText.visible',getProperty('timeTxt.visible'))
	setProperty('songText.alpha',getProperty('timeTxt.alpha'))
	setTextString('scoreTxt', 'Score: '..score.. ' | Combo Breaks: '..misses..''..extraText..' | Accuracy: '..round((getProperty('ratingPercent') * 100), 2) ..'% ['..ratingFC..']')
end


function onCreatePost()
	setProperty('timeTxt.visible',false)

	makeLuaText('songText', string.gsub(string.upper(songName), "-", "_"), 0, 42 + (screenWidth/2) - 585 + 10, downscroll and screenHeight - 45+10 or 28)
	setObjectCamera('songText', 'hud')
	setTextBorder('songText', 1, '000000')
	setProperty('songText.alpha', 0)
	setTextSize('songText', 14)
	addLuaText('songText', true)

	setProperty('timeBarBG.color',getColorFromHex('FFFFFF'))
	runHaxeCode([[
		game.timeBar.createFilledBar(0xFF2e412e, 0xFF44d844);
	]])	
	setProperty('timeBar.x',42 + (screenWidth/2) - 585)
	setProperty('scoreTxt.color', getIconColor('dad'))
	setProperty('botplayTxt.color', getIconColor('dad'))
	if songPath == 'finale' then
		setProperty('scoreTxt.color', getColorFromHex('ff1266'))
		setProperty('botplayTxt.color', getColorFromHex('ff1266'))
		setHudVis(false)
	elseif songPath == 'defeat' then
		extraText = '/0'
		setHudVis(false)
		setProperty('scoreTxt.color', getColorFromHex('ff0000'))
		setProperty('botplayTxt.color', getColorFromHex('ff0000'))
	end
end
function setHudVis(vis)
	setProperty('timeBar.visible', vis)
	setProperty('timeBarBG.visible', vis)
	setProperty('timeTxt.visible', vis)
end
function setHudColor(col)
	setProperty('scoreTxt.color', getColorFromHex(col))
	setProperty('botplayTxt.color', getColorFromHex(co))
end
function getIconColor(chr)
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function onUpdatePost(e)
	setProperty('iconP2.origin.x',80)
	setProperty('iconP1.origin.y',0)
	setProperty('iconP1.origin.x',20)
	setProperty('iconP2.origin.y',0)
	setProperty('iconP2.scale.x',mathlerp(getProperty('iconP2.scale.x'), 1, 0.25))
	setProperty('iconP1.scale.x',mathlerp(getProperty('iconP1.scale.x'), 1, 0.25))
end

function mathlerp(from,to,i)
	return from+(to-from)*i
end

function round(x, n)
	n = math.pow(10, n or 0)
	x = x * n
	if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
	return x / n
end