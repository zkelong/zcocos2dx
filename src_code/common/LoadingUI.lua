
LoadingUI = class("LoadingUI", function()
    return ccui.Layout:create()
end)

function LoadingUI:ctor()
--    self:registScriptHandler()
end

function LoadingUI:create()
    local ob = LoadingUI.new()
    ob:init()
    return ob
end

function LoadingUI:init()
    local visible_size = cc.Director:getInstance():getVisibleSize()
    self:setContentSize(visible_size)
    -- loading ����
    local bg = ccui.ImageView:create("logo.png")
    bg:setAnchorPoint(0.5, 0.5)
    bg:setPosition(visible_size.width/2, visible_size.height/2)
    bg:setScale(math.max(visible_size.width / 960, visible_size.height / 640))
    self:addChild(bg, -1)
    -- ������
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
    -- ����������--mmddt�еĶ��������ñ���(skinnedmesh-��josn�е�skinnedmesh��Ϊmesh���ɣ����б���flipX��<spine��汾��һ��>)
    self.progress_elves = sp.SkeletonAnimation:create("ui/common/angel4_a.json", "ui/common/angel4_a.atlas", 0.2)
    self.progress_elves:addAnimation(0, "stand", true) --stand
    self.progress_elves:setPosition(6, 10)
    self.progress_elves:setScale(-1, 1)
    progress_bg:addChild(self.progress_elves)
    --�����ʾ
    myRequire("common.RandomTips")
    self.randomTips = RandomTips:create()
    self.randomTips:setPosition(visible_size.width/2, 54)
    self:addChild(self.randomTips)
end

function LoadingUI:setProgress(rate)
    local w = self.progress_size.width * rate
    self.progress_bar:setContentSize(w, self.progress_size.height)
    self.progress_elves:setPosition(10 + w, self.progress_elves:getPositionY())
end


return LoadingUI
