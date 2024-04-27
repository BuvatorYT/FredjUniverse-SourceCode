local visible = true  -- on or off

local ratingGrab = {'sick', 'good', 'bad', 'shit'} -- What it'll grab
local numPrefix = 'num'                -- Easier to change numbers 
local numSuffix = ''

local missType = 'miss'

local defaultPosRating = {0, 0}  
local defaultPosNum = {0, 0}     


local ratingScale = {0.35, 0.35}        -- You can guess what these are for | DEFAULT: rating = 0.35, 0.35 | num = 0.3, 0.3
local numScale = {0.3, 0.3}             -- IF you mess with the numScale, be sure to adjust it's spacing down below as they might overlap

-- Modes (Player) --

local directNums = false   -- Combo numbers appear under ratings 

local simpleMode = false     -- Only 1 set of numbers and ratings are shown at a time

local stationaryMode = false -- Prevent the Rating hop | Simple mode recommended

local hideRating = false  -- Hides rating, not numbers (who coulda guessed)
local hideNums = true    -- Hides numbers, not ratings (who coulda guessed)

local colorRatings = false  -- Color the ratings based on rating, Sick is blue, good is green, etc
local colorSyncing = false  -- Rating takes color of direction | Overwrites colorRatings
local colorFade = false     -- Fades color back to baseColor's value
local fcColorRating = false -- Colors Ratings based on FC level, like andromeda!!! (Turn off others, they overide this)

local colorNumbers = false  -- Same as above, but for numbers
local colorSyncNums = false
local colorFadeNums = false
local fcColorNums = false -- (Turn off others, they overide this)


-- Colors --

-- Best with base ratings --
 
    -- Chad Hex color please --
local sickColor = '68fafc'
local goodColor = '48f048'
local badColor = 'fffecb'
local baseColor = 'ffffff' 

local colorSync0 = 'c24b99' -- left 
local colorSync1 = '68fafc' -- down 
local colorSync2 = '12fa05' -- up   
local colorSync3 = 'f9393f' -- right


local eh = 0        -- Make the sprites load in the way it does
local notePositions = {}
local doThing = false
local pixel = false 

--------------------------------------------------------------------------|The Code Shit|---------------------------------------------------------------------------------------------
-----------------------------------------------------------------------|By Unholywanderer04|------------------------------------------------------------------------------------------

function onCreate() -- bbPantsZoo
    curver = 0

    bit = string.gsub(version,"%.","")
    curver = tonumber(bit)
end

