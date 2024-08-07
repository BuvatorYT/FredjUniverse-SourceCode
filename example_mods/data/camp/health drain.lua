function onStepHit()
   if curStep == 832 then
      function opponentNoteHit()
         health = getProperty('health')
         if getProperty('health') > 0.2 then
            setProperty('health', health- 0.017)
         end
      end
   end
end