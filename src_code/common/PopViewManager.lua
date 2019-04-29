myRequire("utils.Vector")

PopViewManager = PopViewManager or { }
PopViewManager.POPVIEW_Z = 10000
local popViews = Vector:new()

function PopViewManager:addPopView(view)
	local scene = SceneManager:getCurrentScene()
	if scene == nil then
		return false
	end

	scene:addChild(view, PopViewManager.POPVIEW_Z)
	view:setAnchorPoint(0.5, 0.5)
	view:setPosition(cc.p(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2))

	popViews:pushBack(view)
--	myRequire("guide.GuideManager")
--	GuideManager:onSysEvent("ViewShow", view)
	return true
end

function PopViewManager:getTopView()
	if popViews:size() > 0 then
		return popViews:back()
	end
end

function PopViewManager:removePopView(view)
	local bQueueView = view == self.curQueueView

	popViews:eraseObject(view)
--	myRequire("guide.GuideManager")
--	GuideManager:onSysEvent("ViewDismiss", view)
	view:removeFromParent()

	if bQueueView then
		self.curQueueView = nil
		self:checkQueueNext()
	end
end

function PopViewManager:removeAllPopView(except_cls)
	except_cls = except_cls or ""
	for i = popViews:size(), 1, -1 do
		local view = popViews:at(i)
		if view.__cname ~= except_cls then
			if view.dismiss then
				view:dismiss()
			end
		end
	end

	self:clearQueue()
end

function PopViewManager:clear()
	popViews:clear()
	self:clearQueue()
end

function PopViewManager:removePopViewByTag(tag)
	for key, view in ipairs(popViews) do
		if view:getTag() == tag then
			view:dismiss()
			break
		end
	end
end

function PopViewManager:hasPanel(cls)
	if type(cls) == type("") then
		cls = { cls }
	end
	for i = popViews:size(), 1, -1 do
		local view = popViews:at(i)
		local classname = view.__cname
		if classname and tsixi.THelper.findEleInVec(cls, classname) ~= nil then
			return true
		end
	end
	return false
end

function PopViewManager:pushQueueView(view)
	if not self.viewQueue then
		self.viewQueue = { }
	end

	view:retain()
	table.insert(self.viewQueue, view)

	self:checkQueueNext()
end

function PopViewManager:checkQueueNext()
	if not self.curQueueView and #self.viewQueue > 0 then
		self.curQueueView = self.viewQueue[1]
		table.remove(self.viewQueue, 1)

		self:addPopView(self.curQueueView)
		self.curQueueView:release()
	end
end

function PopViewManager:clearQueue()
	if self.viewQueue then
		for key, var in ipairs(self.viewQueue) do
			var:release()
		end
		self.viewQueue = nil
	end
	self.curQueueView = nil
end

function PopViewManager:getViewByName(name)
	for i, view in ipairs(popViews) do
		if view.__cname == name then
			return view
		end
	end
end

function PopViewManager:getViewByTag(tag)
	for i, view in ipairs(popViews) do
		if view:getTag() == tag then
			return view
		end
	end
end

function PopViewManager:getViewFromQueueByName(name)
	if not self.viewQueue then
		return
	end

	for i, view in ipairs(self.viewQueue) do
		if view.__cname == name then
			return view
		end
	end
end
