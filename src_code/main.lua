
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src_code/")
cc.FileUtils:getInstance():addSearchPath("res/")

--require "config"   -- 调用配置，初始化全局变量()
require "cocos.init"

CC_SHOW_FPS = true

local function main()
    -- lua 垃圾GC设置
    collectgarbage("collect")
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    local director = cc.Director:getInstance()
    local glview = director:getOpenGLView()
    if nil == glview then
        glview = cc.GLViewImpl:createWithRect("Kelong", cc.rect(0, 0, 960, 640))
        director:setOpenGLView(glview)
    end

    director:setAnimationInterval(1.0 / 30)
    -- 设计尺寸，屏幕适配
    local designSize = cc.size(960, 640)
    local resourceSize = cc.size(960, 640)
    director:setContentScaleFactor(resourceSize.height / designSize.height)
    local screenSize = glview:getFrameSize()
    local rate_w = screenSize.width / designSize.width
    local rate_h = screenSize.height / designSize.height
    if rate_w > rate_h then
        glview:setDesignResolutionSize(designSize.width, designSize.height, cc.ResolutionPolicy.FIXED_HEIGHT)
    else
        glview:setDesignResolutionSize(designSize.width, designSize.height, cc.ResolutionPolicy.FIXED_WIDTH)
    end

    --显示FPS
    if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true)
    end

    local header = require("LogoScene")
	local scene = header.create()
	if cc.Director:getInstance():getRunningScene() then
		cc.Director:getInstance():replaceScene(scene)
	else
		cc.Director:getInstance():runWithScene(scene)
	end
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
