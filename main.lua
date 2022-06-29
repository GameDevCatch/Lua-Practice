
-- Global Values
width, height = love.graphics.getWidth(), love.graphics.getHeight()
gameFont = love.graphics.newFont(40)
score = 0
timeStamp, lastClickedTime = 0, 0

-- On Start
function love.load()
    -- Create random seed from using os clock
    math.randomseed(os.clock())

    -- Create table of targets (Duplicate line: 16 to add more)
    targets =
    {
      Target(0, 0, 30),
    }

    -- Loop through targets and randomize thier Position
    for i = 1, #targets do
      targets[i]:RandomPos()
    end
end

-- On Click
function love.mousepressed(x, y, button, istouch, presses)
    -- On left click
    if button == 1 then
       -- Loop through targets
       for i = 1, #targets do
          -- If mouse hovering over target
          if DistanceBetween(targets[i].x, targets[i].y, x, y) < targets[i].radius then
          -- Add to score and randomize target position  
          score = score + 1
          targets[i]:RandomPos()

          -- Get time since last click
          timeStamp = os.clock() - lastClickedTime
          -- Save time on click
          lastClickedTime = os.clock()
          end
       end 
    end
end

-- Render Graphics
function love.draw()  

 --Draw targets
 for i = 1, #targets do 

  -- If mouse hovering over target change color
   if DistanceBetween(targets[i].x, targets[i].y, love.mouse.getX(), love.mouse.getY()) < targets[i].radius then
    love.graphics.setColor(0, 1, 0)
   else
    love.graphics.setColor(1, 0, 0)
   end

    -- Draw circle
    love.graphics.circle("fill", targets[i].x, targets[i].y, targets[i].radius)
 end

   -- Draw Text
   love.graphics.setColor(1, 1, 1)
   love.graphics.setFont(gameFont)
   love.graphics.print(timeStamp .. "ms", width / 2 - 70, .1)
end

-- Target "Class"
function Target(xPos, yPos, newRadius)
    return 
    {
       x = xPos,
       y = xPos,
       radius = newRadius,

       RandomPos = function(self)
         self.x = math.random(self.radius, width - self.radius)
         self.y = math.random(self.radius, height - self.radius)
       end
    }
end

-- Returns distance between two vectors
function DistanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end
