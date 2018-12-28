function love.load() -- What LOVE loads on startup (Runs only once)
 require('font')
 require("Functions")
 love.window.setMode(1920, 1080,{resizable=true}) -- sets resolution to fullscreen 
 GameWidth = love.graphics.getWidth() -- gets Width of the screen
 GameHeight = love.graphics.getHeight() -- gets Height of the screen


 Level = {}
 Level.BackGrounds = {love.graphics.newImage("Level1.PNG")}
 Level.Background = Level.BackGrounds[1]
 Level.Ground = 543
 Level.BorderLeft = 0
 Level.BorderRight = GameWidth

 Player = {}
 Player.Moved = false
 Player.Moving = false 
 Player.CurrentFrame = 1 -- Current Frame 
 Player.Frames = 1 -- How Many Frames For Animation
 Player.FramesPerSecond = 5 -- How Many Frames to Draw Per Sec
 Player.AnimationTimer = 0 -- For Counting  Frames
 Player.Gravity = 3 -- How fast the Player will fall
 Player.Velocity = 0 -- how fast the Player Jumps 
 Player.Jump = false -- blocks spamming of jumping
 Player.Direction = 1 -- 1 = Right , -1 = Left 
 Player.Speed = 8 -- how fast the Player moves
 Player.SpeedX = 0
 Player.PreviousPositionX = 1000
 Player.X = 1000 -- X position of Player
 Player.Y = Level.Ground -- Y position of Player
 Player.Sprites = {}
 Player.Sprites.Idle = {love.graphics.newImage("Sprite.PNG")} --Idle
 Player.Sprites.Jump = {love.graphics.newImage('SpriteJump.PNG')} -- Jumping
 Player.Sprites.Run = {love.graphics.newImage("SpriteRun.PNG"), love.graphics.newImage("SpriteRun2.PNG"), love.graphics.newImage("SpriteRun3.PNG")}
 --Music("Steam Gardens.wav")
 Player.Sprite = Player.Sprites.Idle[1]

end
    
function love.update(dt) -- What LOVE updates every frame 
 FPS = love.timer.getFPS()
 dt = 1
 PlayerWidth = Player.Sprite:getWidth()/2 -- Half the Players Width
 PlayerHeight = Player.Sprite:getHeight()/2 -- Half the Players Height


 if Player.X < Level.BorderLeft+PlayerWidth/2 then 
   Player.X = Level.BorderLeft+PlayerWidth/2
elseif Player.X > Level.BorderRight-PlayerWidth/2 then 
   Player.X = Level.BorderRight-PlayerWidth/2
end

if KeyboardInput("a")  then -- when (d) is hit
   Player.Direction = -1 -- Player faces Left
   Player.Frames = 3 
   Player.Moving = true
   --["1"]
   if Player.Moving then 
      Player.AnimationTimer = Player.AnimationTimer + 1
      if Player.AnimationTimer == Player.FramesPerSecond then
         Player.AnimationTimer = 0
         Player.CurrentFrame = Player.CurrentFrame + 1
      end
      if Player.CurrentFrame > Player.Frames then 
         Player.CurrentFrame = 1
        end
    
      Player.SpeedX = - Player.Speed -- Player Speed
      Player.PreviousPositionX = Player.X
      Player.X = Player.X + Player.SpeedX*dt
      if not Player.Jump then 
      Player.Sprite = Player.Sprites.Run[Player.CurrentFrame]
      end
   end
   --["2"]


elseif KeyboardInput("d") then 
Player.Direction = 1 -- Player faces Right
Player.Frames = 3 
Player.Moving = true
--["1"]
if Player.Moving then 
   Player.AnimationTimer = Player.AnimationTimer + 1
   if Player.AnimationTimer == Player.FramesPerSecond then
      Player.AnimationTimer = 0
      Player.CurrentFrame = Player.CurrentFrame + 1
   end
   if Player.CurrentFrame > Player.Frames then 
      Player.CurrentFrame = 1
     end
 
   Player.SpeedX = - Player.Speed -- Player Speed
   Player.PreviousPositionX = Player.X
   Player.X = Player.X - Player.SpeedX*dt
   if not Player.Jump then 
   Player.Sprite = Player.Sprites.Run[Player.CurrentFrame]
 end
end
--["2"]
else
   Player.Moving = false 
   if not Player.Jump and not Player.Moving then
      Player.AnimationTimer = 0 
      Player.Sprite = Player.Sprites.Idle[1]
      end
end


 if KeyboardInput("space") and Player.Jump == false then 
   -- when (space) is hit and Player hasn't jumped
  Player.Jump = true -- Blocks the next jump 
  Player.Sprite = Player.Sprites.Jump[1]
  Player.Velocity = -45 -- Player jumps up
  SoundEffect("Jump.wav")
 end

 Player.Velocity = Player.Velocity + Player.Gravity*dt -- (Velocity + Gravity)
 Player.Y = Player.Y + Player.Velocity*dt -- Player moves up or down (Player Position Y + Velocity )  
 if Player.Y > Level.Ground and Player.Jump then -- if Player position Y is > than Level.Ground then set it to Level.Ground
  Player.Y = Level.Ground
  Player.Sprite = Player.Sprites.Idle[1]
  Player.Jump = false -- Allows Player to jump again 
 elseif Player.Y > Level.Ground and not Player.Jump then 
    Player.Y = Level.Ground
 end

end
    
function love.draw() -- What LOVE draws to the screen
love.graphics.draw(Level.Background)
love.graphics.draw(Player.Sprite,Player.X,Player.Y,0,Player.Direction,1,PlayerWidth,PlayerHeight)
love.graphics.print("FPS: "..FPS,0,0,0,1,1)
end