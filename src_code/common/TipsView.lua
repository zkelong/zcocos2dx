local MOVE_TIME = 0.3
local SHOW_TIME = 1.0

TipsView = class("TipsView", PopView)

local singleInstance = nil

function TipsView:getInstance()
	if singleInstance == nil then
		singleInstance = TipsView.new()
		singleInstance:retain()
	end

	return singleInstance
end

function TipsView:destroyInstance()
	singleInstance:release()
	singleInstance = nil
end

function TipsView:ctor()
	TipsView.super.ctor(self, cc.size(0, 0), false)

	self.node = cc.Node:create()
	self.node:setCascadeOpacityEnabled(true)
	self.node:setPosition(cc.p(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2))
	self.node:setVisible(false)
	self:addChild(self.node)

	local bg = ccui.Scale9Sprite:create("ui/bg_tips.png")
	bg:setCascadeOpacityEnabled(true)
	bg:setOpacity(153)
	bg:setContentSize(cc.size(700, 52))
	bg:setPosition(cc.p(0, 0))
	self.node:addChild(bg)

	self.text = cc.Label:createWithSystemFont("", "Arial", 18, cc.c4b(251, 233, 208, 255))
	self.text:setMaxLineWidth(660)
	self.text:setCascadeOpacityEnabled(true)
	self.text:setPosition(bg:getPosition())
	self.node:addChild(self.text)

    -- 系统字体显示
    self.sysText = cc.Label:createWithSystemFont("", "Arial", 18, cc.c4b(251, 233, 208, 255))
	self.sysText:setMaxLineWidth(660)
	self.sysText:setCascadeOpacityEnabled(true)
	self.sysText:setPosition(bg:getPosition())
	self.node:addChild(self.sysText)

	self.listener:setSwallowTouches(false)
end

function TipsView:showMessage(message, delay, show_time, as_sys)
    show_time = show_time or SHOW_TIME
	local startAction = function()
		local onActionEnd = function()
			self:dismiss()
		end

		local toPos = cc.p(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
		self.node:setOpacity(0)
		self.node:setVisible(true)

		local actMove = cc.MoveTo:create(MOVE_TIME, toPos)
		local actDelay = cc.DelayTime:create(show_time)
		local callback = cc.CallFunc:create(onActionEnd)

		local actSeq = cc.Sequence:create(actMove, actDelay, callback)
		local actFade = cc.FadeIn:create(MOVE_TIME)
		self.node:runAction(actFade)
		self.node:runAction(actSeq)
	end

	self:initWithMessage(message, as_sys)
	delay = delay or 0
	performWithDelay(self, startAction, delay)
end

function TipsView:initWithMessage(message, as_sys)
	self.node:setPosition(cc.p(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 4))
	self.node:setVisible(false)
    if as_sys then
        self.sysText:setString(message)

        self.text:setString("")
    else
	    self.text:setString(message)
         self.sysText:setString("")
    end
	self:dismiss()
	self:show()
    self:setLocalZOrder(PopViewManager.POPVIEW_Z + 10)
	SysSetting.playEffect("audio/sound_tips.mp3")
end