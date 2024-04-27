function onCreate()
	--[[ if you don't want this script to happen in certain songs, put the song's data folder name in ""
	if songPath == "" then
		dontDoTheScript = true
	else

	end
	]]
	setProperty('skipArrowStartTween', true) 
end

function onCreatePost()
	if not dontDoTheScript then
		for i = 0,3 do
			setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
		end
	end
end

function onSongStart()
	if not dontDoTheScript then
		if opNotes == 0 then
			for i = 0,3 do
				noteTweenAlpha('opponentStrums'..i, i, 0.1, 0.25, 'sineOut')
			end
		end
end
end