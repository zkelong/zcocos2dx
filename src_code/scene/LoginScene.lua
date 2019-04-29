myRequire("common.TipsView")
myRequire("data.LoginData")
LoginScene = class("LoginScene", function()
    return cc.Scene:create()
end)

function LoginScene:create()
    local x = LoginScene.new()
    x:init()
    return x
end

function LoginScene:ctor()
    self:registGlobalEvt()
end

function LoginScene:registGlobalEvt()
    local onEvent = function(evt)
        if evt == "enter" then
            self:onEnter()
        elseif evt == "exit" then
            self:onExit()
        end
    end
    self:registerScriptHandler(onEvent)
end

function LoginScene:onEnter()
    local loginReceived = function(evt)
        local data = evt._userdata
        if data.success then
            self:loginSuccess()
        else
            TipsView:getInstance():showMessage("Login fail")
        end
    end
	kl.THelper.addCustomEventListener(LoginData.s_LOGIN_EVENT, self, loginReceived)
end

function LoginScene:onExit()

end

function LoginScene:init()
    LoginData:init()
    local visible_size = cc.Director:getInstance():getVisibleSize()
    local bg = ccui.ImageView:create("ui/login/background.jpg")
    bg:setScale(math.max(visible_size.width / 960, visible_size.height / 640))
    bg:setPosition(visible_size.width * 0.5, visible_size.height * 0.5)
    self:addChild(bg)
    local animation = sp.SkeletonAnimation:create("ui/login/login.json", "ui/login/login.atlas", 1)
    animation:addAnimation(60, "animation", true)
	animation:setPosition(visible_size.width * 0.5, visible_size.height * 0.5)
    animation:setScale(math.max(visible_size.width / 960, visible_size.height / 640))
	self:addChild(animation)

    local loginBtn = ccui.Button:create("ui/login/login_btn.png", "ui/login/login_btn.png")
    loginBtn:setScale9Enabled(true)
    loginBtn:setPressedActionEnabled(true)
    loginBtn:setZoomScale(-0.1)
    loginBtn:setTitleText("Login")
    loginBtn:setTitleColor(cc.c3b(0xff,0xc6,0x66))
    loginBtn:setTitleFontSize(20)
    loginBtn:setPosition(visible_size.width * 0.5, 200)
    loginBtn:addClickEventListener(function(sender)
        self:login();
    end)
    self:addChild(loginBtn)
end

function LoginScene:login()
    LoginData:login(name, password)
end

function LoginScene:loginSuccess()
    TipsView:getInstance():showMessage("Login success")
    require_debug("gameHall.GameHallScene")
    local gamehall = GameHallScene:create()
    cc.Director:getInstance():replaceScene(gamehall)
end

return LoginScene