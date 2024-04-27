function opponentNoteHit()
       health = getProperty('health')
    if getProperty('health') > 0.6 then
       setProperty('health', health- 0.017)
	end
end
