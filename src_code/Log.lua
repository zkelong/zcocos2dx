--[[
统一打印log模块。
--]]

Log = Log or { }

-- 调试日志，只显示在本地.
function Log.d(fmt, ...)
	tsixi.THelper:log(string.format(tostring(fmt), ...))
end

function Log.setUrl(url)
	Log.url = url
end

function Log.hasUrl()
	return (Log.url and type(Log.url) == "string" and #Log.url > 0)
end

-- 上传到服务器
function Log.send2Server(tb)
	if Log.hasUrl() then
		local xhr = cc.XMLHttpRequest:new()
		xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
		xhr:open("POST", Log.url)
		xhr:registerScriptHandler(function()
			if not (xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207)) then
				-- 上传新手日志失败(尝试传一条本地日志)
				if tonumber(tb.key) == 9999 then
					Log.e("[Upload guide log] (%d) failed. readyState:%d, status:%d", tb.step, xhr.readyState, xhr.status)
				end
			end
		end)

		xhr:send(tsixi.THelper.serialMap2Url(tb))
	end
end

function Log.newData(key)
	local tb = {}
	tb.key = tostring(key or 0)
	if Player and Player._uuid then
		tb.uuid = Player._uuid
	end
	return tb
end

--[[
本地错误日志
key : 9998
msg : 错误内容
--]]
function Log.e(fmt, ...)
	Log.d(fmt, ...)

	local msg = string.format(tostring(fmt), ...)
	if tsixi and tsixi.THelper then
		msg = string.format("%s\nDevice info:\n\t%s\n", msg, tsixi.THelper.getDeviceInfo())
        if LoginData and type(LoginData._name) == type("") and #LoginData._name > 1  then
		    msg = string.format("%s\nname=%s, pwd=%s", msg, LoginData._name, LoginData._pwd or "")
	    end
        msg = string.format("%s date:%s", msg, os.date("%Y-%m-%d %H:%M", os.time()))
	end
	
	local data = Log.newData(9998)
	data.msg = msg
	data.channel = G_PLATFORM.channelID
	data.version = cc.UserDefault:getInstance():getStringForKey("ddt2_version") or "0.0.0"
	
	Log.send2Server(data)
end

--[[
统计激活设备
key  : 1000
--]]
function Log.p(index)
	local data = Log.newData(1000)
	data.channelID = tostring(G_PLATFORM.channelID)
	data.device = tsixi.THelper.getDeviceInfo()
	Log.send2Server(data)
end

--[[
战斗回合信息
key : 9997
bid : 战斗ID
cmd : 技能ID
t   : 技能时间差
--]]
function Log.f(bid, cmd, t)
	local data = Log.newData(9997)

	data.bid = bid
	data.cmd = cmd
	data.ct = t

	Log.send2Server(data)
end

function Log.ee(aMsg, aTraceback)
    local data = {
        dataType = 11,
    }

--    if Player then
--        data.roleID = Player._uuid or ""
--    end

    data.exData =
    {
        msg = tostring(aMsg),
        traceBack = debug.traceback()
    }
    local jsonStr = json.encode(data)

    local platform = cc.Application:getInstance():getTargetPlatform()
    if platform == cc.PLATFORM_OS_IPHONE or platform == cc.PLATFORM_OS_IPAD or platform == cc.PLATFORM_OS_MAC then
        -- local luaoc = require("cocos.cocos2d.luaoc")
        -- luaoc.callStaticMethod("ThirdSdk", "doSubmitExtraData", { json = jsonStr })
    elseif platform == cc.PLATFORM_OS_ANDROID then
--        local luaj = require("cocos.cocos2d.luaj")
--        pcall( function()
--            luaj.callStaticMethod("org/cocos2dx/lua/ThirdSdk", "doSubmitExtraData", { jsonStr })
--        end )
    end
end