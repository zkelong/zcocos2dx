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

    
--    self:setTouchEnabled(true) -- �����̵�����¼�, �������EventListenerTouc����
--
    local onTouchBegan = function(touch, event)
        -- ���ϱ��뷵��true����Ч�����Բ������κζ���Ҳ���Ե���
--        print("commonView....touchBegan.....")
        return true
    end
    self.listener = cc.EventListenerTouchOneByOne:create()
    self.listener:setSwallowTouches(true) -- ����¼������ݵ���һ��
    --��������һ������������ listener ��Ч
    self.listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, self)
    --����widget���ܼ�����touchOneByOne��node ����,����widget�ֿ����ˣ�����
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