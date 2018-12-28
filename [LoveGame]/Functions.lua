function KeyboardInput(Input)
 Input = tostring(Input)
 if love.keyboard.isDown(Input) then 
  return true 
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

function Animation(Action , Timer , Frames , CurrentFrame , FPS, Sprite , Entity)
 Action = tostring(Action)
 Timer = Timer + 1
 if Timer == FPS then 
  Timer = 0 
  CurrentFrame = CurrentFrame + 1
 end
 if CurrentFrame > Frames then 
  CurrentFrame = 1
 end
 if Action == "Run" then 
 Sprite = Entity.Sprites.Run[CurrentFrame]
 end
end