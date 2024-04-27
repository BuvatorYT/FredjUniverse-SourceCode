function onStepHit()
   if curStep == 832 then
      function opponentNoteHit()
         health = getProperty('health')
         if getProperty('health') > 0.6 then
            setProperty('health', health- 0.027)
         end
      end
   end
end