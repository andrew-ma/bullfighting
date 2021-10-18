--[[
    pause_overlay.lua
]] 

local COLORS = require("colors");

local composer = require("composer");
local scene = composer.newScene();

function scene:create(event)
    local sceneGroup = self.view;
    local params = event.params;

    local width = 300;
    local height = 300;
    local backgroundRect = display.newRect(sceneGroup, 0, 0, width, height);
    backgroundRect.anchorX = 0;
    backgroundRect.anchorY = 0;
    backgroundRect:setFillColor(unpack(COLORS["blue"]));
    
end

function scene:show(event)
    local sceneGroup = self.view;
    local phase = event.phase;

    if (phase == "will") then
        print("About to Show Scene 1");

    elseif (phase == "did") then
        print("Finished Showing Scene 1");

        -- If tap anywhere on screen then switch to scene2

        local function onTouchScreen(event)
            if (event.phase == "began") then
                print("Touched screen");
                Runtime:removeEventListener("touch", onTouchScreen);

                -- switch to scene2
                composer.gotoScene("scene1", {
                    effect = "fade",
                    time = 1000,
                    params = {
                        name = "Scene 1"
                    }
                });
            end
        end
        Runtime:addEventListener("touch", onTouchScreen);
    end
end

function scene:hide(event)
    local sceneGroup = self.view;
    local phase = event.phase;

    if (phase == "will") then
        print("About to Hide Scene 2");
    elseif (phase == "did") then
        print("Finished Hiding Scene 2");
    end
end

function scene:destroy(event)
    local sceneGroup = self.view;
    print("About to Destroy Scene 2");

end

scene:addEventListener("create", scene);
scene:addEventListener("show", scene);
scene:addEventListener("hide", scene);
scene:addEventListener("destroy", scene);

return scene;
