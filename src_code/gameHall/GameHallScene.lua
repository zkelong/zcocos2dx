--myRequire("common.SpineButton")
--require("common.SpineButton")
myRequire("gameHall.views.CommonView")
GameHallScene = class("GameHallScene", function()
    return cc.Scene:create()
end)

function GameHallScene:ctor()
    self:registGlobalEvt();
end

function GameHallScene:registGlobalEvt()
    local onEvent = function(evt)
        if evt == "enter" then
            self:onEnter()
        elseif evt == "exit" then
            self:onExit()
        end
    end
    self:registerScriptHandler(onEvent)
end

function GameHallScene:onEnter()

end

function GameHallScene:onExit()

end

function GameHallScene:create()
    local ob = GameHallScene.new()
    ob:init()
    return ob
end

function GameHallScene:init()
    self.bg = cc.Sprite:create("ui/scene/gamehall_bg.jpg")
	self.bg:setAnchorPoint(cc.p(0, 0))
	self.bg:setPosition(cc.p(0, 0))

    self.scrollView = ccui.ScrollView:create()    
	self.scrollView:setDirection(ccui.ScrollViewDir.both)
    self.scrollView:setScrollBarEnabled(false)
    self.scrollView:setContentSize(cc.Director:getInstance():getVisibleSize())
    self.scrollView:setInnerContainerSize(self.bg:getContentSize())
    self.scrollView:addChild(self.bg)
    self:addChild(self.scrollView)

    self:initMap()

    local btn1 = ccui.Button:create("ui/common/btn1.png", "ui/common/btn2.png")--, "ui/common/btn3.png")
    btn1:setScale9Enabled(true)
    btn1:setPressedActionEnabled(true)
    btn1:setZoomScale(-0.1)
    btn1:setTitleText(WORDS["LOGOUT"])
    btn1:setTitleFontSize(16)
    btn1:setAnchorPoint(0, 1)
    btn1:setContentSize(80, 80)
    btn1:setPosition(10, self:getContentSize().height - 10)
    btn1:addClickEventListener(function(sender)
        LoginData:logout()
    end)
    self:addChild(btn1)

    local tl = cc.Label:createWithSystemFont("Hello World", "Arial", 20, cc.c3b(255, 0, 0))
    tl:setPosition(100, 100)
    self:addChild(tl)

    local items = {"Label","Text", "Sprite","OneTouch","TestTouch"}
    local scrollView = ccui.ScrollView:create()
    scrollView:setScrollBarEnabled(false)
    scrollView:setDirection(ccui.ScrollViewDir.vertical)
    scrollView:setContentSize(self:getContentSize().width - 100, self:getContentSize().height - 200)
    scrollView:setAnchorPoint(0.5, 0.5)
    scrollView:setPosition(cc.p(self:getContentSize().width * 0.5, self:getContentSize().height * 0.5))
    self:addChild(scrollView)
    local beginX = 0
    local cellWidth = 120
    local cellHeight = 100
    local colNum = 7
    local rowNum = math.ceil(#items / colNum)
    local innerHeight = rowNum * cellHeight
    innerHeight = math.max(innerHeight, scrollView:getContentSize().height)
    scrollView:setInnerContainerSize(cc.size(scrollView:getContentSize().width, innerHeight))
    for k, v in ipairs(items) do
        local btn = ccui.Button:create("ui/common/buttons/small_yellow1.png")
        btn:setTitleText(v)
        btn:setTitleFontSize(16)
        btn.tag = v
        btn:setAnchorPoint(0, 1)
        local index = k - 1
        btn:setPosition(beginX + (index % colNum) * cellWidth, innerHeight - cellHeight * math.floor(index / colNum))
        btn:addClickEventListener(function(sender)
            self:showView(sender.tag)
        end)
        scrollView:addChild(btn)
    end
end

function GameHallScene:showView(viewName)
    print("gameHall.views." .. viewName .. "View")
    local view = require_debug("gameHall.views." .. viewName .. "View")
    local x = view:create()
    x:show()
end

function GameHallScene:initMap()
--    self.runeHouse = SpineButton.new("ui/scene/hall_01", "HOUSE", cc.size(170, 200))
--	self.runeHouse:setPosition(cc.p(906, 850))
--	self.runeHouse:addTouchEndListener(function(sender)
--		self:sdkLogin()
--	end )
--	self.scrollView:addChild(self.runeHouse)

end

return  GameHallScene