function onDestroy()
    if doThing == false then
        setPropertyFromClass('ClientPrefs', 'hideHud', false) -- (Fail Safe) So the stupid thing actually (hopefully) unhides once you complete a song >:(
    end
end

function onCreatePost()
    if curver >= 60 then 
        doThing = true
    end

    if getPropertyFromClass('PlayState', 'isPixelStage') == true then
        pixel = true
    end

    if pixel == true then 
        ratingGrab[1] = 'pixelUI/sick-pixel' 
        ratingGrab[2] = 'pixelUI/good-pixel'
        ratingGrab[3] = 'pixelUI/bad-pixel' 
        ratingGrab[4] = 'pixelUI/shit-pixel'

        numPrefix = 'pixelUI/num'
        numSuffix = '-pixel'
    
        missType = 'pixelUI/miss-pixel'

        colorSync0 = 'e276ff'
        colorSync1 = '3dcaff'
        colorSync2 = '71e300'
        colorSync3 = 'ff884e'

        sickColor = '3dcaff'
        goodColor = '71e300'

        ratingScale[1], ratingScale[2] = 2.35, 2.35
        numScale[1], numScale[2] = 2.7, 2.7
    end

    if visible == true then -- I don't get this? Why?

    end
end

local begin = false
function onUpdate()
    if not begin then -- initial note thing, constantly gets note pos until you hit a note
        for i = 0, 3 do
            lolX = getPropertyFromGroup('playerStrums', i, 'x')
            lolY = getPropertyFromGroup('playerStrums', i, 'y')
            notePositions[i] = {x = lolX, y = lolY}
        end
    end
        
    if downscroll then
        if not directNums then
            defaultPosNum[1] = (getPropertyFromGroup('playerStrums', 1, 'x' ) + 45)
            defaultPosNum[2] = (getPropertyFromGroup('playerStrums', 0, 'y') - 120)
        end
    else
        if not directNums then
            defaultPosNum[1] = (getPropertyFromGroup('playerStrums', 1, 'x') + 45)
            defaultPosNum[2] = (getPropertyFromGroup('playerStrums', 0, 'y') + 180) 
        end
    end
    
    if visible then
        if doThing == true then
            if getProperty('showRating') ~= false then
                setProperty('showRating', false)
                setProperty('showComboNum', false)
            end
        else    
            setPropertyFromClass('ClientPrefs', 'hideHud', true)
        end
    else
        if doThing == false then
            if getProperty('showRating') ~= true then
                setProperty('showRating', true)
                setProperty('showComboNum', true)
            end
        else    
            setPropertyFromClass('ClientPrefs', 'hideHud', false) 
        end
    end
    
    if (getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.EIGHT')) and doThing == false then
        setPropertyFromClass('ClientPrefs', 'hideHud', false)
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote) 
    if visible == true then
        if not isSustainNote then
            if simpleMode == true then
                eh = 0 -- Keeps 'eh' at 0 so it can't spawn more than one at a time
            end

            begin = true
            updateNotePos(direction)

            -- Took from Whitty mod >:)
            strumTime = getPropertyFromGroup('notes', id, 'strumTime')
            hmm = getRating(strumTime - getSongPosition() + getPropertyFromClass('ClientPrefs','ratingOffset'))

            -- small thing, checks rating color
            ratingColo = ''
            ratiNum = 0

            if hmm == 'sick' then
                ratingColo = sickColor
                ratiNum = 1
            elseif hmm == 'good' then
                ratingColo = goodColor
                ratiNum = 2
            elseif hmm == 'bad' then
                ratingColo = badColor
                ratiNum = 3
            elseif hmm == 'shit' then
                ratingColo = baseColor
                ratiNum = 4
            else
                ratingColo = baseColor
                ratiNum = nil
            end
            
            if hideRating == true then -- so the color gets set based on rating, THEN it removes the rating
                hmm = ''
                ratiNum = nil
            end

            grabby = {colorSync0, colorSync1, colorSync2, colorSync3}
            thisOne = nil
            numUse = nil

            if colorRatings == true and colorSyncing == false then
                thisOne = ratingColo
            elseif colorSyncing == true then
                if hmm ~= 'shit' then thisOne = grabby[direction+1] else thisOne = baseColor end
            elseif fcColorRating == true then
                if getProperty('ratingFC') == 'SFC' then
                    thisOne = sickColor
                elseif getProperty('ratingFC') == 'GFC' then
                    thisOne = goodColor
                elseif getProperty('ratingFC') == 'FC' then
                    thisOne = badColor
                else
                    thisOne = baseColor
                end
            else
                thisOne = baseColor
            end
            
            
            if colorNumbers == true and colorSyncNums == false then
                numUse = ratingColo
            elseif colorSyncNums == true then
                numUse = grabby[direction+1]
            elseif fcColorNums == true then
                if getProperty('ratingFC') == 'SFC' then
                    numUse = sickColor
                elseif getProperty('ratingFC') == 'GFC' then
                    numUse = goodColor
                elseif getProperty('ratingFC') == 'FC' then
                    numUse = badColor
                else
                    numUse = baseColor
                end
            else
                numUse = baseColor
            end

            -------------------------------Ratings---------------------------------------            
            if ratiNum ~= nil then
                makeLuaSprite(hmm ..'ly' .. eh, ratingGrab[ratiNum], notePositions[direction].noteX - 10, notePositions[direction].noteY)
            end

            setProperty(hmm ..'ly'.. eh .. '.color', getColorFromHex(thisOne))

            setObjectCamera(hmm ..'ly' .. eh, 'hud')
            setObjectOrder(hmm ..'ly' .. eh, getObjectOrder('strumLineNotes')-1)
            scaleObject(hmm ..'ly' .. eh, ratingScale[1], ratingScale[2])
            if pixel == true then
                setProperty(hmm ..'ly' .. eh .. '.antialiasing', false)
            end
            addLuaSprite(hmm ..'ly' .. eh, true)
            if stationaryMode == false then
                setProperty(hmm ..'ly' .. eh .. '.acceleration.y', 550)
                setProperty(hmm ..'ly'.. eh ..'.velocity.y', -180)
            end
            doTweenAlpha('nachotweenRatn' .. eh .. hmm, hmm ..'ly' .. eh, 0, 0.2 + (stepCrochet * 0.004), 'quartIn')
            if colorFade == true then
                doTweenColor('coolRatn' .. eh, hmm ..'ly' .. eh, baseColor, 0.2 + (stepCrochet * 0.002), 'quartIn')
            end
            if getProperty(hmm ..'ly'.. eh ..'.alpha') == 0 then -- don't think this works :(, not with the default mode
                removeLuaSprite(hmm ..'ly'.. eh, false)
            end  
            

            eh = eh + 1 -- makes the sprites spawn the way they do

            if eh > 100 then
                eh = 0 -- So it begins to overwrite inital sprites (stops lag)
            end

            -------------------------------Counter---------------------------------------
            bruh = getProperty('combo')
            lol = {}
            uno = table.insert(lol, (math.floor(bruh % 10)))
            dos = table.insert(lol, (math.floor((bruh / 10) % 10)))
            thr = table.insert(lol, (math.floor((bruh / 100) % 10)))
            if bruh >= 1000 then
                fuo = table.insert(lol, (math.floor(bruh / 1000) % 10))
            end
            --------------------------------Numbers----------------------------------------
                               
            if hideNums == false then
                numCount = 1 -- 1 | Lua starts at fuckn 1 soooo
                if bruh >= 10 then numCount = 2 end -- 01
                if bruh >= 100 or foreverComboCount == false then numCount = 3 end -- 001
                if bruh >= 1000 then numCount = 4 end -- 0001

                sequence = nil
                for i = 1, numCount do
                    multBy = (((i - 1) - numCount) * 25)

                    spawn = eh .. i
                    sequence = numPrefix .. lol[i] .. numSuffix  

                    if directNums then
                        makeLuaSprite('num' .. spawn, sequence, (notePositions[direction].numX - multBy), notePositions[direction].numY)
                    else
                        spawn = i -- fixes multiple spawning numbers
                        makeLuaSprite('num' .. spawn, sequence, defaultPosNum[1] - multBy, defaultPosNum[2])
                    end
                    setObjectCamera('num' .. spawn, 'hud')

                    setProperty('num'.. spawn .. '.color', getColorFromHex(numUse))
                    setObjectOrder('num' .. spawn, getObjectOrder('strumLineNotes')-1)
                    if pixel then
                        setProperty('num' .. spawn .. '.antialiasing', false)
                    end
                    scaleObject('num' .. spawn, numScale[1], numScale[2])
                    addLuaSprite('num' .. spawn, true)
                    if not stationaryMode then
                        if directNums then
                            setProperty('num'.. spawn ..'.velocity.y', -160)
                            setProperty('num' .. spawn .. '.acceleration.y', 400)
                        end
                    end
                    if not directNums then
                        runTimer('fuckOffNow', (stepCrochet * 0.008))
                    else
                        doTweenAlpha('nachotweenNumGo' .. eh .. i, 'num' .. spawn, 0, 0.2 + (stepCrochet * 0.008), 'quartIn')
                    end
                    if colorFadeNums == true then
                        doTweenColor('itsjustafad' .. eh .. i, 'num' .. spawn, baseColor, 0.2 + (stepCrochet * 0.006), 'quartIn')
                    end
                end
            end
        end
    end
