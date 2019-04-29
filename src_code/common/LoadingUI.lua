LoadingUI = class("LoadingUI", function() return ccui.Layout:create() end)

function LoadingUI:create()
    local x = LoadingUI.new()
    x:init()
    return x
end

function LoadingUI:ctor()
    self:registGlobaleEvt()
end

function LoadingUI:registGlobaleEvt()
    local onEvent = function(evt)
        if evt == "enter" then
            self:onEnter()
        elseif evt == "exit" then
            self:onExit()
        end
    end
    self:registerScriptHandler(onEvent)
end

function LoadingUI:onEnter()

end

function LoadingUI:onExit()

end

function LoadingUI:init()
    local visible_size = cc.Director:getInstance():getVisibleSize()
    local bg = ccui.ImageView:create("ui/login/background.jpg")
    bg:setScale(math.max(visible_size.width / 960, visible_size.height / 640))
    bg:setPosition(visible_size.width * 0.5, visible_size.height * 0.5)
    self:addChild(bg)
    local animation = sp.SkeletonAnimation:create("ui/login/login.json", "ui/login/login.atlas", 1)
--    animation:setAnimation(0, "animation", true)
    animation:addAnimation(60, "animation", true)
	animation:setPosition(visible_size.width * 0.5, visible_size.height * 0.5)
    animation:setScale(math.max(visible_size.width / 960, visible_size.height / 640))
	self:addChild(animation)
    -- 进度条
    local progress_bg = ccui.Scale9Sprite:create("ui/common/loading_bg.png")
    self.progress_size = cc.size(770 * visible_size.width / 960, progress_bg:getContentSize().height)
    progress_bg:setContentSize(self.progress_size)
    progress_bg:setAnchorPoint(0.5, 0)
    progress_bg:setPosition(visible_size.width/2, 20)
    self:addChild(progress_bg)
    self.progress_bar = ccui.Layout:create()
    self.progress_bar:setClippingEnabled(true)
    self.progress_bar:setContentSize(0, self.progress_size.height)
    self.progress_bar:setAnchorPoint(0, 0)
    self.progress_bar:setPosition(5, 8)
    progress_bg:addChild(self.progress_bar)
    local progress_bar_img = ccui.Scale9Sprite:create("ui/common/loading_bar.png")
    progress_bar_img:setContentSize(self.progress_size.width - 10, progress_bar_img:getContentSize().height)
    progress_bar_img:setAnchorPoint(0, 0)
    self.progress_bar:addChild(progress_bar_img)
    -- 进度条动画--mmddt有的动画不能用报错(skinnedmesh-将josn中的skinnedmesh改为mesh即可，还有报错flipX的<spine库版本不一样>)
    self.progress_elves = sp.SkeletonAnimation:create("ui/common/angel4_a.json", "ui/common/angel4_a.atlas", 0.2)
    self.progress_elves:addAnimation(0, "stand", true) --stand
    self.progress_elves:setPosition(6, 10)
    self.progress_elves:setScale(-1, 1)
    progress_bg:addChild(self.progress_elves)
end

function LoadingUI:setProgress(rate)
    if rate > 1 then
        rate = 1
    end
    local w = self.progress_size.width * rate
    self.progress_bar:setContentSize(w, self.progress_size.height)
    self.progress_elves:setPosition(10 + w, self.progress_elves:getPositionY())
end

return LoadingUI