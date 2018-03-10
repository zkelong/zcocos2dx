
RandomTips = class("RandomTips", function()
    return ccui.Layout:create()
end)

function RandomTips:ctor()
    local onEvent = function(evt)
        if evt == "enter" then
            self:onEnter()
        elseif evt == "exit" then
            self:onExt()
        end
    end
end

function RandomTips:onEnter()

end

function RandomTips:onEnter()

end

function RandomTips:create()
    local rt = RandomTips.new()
    rt:init()
    return rt
end

function RandomTips:init()
    self._tipsLabel = cc.Label:createWithSystemFont("Hello World", "Arial", 20, cc.c3b(255, 0, 0))
    self._tipsLabel:setMaxLineWidth(700)
    self:addChild(self._tipsLabel)
    self:setContentSize(self._tipsLabel:getContentSize())
    self._tipsLabel:setPosition(self._tipsLabel:getContentSize().width / 2, self._tipsLabel:getContentSize().height / 2)
end

return RandomTips