end

function onTimerCompleted(t, l, ll)
    if t == 'fuckOffNow' then
        for i = 0, 3 do
            doTweenAlpha('nachotweenNumGo' .. i, 'num' .. i, 0, 0.2, 'quartIn')
        end
    end
end

function getRating(diff)
	diff = math.abs(diff)
	if diff <= getPropertyFromClass('ClientPrefs', 'badWindow') then
		if diff <= getPropertyFromClass('ClientPrefs', 'goodWindow') then
			if diff <= getPropertyFromClass('ClientPrefs', 'sickWindow') then
				return 'sick'
			end
			return 'good'
		end
		return 'bad'
	end
	return 'shit'
end

function updateNotePos(direction) -- so a for loop isn't just mashed into functions
    if direction == nil then direction = 3 end
    for i = 0, direction do
        lolX = getPropertyFromGroup('playerStrums', i, 'x')
        if directNums then 
            lulX = getPropertyFromGroup('playerStrums', i, 'x') - 12 else
            lulX = getPropertyFromGroup('playerStrums', 1, 'x') + 45 end
        if downscroll then
            if directNums then
                lolY = getPropertyFromGroup('playerStrums', i, 'y') + 120                    
                lulY = getPropertyFromGroup('playerStrums', i, 'y') + 120
            else
                lolY = getPropertyFromGroup('playerStrums', i, 'y') + 120                    
            end
        else
            lolY = getPropertyFromGroup('playerStrums', i, 'y') + 120 
            if directNums then
                lulY = getPropertyFromGroup('playerStrums', i, 'y') + 180 
            end
        end

        notePositions[i] = {noteX = lolX, noteY = lolY, numX = lulX, numY = lulY}
    end
end