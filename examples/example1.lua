require "ButtonUI"

function love.load()
  bui:newButton("clickme", {"Click me"}, 300, 300, 100, 50, 5, {0, 0, 255})
end

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

function love.draw()
  bui:draw()
end
