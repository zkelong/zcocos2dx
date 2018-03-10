s_loaded = s_loaded or { }
function myRequire(path)
	s_loaded[path] = true
	return require(path)
end

local AssetsUpdateScene = class("AssetsUpdateScene", function()
    return cc.Scene:create()
end)

function AssetsUpdateScene:ctor()
    self:registGlobalEvt()
end

function AssetsUpdateScene:create()
    local ob = AssetsUpdateScene:new()
    ob:init()
    return ob
end

function AssetsUpdateScene:registGlobalEvt()
    local onEvent = function(evt)
        if evt ==  "enter" then
            self:onEnter()
        elseif evt == "exit" then
            self:onExit()
        end
    end
    self:registerScriptHandler(onEvent)
end

function AssetsUpdateScene:onEnter()
    local updateProgress = function()
        self.progress = self.progress + 0.01
        if self.loadingUi then
            self.loadingUi:setProgress(self.progress)
        end
        if self.progress >= 1 then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.updateProgressT)
        end
    end
    self.updateProgressT = cc.Director:getInstance():getScheduler():scheduleScriptFunc(updateProgress, 0.4, false)
end

function AssetsUpdateScene:onExit()
    if self.updateProgressT then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(elf.updateProgressT)
    end
end

function AssetsUpdateScene:init()
    require("common.LoadingUI")
	self.loadingUi = LoadingUI:create()
    self:addChild(self.loadingUi)
    self.progress = 0
--    require("common.LoadingUI")
--    self.loadingUI = LoadingUI:create()
--    self:addChild(self.loadingUI)
end

return AssetsUpdateScene