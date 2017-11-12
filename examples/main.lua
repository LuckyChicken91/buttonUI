require "bui"

function love.load()
  numberColor = {255, 255, 255}
  operatorColor = {200, 125, 0}

  x, y = 0, 55
  buttons = 0

  --Create the number buttons
  for i = 9, 1, -1 do
    print(i)
    bui:newButton(i, {i, numberColor}, x, y, 50, 50, 5, {25, 25, 25})
    x = x + 55
    buttons = buttons + 1
    if buttons==3 then
      y = y + 55
      x = 0
      buttons = 0
    end
  end
  bui:newButton(0, {0, numberColor}, x+55, y, 50, 50, 5, {25, 25, 25}) --Create the 0 button

  x = x + 165

  --Create the operator buttons
  bui:newButton("+", {"+", white}, x, y, 50, 50, 5, operatorColor)
  bui:newButton("-", {"-", white}, x, y-55, 50, 50, 5, operatorColor)
  bui:newButton("*", {"*", white}, x, y-110, 50, 50, 5, operatorColor)
  bui:newButton("/", {"/", white}, x, y-165, 50, 50, 5, operatorColor)

  bui:newButton("=", {"=", white}, x, y-165, 50, 50, 5, {100, 0, 0})

  input = ""
  result = ""
end

function love.keypressed(key)
  if key=="return" then
    if pcall(function() assert(loadstring("result = "..input))() end) then --Calculate it via lua
      calculated = true
    else
      input = ""
    end
  elseif key=="backspace" then
    input = input:sub(1, -2)
  else
    if calculated then
      input = ""
      calculated = false
    end

    if key=="+" or key=="-" or key=="*" or key=="/" then
      input = input..key
    else
      if tonumber(key)~=nil then
        input = input..tonumber(key)
      end
    end
  end
end

function love.update()
  clicked = bui:clicking() --Gets the clicked button

  if clicked=="=" then
    if pcall(function() assert(loadstring("result = "..input))() end) then --Calculate it via lua
      calculated = true
    else
      input = ""
    end
  else
    if clicked~=nil then --Is some button clicked?
      if calculated then
        input = ""
        calculated = false
      end
      input = input..clicked
    end
  end
end

function love.draw()
  bui:draw() --Draw the buttons!

  love.graphics.setColor(255, 0, 0)
  love.graphics.print(input, 0, 0)
  love.graphics.print(result, 0, 20)
end
