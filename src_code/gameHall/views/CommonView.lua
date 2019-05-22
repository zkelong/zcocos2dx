CommonView = class("CommonView", function() return ccui.Layout:create() end)

function CommonView:ctor(size, mask)
    if mask == nil then
        mask = true
    end
    size = size or cc.size(100, 100)
    self:setContentSize(cc.size(SCREEN_WIDTH, SCREEN_HEIGHT))

    self:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self:setBackGroundColor(cc.c3b(0, 0, 0))
	if mask then
		self:setBackGroundColorOpacity(130)
    else
		self:setBackGroundColorOpacity(0)
    end


    local btn1 = ccui.Button:create("ui/common/btn1.png", "ui/common/btn2.png")--, "ui/common/btn3.png")
    btn1:setScale9Enabled(true)
    btn1:setPressedActionEnabled(true)
    btn1:setZoomScale(-0.1)
    btn1:setTitleText(WORDS["RETURN"])
    btn1:setTitleFontSize(16)
    btn1:setAnchorPoint(1, 1)
    btn1:setContentSize(80, 80)
    btn1:setPosition(self:getContentSize().width - 10, self:getContentSize().height - 10)
    btn1:addClickEventListener(function(sender)
        self:dissmiss()
    end)
    self:addChild(btn1)

    
--    self:setTouchEnabled(true) -- 可以吞掉点击事件, 后面监听EventListenerTouc无用
--
    local onTouchBegan = function(touch, event)
        -- 网上必须返回true才有效？测试不返回任何东西也可以调用
--        print("commonView....touchBegan.....")
        return true
    end
    self.listener = cc.EventListenerTouchOneByOne:create()
    self.listener:setSwallowTouches(true) -- 点击事件不传递到下一层
    --必须设置一个监听，否则 listener 无效
    self.listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, self)
    --昨天widget不能监听到touchOneByOne，node 可以,今天widget又可以了，奇葩
   --]]
end

function CommonView:show()
    local scene = SceneManager:getCurrentScene()
	if scene == nil then
		return false
	end
	scene:addChild(self)
	self:setAnchorPoint(0.5, 0.5)
	self:setPosition(cc.p(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2))
end

function CommonView:dissmiss()
    self:removeFromParent()
end

return CommonView