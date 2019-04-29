LoginData = {}

LoginData.s_LOGIN_EVENT = "login_receive_event"

function LoginData:init()

end

function LoginData:login(name, password)
    local loginCallback = function(str)
        local values = json.decode(str,1)
        TipsView:getInstance():showMessage(str)
        if values.token and values.token == "123" and values.userid == "123" then
            self:loginSuccess()
        end
    end
    local s_platform = cc.Application:getInstance():getTargetPlatform()
    if s_platform == cc.PLATFORM_OS_IPHONE or s_platform == cc.PLATFORM_OS_IPAD or s_platform == cc.PLATFORM_OS_MAC then
		local luaoc = require("cocos.cocos2d.luaoc")
		local ok = luaoc.callStaticMethod("ThirdSdk", "doLogin", { scriptHandler = loginCallback })
		if not ok then
			TipsView:getInstance():showMessage("some sdk error")
		end
	elseif s_platform == cc.PLATFORM_OS_ANDROID then
		local luaj = require("cocos.cocos2d.luaj")
		local ok = luaj.callStaticMethod("org/cocos2dx/lua/ThirdSdk", "doLogin", { loginCallback }, "(I)Z")
        if not ok then
            TipsView:getInstance():showMessage("some sdk error")
        end
    else
        name = "123"
        password = "123"
        self:accountLogin(name, password)
	end
end

function LoginData:accountLogin(name, password)
    if name == nil or name == "" then
        TipsView:getInstance():showMessage("Please input name")
        return
    end
    if password == nil or password == "" then
        TipsView:getInstance():showMessage("Please input password")
    end
    if name == "123" and password == "123" then
        kl.THelper.dispatchCustomEvent(LoginData.s_LOGIN_EVENT, {success = true})
    else
        TipsView:getInstance():showMessage("Incorrect username or password")
    end
end

function LoginData:loginSuccess()
    kl.THelper.dispatchCustomEvent(LoginData.s_LOGIN_EVENT, {success = true})
    
end

function LoginData:logout()
    local logoutCallback = function()
        self:logoutSuccess()
    end
    local s_platform = cc.Application:getInstance():getTargetPlatform()
    if s_platform == cc.PLATFORM_OS_IPHONE or s_platform == cc.PLATFORM_OS_IPAD or s_platform == cc.PLATFORM_OS_MAC then
		local luaoc = require("cocos.cocos2d.luaoc")
		luaoc.callStaticMethod("ThirdSdk", "doLogout", { scriptHandler = logoutCallback })
	elseif s_platform == cc.PLATFORM_OS_ANDROID then
		local luaj = require("cocos.cocos2d.luaj")
		luaj.callStaticMethod("org/cocos2dx/lua/ThirdSdk", "doLogout", { logoutCallback }, "(I)Z")
        TipsView:getInstance():showMessage("android sdk logout")
    else
        self:logoutSuccess()
        TipsView:getInstance():showMessage("not sdk logout")
	end
end

function LoginData:logoutSuccess()
    myRequire("scene.LoginScene")
    local login = LoginScene:create()
    cc.Director:getInstance():replaceScene(login)
end