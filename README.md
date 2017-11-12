# ButtonUI
A button User Interface library for the [Löve Game Engine](https://love2d.org)

## Install
## Getting started

First of all we will need to require the ButtonUI library!
```lua
require "ButtonUI"
```

And next we will need to create a button. There are a lot of options.
```lua
-- (bui = ButtonUI)
bui:newButton(name, {text, textColor, textScale, textFont}, buttonX, buttonY, buttonW, buttonH, buttonRoundness, buttonColor, image, imageScale, imageColor)
```

For now lets just create a simple blue 100, 50 button with the text "Click me" at 300, 300 with the corner roundness of 5.
```lua
function love.load()
  bui:newButton("clickme", {"Click me"}, 300, 300, 100, 50, 5, {0, 0, 255})
end
```

And now lets set the color of the clickme button a bit darker when the user is hovering the button.
```lua
function love.update()
  if bui:hovering("clickme") then
    bui:editButton("clickme", "color", {0, 0, 155})
  else
    bui:editButton("clickme", "color", {0, 0, 255})
  end
end
```

And when the user is clicking the button then we will let a message appear!
```lua
function love.update()
  if bui:hovering("clickme") then
    bui:editButton("clickme", "color", {0, 0, 155})
  else
    bui:editButton("clickme", "color", {0, 0, 255})
  end
  
  if bui:clicking("clickme") then
    love.window.showMessageBox("Hello!", "Thank you for clicking me")
  end
end
```

And finally we will draw our buttons so that we can see them.
```lua
function love.draw()
  bui:draw()
end
```

The full code is also findable in examples/

## Documentation
Functions:

```lua
bui:draw()
--Draws the buttons

bui:newButton(name, {text, textColor, textScale, textFont}, buttonX, buttonY, buttonW, buttonH, buttonRoundness, buttonColor, image, imageScale, imageColor)
--Creates a new button

bui:editButton(name, value, newValue)
--Changes a value in a button

bui:removeButton(name)
--Removes a button

bui:getValue(name, value)
--Gets a value from a button

bui:hovering()
--Gets the hovered button

bui:holding()
--Gets the button holded

bui:clicking()
--Gets the clicked button
```
