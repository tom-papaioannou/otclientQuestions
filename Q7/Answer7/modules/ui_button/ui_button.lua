local window
local button
local refreshBool = true
local firstTime = true  -- For not sceduling event again on an existing button

local function createButton()
    if refreshBool and not window and not button then
        refreshBool = false
        window = g_ui.createWidget('UIWindow', rootWidget)
        window:setSize({width = 75, height = 30})

        button = g_ui.createWidget('UIButton', window)
        button:setText("Jump!")
        button:setSize({width = 75, height = 30})
        button:setBackgroundColor("#808080")  -- Setting the background color to a gray tone
        local posX = (g_window.getDisplaySize().width * (3/5)) - button:getWidth() -- Try to get approximate game window X
        local posY = math.random(g_window.getDisplaySize().height / 5, g_window.getDisplaySize().height * 3 / 5) -- Try to get approximate game window Y
        window:setPosition({x = posX, y = posY})

        local function refreshButton()
            window:destroy()
            button:destroy()
            window = nil  -- Ensure window is nil after destroy
            button = nil  -- Ensure button is nil after destroy
            refreshBool = true
            createButton()
        end

        local function updatePosition()
            if window and button then
                local currentPosition = window:getPosition()
                if currentPosition.x > (g_window.getDisplaySize().width / 5) then
                    window:setPosition({x = currentPosition.x - 5, y = currentPosition.y})  -- Adjusted for more visible movement
                    scheduleEvent(updatePosition, 100)  -- Reschedule the update
                else
                    firstTime = true
                    refreshButton()
                end
            end
        end

        if firstTime then
            scheduleEvent(updatePosition, 100)
            firstTime = false
        end

        button.onClick = refreshButton
    end
end

function init()
    refreshBool = true  -- Reset on init to allow creation
    firstTime = true  -- Reset to ensure creation logic is consistent
    createButton()
end

function terminate()
    if window then window:destroy() end
    if button then button:destroy() end
    window = nil  -- Clear references
    button = nil
    refreshBool = true
    firstTime = true
end
