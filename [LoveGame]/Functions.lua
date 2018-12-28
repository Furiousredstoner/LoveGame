function KeyboardInput(Input)
 Input = tostring(Input)
 if love.keyboard.isDown(Input) then 
  return true 
 else
    return false
 end
end

function SoundEffect(Effect)
 local Sound =  love.audio
 Effect = Sound.newSource(Effect , "static")
 Effect:setVolume(1.0)
 Sound.play(Effect)
end

function Music(Song)
 local Sound =  love.audio
 Song = Sound.newSource(Song , "stream")
 Song:setVolume(0.25)
 Sound.play(Song)
end

function Timer(Delay)
    local Time = os.clock()
    while true do 
        if os.clock() > Time + Delay then
            return true 
        end
    end
end