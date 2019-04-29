myRequire("common.PopViewManager")

PopView = class("PopView", function()
	return ccui.Layout:create()
end )

function PopView:ctor(size, mask)
	size = size or cc.size(0, 0)
	if mask == nil then
		mask = true
	end
	self:setContentSize(cc.size(SCREEN_WIDTH, SCREEN_HEIGHT))
	self:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self:setBackGroundColor(cc.c3b(0, 0, 0))
	if mask then
		self:setBackGroundColorOpacity(130)
	else
		self:setBackGroundColorOpacity(0)
	end

	self.contentView = ccui.Layout:create()
	self.contentView:setClippingEnabled(true)
	self.contentView:setAnchorPoint(cc.p(0.5, 0.5))
	self:setSize(size)
	self:addChild(self.contentView, 2)

	local function onTouchBegan(touch, event)
		return true
	end

	self.listener = cc.EventListenerTouchOneByOne:create()
	self.listener:setSwallowTouches(true)
	self.listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, self)
end

function PopView:setSize(size)
	self.contentView:setContentSize(size)
	self.contentView:setPosition(cc.p(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2))
end

function PopView:show()
	PopViewManager:addPopView(self)
end

function PopView:dismiss()
	PopViewManager:removePopView(self)
end

function PopView:setAutoDismiss()
	local function onTouchEnded(touch, event)
		local box = self.contentView:getBoundingBox()
		local location = touch:getLocation()

		if not cc.rectContainsPoint(box, location) then
			self:dismiss()
		end
	end

	self.listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
end


