function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'nothing' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'nothing'); -- texture path
		end
	end
end
