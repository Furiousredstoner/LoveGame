function love.load() -- What LOVE loads on startup (Runs only once)
 require('font')
 require("Functions")
 GameWidth = love.graphics.getWidth() -- gets Width of the screen
 GameHeight = love.graphics.getHeight() -- gets Height of the screen
 love.window.setMode(1920, 1080,{resizable=true}) -- sets resolution to fullscreen 

 Player = {}
 Player.Moved = false
 Player.Moving = false 
 Player.CurrentFrame = 1 -- Current Frame 
 Player.Frames = 1 -- How Many Frames For Animation
 Player.FramesPerSecond = 10 -- How Many Frames to Draw Per Sec
 Player.AnimationTimer = 0 -- For Counting  Frames
 Player.Gravity = 3 -- How fast the Player will fall
 Player.Velocity = 0 -- how fast the Player Jumps 
 Player.Jump = false -- blocks spamming of jumping
 Player.Direction = 1 -- 1 = Right , -1 = Left 
 Player.Speed = 8 -- how fast the Player moves
 Player.SpeedX = 0
 Player.PreviousPositionX = 1000
 Player.X = 1000 -- X position of Player
 Player.Y = 500 -- Y position of Player
 Player.Sprites = {}
 Player.Sprites.Idle = {love.graphics.newImage("Sprite.PNG")} --Idle
 Player.Sprites.Jump = {love.graphics.newImage('SpriteJump.PNG')} -- Jumping
 Player.Sprites.Run = {love.graphics.newImage("SpriteRun.PNG"), love.graphics.newImage("SpriteRun2.PNG"), love.graphics.newImage("SpriteRun3.PNG")}
 Music("Steam Gardens.wav")
 Player.Sprite = Player.Sprites.Idle[1]
end
    
function love.update(dt) -- What LOVE updates every frame 
 FPS = love.timer.getFPS()
 dt = 1
 print(Player.CurrentFrame)
 PlayerWidth = Player.Sprite:getWidth()/2 -- Half the Players Width
 PlayerHeight = Player.Sprite:getHeight()/2 -- Half the Players Height

if Player.X ~= Player.PreviousPositionX then
    Player.Moved = true 
else
    Player.Moved = false 
end

 if KeyboardInput("a") then -- when (a) button is hit
  Player.Moving = true 
  Player.Direction = -1 -- Player Faces left 
  Player.Frames = 3
  if Player.Moving == true  and Player.Jump == false then
   Player.AnimationTimer = Player.AnimationTimer + 1
   if Player.AnimationTimer == Player.FramesPerSecond then 
      Player.AnimationTimer = 0 
   Player.CurrentFrame = Player.CurrentFrame + 1
   end
   if Player.CurrentFrame > Player.Frames then 
    Player.CurrentFrame = 1
   end
   Player.Sprite = Player.Sprites.Run[Player.CurrentFrame]
  else
  Player.AnimationTimer = 0
  end
  Player.SpeedX = -Player.Speed -- Player Speed
  Player.PreviousPositionX = Player.X
  Player.X = Player.X + Player.SpeedX*dt
 else 
    Player.Moving = false 
    Player.Sprite = Player.Sprites.Idle[1]
 end

 if KeyboardInput("d") then -- when (d) is hit
  Player.Moving = true 
  Player.Direction = 1 -- Player faces Right
  Player.Frames = 3 
  if Player.Moving == true  and Player.Jump == false then
   Player.AnimationTimer = Player.AnimationTimer + 1
   if Player.AnimationTimer == Player.FramesPerSecond then 
      Player.AnimationTimer = 0 
   Player.CurrentFrame = Player.CurrentFrame + 1
   end
   if Player.CurrentFrame > Player.Frames then 
    Player.CurrentFrame = 1
   end
   Player.Sprite = Player.Sprites.Run[Player.CurrentFrame]
  else
  Player.AnimationTimer = 0
  end
  Player.SpeedX = -Player.Speed -- Player Speed
  Player.PreviousPositionX = Player.X
  Player.X = Player.X - Player.SpeedX*dt
 else 
    Player.Moving = false 
    Player.Sprite = Player.Sprites.Idle[1]
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
 if Player.Y > 500 and Player.Jump then -- if Player position Y is > than 500 then set it to 500
  Player.Y = 500
  Player.Sprite = Player.Sprites.Idle[1]
  Player.Jump = false -- Allows Player to jump again 
 elseif Player.Y > 500 and not Player.Jump then 
    Player.Y = 500
 end

end
    
function love.draw() -- What LOVE draws to the screen
love.graphics.draw(Player.Sprite,Player.X,Player.Y,0,Player.Direction,1,PlayerWidth,PlayerHeight)
love.graphics.print("FPS: "..FPS,0,0,0,1,1)
end