local LogoScene = class("LogoScene",function()
    return cc.Scene:create()
end)

function LogoScene.create()
    local scene = LogoScene.new()
    return scene
end


function LogoScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self:init()
end


function LogoScene:init()    
    local bg = cc.Sprite:create("logo.png")
    bg:setPosition(self.visibleSize.width * 0.5, self.visibleSize.height * 0.5)
    bg:setScale(self.visibleSize.width /bg:getContentSize().width)
    local logoShowCallback = function(sender)
        local x = require("AssetsUpdateScene")
        local scene = x:create()
        cc.Director:getInstance():replaceScene(scene)
    end
    local action = cc.Sequence:create(
        cc.FadeIn:create(0.5),
        cc.DelayTime:create(1.5),
        cc.CallFunc:create(logoShowCallback)
    )
    bg:runAction(action)
    self:addChild(bg)
end

return LogoScene
