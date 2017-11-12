-------------------------------------------------------------------
-- ButtonUI (bui) - A button User Interface library for the Löve Game Engine --
-------------------------------------------------------------------

bui = {}
bui.buttons = {}

function hover(button)
  local mx, my = love.mouse.getPosition()

  if button.roundness==button.w and button.roundness==button.h then
    local dist = (button.x - mx)^2 + (button.y - my)^2
    return dist <= (button.roundness + 1)^2
  else
    if button.image~=nil then
      return mx < button.x+button.image:getWidth()*(button.imageScale or 1)
      and button.x < mx
      and my < button.y+button.image:getHeight()*(button.imageScale or 1)
      and button.y < my
    else
      return mx < button.x+button.w
      and button.x < mx
      and my < button.y+button.h
      and button.y < my
    end
  end
end

function bui:draw()
  r, g, b, a = love.graphics.getColor()

  for i, v in ipairs(bui.buttons) do
    love.graphics.setColor(v.color or {255, 255, 255})
    if v.image~=nil then
      love.graphics.draw(v.image, v.x, v.y, 0, v.imageScale)
    else
      love.graphics.rectangle("fill", v.x, v.y, v.w, v.h, v.roundness)
    end
    if v.text~=nil then
      love.graphics.setFont(v.textFont)
      love.graphics.setColor(v.textColor)
      love.graphics.print(v.text, v.textX, v.textY, 0, v.textScale)
    end
  end

  love.graphics.setColor(r, g, b, a)
end

function bui:newButton(name, text, x, y, w, h, roundness, color, image, imageScale)
  if #text==0 then
    table.insert(bui.buttons, {name = name, text = nil, x = x, y = y, w = w, h = h, roundness = roundness, color = color, image = image, imageScale = imageScale,
      textX = x+(w or image:getWidth())*(imageScale or 1)/2,
      textY = y+(h or image:getHeight())*(imageScale or 1)/2
    })
  else
    table.insert(bui.buttons, {name = name, text = text[1], textColor = text[2] or {255, 255, 255}, textScale = text[3] or 1, textFont = text[4] or love.graphics.getFont(), x = x, y = y, w = w, h = h, roundness = roundness, color = color, image = image, imageScale = imageScale,
      textX = x+(w or image:getWidth())*(imageScale or 1)/2-(text[4] or love.graphics.getFont()):getWidth(text[1])*(text[3] or 1)/2,
      textY = y+(h or image:getHeight())*(imageScale or 1)/2-(text[4] or love.graphics.getFont()):getHeight(text[1])*(text[3] or 1)/2
    })
  end
end

function bui:editButton(name, value, newValue)
  for i, v in ipairs(bui.buttons) do
    if name==v.name then
      v[value] = newValue
    end
  end
end

function bui:removeButton(name)
  for i, v in ipairs(bui.buttons) do
    if name==v.name then
      table.remove(bui.buttons, i)
    end
  end
end

function bui:getValue(name, value)
  for i, v in ipairs(bui.buttons) do
    if name==v.name then
      return v[value]
    end
  end
end

function bui:hovering()
  for i, v in ipairs(bui.buttons) do
    if hover(v) then
      return v.name
    end
  end
end

function bui:holding()
  for i, v in ipairs(bui.buttons) do
    if hover(v) and love.mouse.isDown(1) then
      return v.name
    end
  end
end

do
  local clicked = nil
  local down = nil

  function bui:clicking()
    for i, v in ipairs(bui.buttons) do
      if down and not love.mouse.isDown(1) then
        down = false
        return clicked
      elseif hover(v) and love.mouse.isDown(1) then
        down = true
        clicked = v.name
      end
    end
  end
end
