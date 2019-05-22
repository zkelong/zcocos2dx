s_loaded = s_loaded or { }
function myRequire(path)
	s_loaded[path] = true
	return require(path)
end

myRequire("Require")
local AssetsUpdateScene = class("AssetsUpdateScene", function()
    return cc.Scene:create()
end)

function AssetsUpdateScene:ctor()
    self:registGlobalEvt()
end

function AssetsUpdateScene:create()
    local ob = AssetsUpdateScene:new()
    ob:init()
    return ob
end

function AssetsUpdateScene:registGlobalEvt()
    local onEvent = function(evt)
        if evt ==  "enter" then
            self:onEnter()
        elseif evt == "exit" then
            self:onExit()
        end
    end
    self:registerScriptHandler(onEvent)
end

function AssetsUpdateScene:onEnter()
    myRequire("SystemSetting")
    SystemSetting.loadWords()
    local updateProgress = function()
        self.progress = self.progress + 0.2
        if self.loadingUi then
            self.loadingUi:setProgress(self.progress)
        end
        if self.progress >= 1 then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.updateProgressT)
            self.updateProgressT = nil
            self:gotoLogin()
        end
    end
    self.updateProgressT = cc.Director:getInstance():getScheduler():scheduleScriptFunc(updateProgress, 0.1, false)
end

function AssetsUpdateScene:onExit()
    if self.updateProgressT then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.updateProgressT)
    end
end

function AssetsUpdateScene:init()
    myRequire("common.LoadingUI")
	self.loadingUi = LoadingUI:create()
    self:addChild(self.loadingUi)
    self.progress = 0
end


function AssetsUpdateScene:checkNetwork(as_first)
--	local netwok_connected = self:isNetworkConnected()
	if netwok_connected == 0 then
		print("connect Error!")
	elseif as_first then
        print("ok...")
		if G_GAME_ID then
--			self.state = 101
--			self:pullSomeConfig()
		else
			-- ×ö¼æÈÝ´¦Àí
			self.state = 1
		end
    else
        print("connect ok.......")
	end
end


function AssetsUpdateScene:isNetworkConnected()
	local platform = cc.Application:getInstance():getTargetPlatform()
	if platform == cc.PLATFORM_OS_IPHONE or platform == cc.PLATFORM_OS_IPAD or platform == cc.PLATFORM_OS_MAC then
		local luaoc = require("cocos.cocos2d.luaoc")
		local ok, ret = luaoc.callStaticMethod("TLuaObjectCBridge", "isNetworkConnected")
		if not ok then
			print("luaoc error")
		else
			return ret
		end
	elseif platform == cc.PLATFORM_OS_ANDROID then
		-- for android
		local args = { }
		local sigs = "()I"
		local luaj = require("cocos.cocos2d.luaj")
		local className = "org/cocos2dx/lua/TLuaJavaBridge"
		local ok, ret = luaj.callStaticMethod(className, "isNetworkConnected", args, sigs)
		if not ok then
			print("luaj error:", ret)
		else
			return ret
		end
	end
	return 1
end


function AssetsUpdateScene:pullSomeConfig()
	myRequire("IpConfig")
	g_cannot_update = false
	g_server_config = nil
	local callback = function(datas)
		if datas == nil then
			print("netWork .... Error")
			return
		end
		local code = datas["code"]
		if code ~= 200 then
			print("server.....Error???!")
			return
		end
		local config = datas["config"]
	end
	local datas = { game = nil, package = "com.tsixi.ddt", version = "1.6.56" }
    local urlx = "http://192.168.2.137/qx/center/game.net?type=" .. "1001"
	self:httpPost(urlx, datas, callback)
end

function AssetsUpdateScene:httpPost(url, data, callback, response_type)
	if not url then
		return
	end
	local xhr = cc.XMLHttpRequest:new()
	xhr.responseType = response_type or cc.XMLHTTPREQUEST_RESPONSE_JSON
	xhr:open("POST", url)
	local function onReadyStateChange()
		if xhr.readyState == 4 and(xhr.status >= 200 and xhr.status < 207) then
			local response = xhr.response
			local output = nil
			if response and #response > 0 and xhr.responseType == cc.XMLHTTPREQUEST_RESPONSE_JSON then
				output = json.decode(response, 1)
            else
                output = response
			end
			print(string.format("Http Responds: %s", response))
			callback(output, xhr)
		else
			print(string.format("xhr.readyState is:%s ,xhr.status is:%s", xhr.readyState, xhr.status))
			callback(nil)
		end
	end
	xhr:registerScriptHandler(onReadyStateChange)
	local post_str = self:serialMap2Url(data)
	print("http post data: ", post_str)
	print(string.format("Http POST: %s/%s", url, post_str))
	xhr:send(post_str)
end

function AssetsUpdateScene:serialMap2Url(tb)
	if type(tb) == type( { }) then
		local s = ""
		for key, val in pairs(tb) do
			s = s .. key .. "=" .. val
			s = s .. "&"
		end
		return string.sub(s, 1, #s - 1)
	else
		return tb
	end
end

function AssetsUpdateScene:gotoLogin()
    myRequire("scene.LoginScene")
    local login = LoginScene:create()
    cc.Director:getInstance():replaceScene(login)
end

return AssetsUpdateScene